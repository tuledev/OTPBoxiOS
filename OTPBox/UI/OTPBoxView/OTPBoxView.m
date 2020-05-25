//
//  OTPBoxView.m
//  OTPBox
//
//  Created by tuledev on 5/18/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "OTPBoxView.h"
#import "../OTPInputView/OTPInputView.h"
#import "../../Controller/OTPManager.h"
#import "../../Utils/UIView+nib.m"
#import "../OTPActionView/OTPActionView.h"
#import "../OTPExpiredView/OTPExpiredView.h"
#import "../OTPReportView/OTPReportView.h"

@interface OTPBoxView()

@property (nonatomic, retain) OTPInputView * otpInput;
@property (nonatomic, retain) OTPActionView * otpAction;
@property (weak, nonatomic) IBOutlet UIView *otpInputContainerView;
@property (weak, nonatomic) IBOutlet UIView *otpBoxContainerView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic, weak) UIView * initLoadingView;
@property (nonatomic, weak) OTPExpiredView * expiredView;
@property (nonatomic, weak) OTPReportView * reportView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOTPInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOTPActionView;
@property (weak, nonatomic) IBOutlet UITextField *tfOTP;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOPTBoxView;

@property (nonatomic, retain) NSString * otpString;
@property (weak, nonatomic) IBOutlet UILabel *lbError;
@property (weak, nonatomic) IBOutlet UILabel *lbLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLloading;

@property (nonatomic) BOOL loading;
@property (nonatomic) BOOL expired;

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
    [otpBoxView showInitLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [otpBoxView removeInitLoading];
    });

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
    self.loading = NO;
    self.expired = NO;
    
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];

}

- (void)removeBox {
    self.alpha = 1;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
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
    self.otpInput = [OTPInputView createWithOTPLength:4];
    [self.widthConstraintOTPInputView setConstant:self.otpInput.frame.size.width];
    [self.viewInputOTP addSubview:self.otpInput];
    
    self.otpAction = [OTPActionView createOTPActionsWithDelegate:self];
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
            if ([error isEqualToString:@""]) {
                [weakSelf removeBox];
            }
            [weakSelf showLoading:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf showError:error];
            });
        }
    }];
}

- (void)showInitLoading {
    if (self.initLoadingView == nil) {
        NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPBoxViewLoading"
                                                                                    owner:self options:nil];
        UIView *initLoadingView;
        for (id object in bundle) {
            if ([object isKindOfClass:[UIView class]]) {
                initLoadingView = (UIView *)object;
                break;
            }
        }
        
        self.initLoadingView = initLoadingView;
    }
    [self.initLoadingView removeFromSuperview];
    self.overlayView.frame = self.initLoadingView.frame;
    [self.overlayView addSubview:self.initLoadingView];
    self.heightConstraintOPTBoxView.priority = 999;
    [self.otpBoxContainerView bringSubviewToFront:self.overlayView];
    self.otpInputContainerView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        self.overlayView.alpha = 1;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }];
}

- (void)removeInitLoading {
    self.heightConstraintOPTBoxView.priority = 200;
    [UIView animateWithDuration:0.35f animations:^{
        [self.otpBoxContainerView layoutIfNeeded];
        self.overlayView.alpha = 0;
        self.otpInputContainerView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.initLoadingView != nil) {
                [self.otpBoxContainerView sendSubviewToBack:self.overlayView];
                [self.initLoadingView removeFromSuperview];
            }
        }
    }];
}

- (void)showExpiredView {
    self.expired = YES;
    if (self.expiredView == nil) {
        NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPBoxExpiredView"
                                                                                    owner:self options:nil];
        OTPExpiredView *expiredView;
        for (id object in bundle) {
            if ([object isKindOfClass:[OTPExpiredView class]]) {
                expiredView = (OTPExpiredView *)object;
                break;
            }
        }
        
        self.expiredView = expiredView;
        self.expiredView.delegate = self;
    }
    [self.expiredView removeFromSuperview];
    [self.expiredView layoutIfNeeded];
    self.overlayView.frame = self.expiredView.frame;
    self.heightConstraintOPTBoxView.priority = 999;
    [self.overlayView addSubview:self.expiredView];
    [self.otpBoxContainerView bringSubviewToFront:self.overlayView];
    self.otpInputContainerView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        self.overlayView.alpha = 1;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }];
}

- (void)removeExpiredView {
    self.heightConstraintOPTBoxView.priority = 200;
    [UIView animateWithDuration:0.35f animations:^{
        [self.otpBoxContainerView layoutIfNeeded];
        self.overlayView.alpha = 0;
        self.otpInputContainerView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.initLoadingView != nil) {
                [self.otpBoxContainerView sendSubviewToBack:self.overlayView];
                [self.expiredView removeFromSuperview];
            }
        }
    }];
}

- (void)showReportView {
    if (self.reportView == nil) {
        self.reportView = [OTPReportView loadFromNIB];
    }
//    [self.reportView removeFromSuperview];
    [self.reportView layoutIfNeeded];
    self.reportView.delegate = self;
    self.overlayView.frame = self.reportView.frame;
    self.heightConstraintOPTBoxView.priority = 999;
    [self.overlayView addSubview:self.reportView];
    [self.otpBoxContainerView bringSubviewToFront:self.overlayView];
    self.otpInputContainerView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        self.overlayView.alpha = 1;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
    }];
}

- (void)showLoading: (BOOL) loading {
    self.loading = loading;
    [UIView animateWithDuration:0.35f animations:^{
        self.lbLoading.alpha = loading ? 1 : 0;
        self.activityLloading.alpha = self.lbLoading.alpha;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.35f animations:^{
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
    if (errorString.length > 0) {
        [self.otpInput showError:YES];
    }
    [UIView animateWithDuration:0.35f animations:^{
        self.lbError.alpha = ([errorString isEqualToString:@""] || errorString == nil) ? 0 : 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.35f animations:^{
                self.lbError.text = errorString;
                [self layoutIfNeeded];
            }];
        }
    }];
}


- (void)onCallTapped {
    [self showExpiredView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeExpiredView];
//    });
//    if ([self.delegate respondsToSelector:@selector(okButtonTapped)]) {
//        [self.delegate okButtonTapped];
//    }
}

- (void)onSMSTapped {
    
}

- (IBAction)onCloseTapped:(id)sender {
    [self removeBox];
}

// EXPIRED View

- (void)onBackTapped {
    [self removeBox];
}

- (void)onReportTapped {
    [self.expiredView removeFromSuperview];
    [self showReportView];
}

// REPORT view

- (void)onDoneReportHandler {
    [self removeBox];
}

// TEXTFIELD

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.loading == YES || self.expired == YES) return NO;
    
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
