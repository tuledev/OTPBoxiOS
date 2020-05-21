//
//  OTPBoxView.m
//  OTPBox
//
//  Created by tuledev on 5/18/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "OTPBoxView.h"
#import "OTPInput/OTPInput.h"
#import "OTPAction/OTPActionView.h"
#import "../Controller/OTPManager.h"

@interface OTPBoxView()

@property (nonatomic, retain) OTPInput * otpInput;
@property (nonatomic, retain) OTPActionView * otpAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOTPInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOTPActionView;
@property (weak, nonatomic) IBOutlet UITextField *tfOTP;

@property (nonatomic, retain) NSString * otpString;
@property (weak, nonatomic) IBOutlet UILabel *lbError;
@property (weak, nonatomic) IBOutlet UILabel *lbLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLloading;

@end

@implementation OTPBoxView 
@synthesize viewInputOTP;

+ (OTPBoxView *)showIn: (UIView *) superview {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPBoxView"
                                                                                owner:self options:nil];
    OTPBoxView *otpBoxView;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPBoxView class]]) {
            otpBoxView = (OTPBoxView *)object;
            break;
        }
    }
    otpBoxView.frame = CGRectMake(0, 0, superview.frame.size.width, superview.frame.size.height);
    
    [superview addSubview:otpBoxView];
    [otpBoxView renderWithConfig];
    [otpBoxView showLoading:NO];
    [otpBoxView showError:@""];
    
    return otpBoxView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [OTPBoxView loadFontWithName:@"Font Awesome 5 Brands-Regular-400"];
    [OTPBoxView loadFontWithName:@"Font Awesome 5 Duotone-Solid-900"];
    [OTPBoxView loadFontWithName:@"Font Awesome 5 Pro-Light-300"];
    [OTPBoxView loadFontWithName:@"Font Awesome 5 Pro-Regular-400"];
    [OTPBoxView loadFontWithName:@"Font Awesome 5 Pro-Solid-900"];
    self.tfOTP.delegate = self;
}

+ (void)loadFontWithName:(NSString *)fontName
{
    NSString *fontPath = [[NSBundle bundleForClass:[OTPBoxView class]] pathForResource:fontName ofType:@"otf"];
    NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    
    if (provider)
    {
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        
        if (font)
        {
            CFErrorRef error = NULL;
            if (CTFontManagerRegisterGraphicsFont(font, &error) == NO)
            {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                CFRelease(errorDescription);
            }
            
            CFRelease(font);
        }
        
        CFRelease(provider);
    }
}

- (void)renderWithConfig {
    self.otpInput = [OTPInput createWithOTPLength:4];
    [self.widthConstraintOTPInputView setConstant:self.otpInput.frame.size.width];
    [self.viewInputOTP addSubview:self.otpInput];
    
    self.otpAction = [OTPActionView createOTPActions];
    [self.widthConstraintOTPActionView setConstant:self.otpAction.frame.size.width];
    [self.viewAction addSubview:self.otpAction];
    [self.tfOTP becomeFirstResponder];
}

- (void)updateOTPCode: (NSString *)otp {
    [self.otpInput updateOTPString:otp];
    [self showError:@""];
    
    if (otp.length == 4) {
        [self requestVerifyOTPCode:otp];
    }
}

- (void)requestVerifyOTPCode: (NSString *)otp {
    [self showLoading:YES];
    __weak OTPBoxView *weakSelf = self;
    [OTPManager verifyOTP:otp callback:^(NSString * _Nonnull error) {
        if (weakSelf != nil) {
            [weakSelf showLoading:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf showError:error];
            });
        }
    }];
}

- (void)showLoading: (BOOL) loading {
    [UIView animateWithDuration:0.25f animations:^{
        self.lbLoading.alpha = loading ? 1 : 0;
        self.activityLloading.alpha = self.lbLoading.alpha;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5f animations:^{
                if (loading) {
                    self.lbLoading.text = @"Đang kiểm tra";
                } else {
                    self.lbLoading.text = @"";
                }
                [self layoutIfNeeded];
            }];
        }
    }];
}

- (void)showError: (NSString *)errorString {
    [UIView animateWithDuration:0.25f animations:^{
        self.lbError.alpha = ([errorString isEqualToString:@""] || errorString == nil) ? 0 : 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.lbError.text = errorString;
                [self layoutIfNeeded];
            }];
        }
    }];
}

- (IBAction)onOKButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(okButtonTapped)]) {
        [self.delegate okButtonTapped];
    }
}

// TEXTFIELD

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8) {
        NSString * otpString = [textField.text substringToIndex:textField.text.length-(textField.text.length>0)];
        [self updateOTPCode:otpString];
        return YES;
    }
    if (textField.text != nil && textField.text.length ==  4) {
        return NO;
    }
    NSString * otpString = [textField.text stringByAppendingString:string];
    [self updateOTPCode:otpString];
    return YES;
}

@end
