//
//  OTPInputPhoneView.m
//  OTPBox
//
//  Created by tuledev on 6/4/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPInputPhoneView.h"
#import "../../Utils/UIColor+hex.m"
#import "../OTPActionView/OTPActionItem.h"
#import "../OTPActionView/OTPActionView.h"



@interface OTPInputPhoneView()

@property (nonatomic, weak) id <OTPBoxActionDelegate> delegate;
@property (nonatomic, retain) OTPActionView * otpAction;


@property (weak, nonatomic) IBOutlet UIView *choosingMethodView;
@property (weak, nonatomic) IBOutlet UIView *receiveOTPView;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintActionMethodView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintReceiveOTPView;
@property (weak, nonatomic) IBOutlet UITextField *tfInputPhone;

@end

@implementation OTPInputPhoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tfInputPhone.delegate = self;
}

- (void)setupUI: (BOOL)showMethods delegate:(id<OTPBoxActionDelegate>)delegate {
    self.inputView.layer.borderColor = [[UIColor colorWithHexString:@"0086c9"] CGColor];
    self.inputView.layer.borderWidth = 1;

    [[self.actionView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.delegate = delegate;
    self.otpAction = [OTPActionView createOTPActionsWithDelegate:delegate];
    [self.actionView addSubview:self.otpAction];
    [self.otpAction disable:YES];

    [self.tfInputPhone becomeFirstResponder];
    if (showMethods) {
        self.heightConstraintReceiveOTPView.priority = 999;
    } else {
        self.heightConstraintActionMethodView.priority = 999;
    }
    [self disableAction:YES];
}

- (void)disableAction:(BOOL)disable {
    [self.otpAction disable:disable];
}

- (void)onCallTapped {
}

- (void)onSMSTapped {
    
}
- (IBAction)onSendOTPTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onSMSTapped)]) {
        [self.delegate onSMSTapped];
    }
}


// TEXTFIELD

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (updatedString.length >  10) {
        return NO;
    }
    if (updatedString.length == 10) {
        [self disableAction:NO];
    } else {
        [self disableAction:YES];
    }
    return YES;
}


@end
