//
//  OTPInput.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPInputView.h"
#import "OTPCodeInputItem.h"

@interface OTPInputView ()

@property (nonatomic) NSInteger otpLength;
@property (nonatomic, retain) NSMutableArray<OTPCodeInputItem *> * arrInput;

@end

@implementation OTPInputView

@synthesize otpLength;
@synthesize arrInput;

- (void)updateOTPLength: (NSInteger) length {
    self.otpLength = length;
    self.arrInput = [NSMutableArray new];
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.frame = CGRectMake(0, 0, length * 36 + (length - 1) * 10, 40);
    for (int i = 0; i < length; i++) {
        OTPCodeInputItem * item = [OTPCodeInputItem create];
        item.frame = CGRectMake((i)*36 + i*10, 0, 36, 40);
        [self addSubview:item];
        [arrInput addObject:item];
    }
    
    [arrInput[0] setSelected];
}

- (void)updateOTPString: (NSString *)otp {
    for (int i=0; i < [self.arrInput count]; i++) {
        [self.arrInput[i] updateValue:@""];
        [self.arrInput[i] setUnselected];
    }
    for (int i=0; i<otp.length; i++) {
        NSString *otpCode = [NSString stringWithFormat:@"%c", [otp characterAtIndex:i]];
        [self.arrInput[i] updateValue:otpCode];
    }
    
    [self.arrInput[otp.length >= self.arrInput.count ? self.arrInput.count - 1 : otp.length] setSelected];
}

- (void)showError: (BOOL) error {
    for (int i=0; i < [self.arrInput count]; i++) {
        [self.arrInput[i] error:error];
    }
}

+ (OTPInputView *)createWithOTPLength:(NSInteger) otpLength {
    OTPInputView * otpInput = [OTPInputView new];
    [otpInput updateOTPLength:otpLength];
    return otpInput;
}

@end
