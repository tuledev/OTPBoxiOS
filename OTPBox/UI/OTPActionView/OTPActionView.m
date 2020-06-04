//
//  OTPActionView.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPActionView.h"
#import "OTPActionItem.h"

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

- (void)updateAction: (id<OTPBoxActionDelegate> _Nonnull)delegate {
    self.arrAction = [NSMutableArray new];
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.frame = CGRectMake(0, 0, 2* 96 + 50, 20);
    
    OTPActionItem * callAction = [OTPActionItem create:0];
    callAction.frame = CGRectMake(0, 0, 100, 20);
    callAction.delegate = delegate;
    OTPActionItem * smsAction = [OTPActionItem create:1];
    smsAction.frame = CGRectMake(100 + 50, 0, 100, 20);
    smsAction.delegate = delegate;
    [self addSubview:callAction];
    [self addSubview:smsAction];
    [self.arrAction addObject:callAction];
    [self.arrAction addObject:smsAction];
}

- (void)disable:(BOOL)disable {
    for (int i=0; i<self.arrAction.count; i+=1) {
        OTPActionItem * item = (OTPActionItem *)self.arrAction[i];
        [item disable:disable];
    }
    [self layoutIfNeeded];
}

+ (OTPActionView *)createOTPActionsWithDelegate: (id<OTPBoxActionDelegate> _Nonnull)delegate {
    OTPActionView * otpAction = [OTPActionView new];
    [otpAction updateAction: delegate];
    return otpAction;
}

@end
