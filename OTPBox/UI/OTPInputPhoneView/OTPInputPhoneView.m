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


@interface OTPInputPhoneView()

@property (nonatomic, retain) NSMutableArray * arrAction;

@property (nonatomic, weak) id <OTPBoxActionDelegate> delegate;

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
}

- (void)setupUI: (BOOL)showMethods delegate:(id<OTPBoxActionDelegate>)delegate {
    self.inputView.layer.borderColor = [[UIColor colorWithHexString:@"0086c9"] CGColor];
    self.inputView.layer.borderWidth = 1;
    
    self.arrAction = [NSMutableArray new];
    
    [[self.actionView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    OTPActionItem * callAction = [OTPActionItem create:0];
    callAction.frame = CGRectMake(0, 0, 100, 20);
    callAction.delegate = delegate;
    OTPActionItem * smsAction = [OTPActionItem create:1];
    smsAction.frame = CGRectMake(100 + 50, 0, 100, 20);
    smsAction.delegate = delegate;
    [self.actionView addSubview:callAction];
    [self.actionView addSubview:smsAction];
    self.delegate = delegate;
    
    [self.tfInputPhone becomeFirstResponder];
    if (showMethods) {
        self.heightConstraintReceiveOTPView.priority = 999;
    } else {
        self.heightConstraintActionMethodView.priority = 999;
    }

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


@end
