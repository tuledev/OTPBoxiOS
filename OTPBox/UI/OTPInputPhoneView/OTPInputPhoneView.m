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
#import "../../Controller/OTPConfigManager.h"


@interface OTPInputPhoneView()

@property (nonatomic, weak) id <OTPBoxActionDelegate> delegate;
@property (nonatomic, retain) OTPActionView * otpAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintActionView;


@property (weak, nonatomic) IBOutlet UIView *choosingMethodView;
@property (weak, nonatomic) IBOutlet UIView *receiveOTPView;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintActionMethodView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintReceiveOTPView;
@property (weak, nonatomic) IBOutlet UITextField *tfInputPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnRecevieCode;

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

- (void)setupUI: (BOOL)showMethods delegate:(id<OTPBoxActionDelegate>)delegate actions:(NSMutableArray <NSNumber *> *)actions {
    self.inputView.layer.borderColor = [[UIColor colorWithHexString:@"0086c9"] CGColor];
    self.inputView.layer.borderWidth = 1;

    [[self.actionView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    if (actions.count == 2) {
//        self.widthConstraintActionView.constant =  2* 96 + 50;
//    } else {
//        self.widthConstraintActionView.constant =  90;
//    }
//
//
    self.delegate = delegate;
    self.otpAction = [OTPActionView createOTPActionsWithDelegate:delegate actions:actions];
    [self.actionView addSubview:self.otpAction];
    [self.otpAction disable:YES];

    [self.tfInputPhone becomeFirstResponder];
    if (actions.count == 2) {
        self.heightConstraintReceiveOTPView.priority = 999;
    } else {
        self.heightConstraintActionMethodView.priority = 999;
    }
    [self disableAction:YES];
}

- (void)disableAction:(BOOL)disable {
    [self.otpAction disable:disable];
    self.btnRecevieCode.enabled = !disable;
}

- (void)onCallTapped {
}

- (void)onSMSTapped {
    
}
- (IBAction)onSendOTPTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onSMSTapped)]) {
        if ([OTPConfigManager.sharedInstance.defautOTPMethod isEqualToNumber:@0]) {
            [self.delegate onCallTapped];
        } else {
            [self.delegate onSMSTapped];
        }
    }
}


// TEXTFIELD

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * updatedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (updatedString.length >  10) {
        return NO;
    }
    if (updatedString.length == 10) {
        if ([self.delegate respondsToSelector:@selector(onInputPhoneDone:)]) {
            [self.delegate onInputPhoneDone:updatedString];
        }
        [self disableAction:NO];
    } else {
        [self disableAction:YES];
    }
    return YES;
}


@end
