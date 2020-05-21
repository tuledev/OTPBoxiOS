//
//  OTPActionView.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPActionView.h"
#import "OTPAction.h"

@interface OTPActionView()

@property (nonatomic, retain) NSMutableArray * arrAction;

@end

@implementation OTPActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateAction {
    self.arrAction = [NSMutableArray new];
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.frame = CGRectMake(0, 0, 2* 96 + 36, 20);
    
    OTPAction * callAction = [OTPAction create:0];
    callAction.frame = CGRectMake(0, 0, 100, 20);
    OTPAction * smsAction = [OTPAction create:1];
    smsAction.frame = CGRectMake(100 + 36, 0, 100, 20);
    [self addSubview:callAction];
    [self addSubview:smsAction];
}

+ (OTPActionView *)createOTPActions {
    OTPActionView * otpAction = [OTPActionView new];
    [otpAction updateAction];
    return otpAction;
}

@end
