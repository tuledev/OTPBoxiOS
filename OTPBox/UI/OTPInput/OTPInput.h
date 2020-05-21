//
//  OTPInput.h
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPInput : UIView

- (void)updateOTPString: (NSString *)otp;

+ (OTPInput *)createWithOTPLength:(NSInteger) otpLength;

@end

NS_ASSUME_NONNULL_END
