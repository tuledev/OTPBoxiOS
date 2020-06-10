//
//  OTPManager.m
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPRequestManager.h"
#import "../Backend/APIs.h"
#import "./OTPConfigManager.h"

@interface OTPRequestManager()

@end

@implementation OTPRequestManager

static NSInteger requestNumber = 0;

+ (void)verifyOTP:(NSString *)otp callback:(void(^)(NSString * error))callback {
//    if (requestNumber == 0) {
    if (![otp isEqualToString:@"1111"]) {
        [APIs mockAPIsCompletionWithErrorCallback:^(NSString * _Nonnull error) {
            callback(error);
        }];
        requestNumber ++;
    } else {
        [APIs mockAPIsCompletionCallback:^(NSString * _Nonnull error) {
            callback(error);
        }];
        requestNumber = 0;
    }
}

+ (void)requestOTP:(void(^)(NSString * error))callback {
    [APIs mockAPIsCompletionCallback:^(NSString * _Nonnull error) {
        callback(error);
    }];
}

+(void)getInfo: (void(^)(NSString * error))callback {
    [APIs.sharedInstance getInfo:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
        NSLog(@"REsponse %@", data);
        if (data != nil) {
            NSDictionary * otpBoxData = (NSDictionary * )[data objectForKey:@"otpbox_data"];
            NSNumber * defaultOTPMethod = [(NSString *)[otpBoxData objectForKey:@"default"] isEqualToString:@"voice"] ? @0 : @1;
            NSMutableArray<NSNumber *> * visibleMethod = [NSMutableArray new];
            if ([[otpBoxData objectForKey:@"voice_allow"] boolValue]) {
                [visibleMethod addObject:@0];
            }
            if ([[otpBoxData objectForKey:@"sms_allow"] boolValue]) {
                [visibleMethod addObject:@1];
            }
            NSString * title = (NSString *)[otpBoxData objectForKey:@"description_sent_code"];
            NSString * timeoutText = (NSString *)[otpBoxData objectForKey:@"description_timeout"];
            NSInteger codeLength = [[otpBoxData objectForKey:@"code_length"] integerValue];
            NSInteger retryLimit = [[otpBoxData objectForKey:@"max_wrong_retry"] integerValue];
            NSString * resendText  = (NSString *)[otpBoxData objectForKey:@"description_resend"];
            NSString * resendByText  = (NSString *)[otpBoxData objectForKey:@"description_resend_by"];
            NSInteger resendTimeout = [[otpBoxData objectForKey:@"time_retry"] integerValue];
            NSInteger resendLimit = [[otpBoxData objectForKey:@"max_retry"] integerValue];
            NSInteger sesstionTimeout = [[otpBoxData objectForKey:@"session_timeout"] integerValue];
            NSString * reportText = @"Chúng tôi sẽ tiến hành kiểm tra và chỉnh sửa nếu phát hiện có lỗi";
            BOOL canUserReport = [(NSString *)[otpBoxData objectForKey:@"support"] isEqualToString:@"custom"];
            
            [OTPConfigManager.sharedInstance
             updateOTPConfigForDefautOTPMethod:defaultOTPMethod
             visibleOTPMethod:visibleMethod
             title:title
             timeoutText:timeoutText
             otpCodeLength:codeLength
             otpWrongLimit:retryLimit
             resendText:resendText
             resendByText:resendByText
             resendTimeout:resendTimeout
             resendLimit:resendLimit
             sessionTimeout:sesstionTimeout
             reportText:reportText
             userCanReport:canUserReport];
            
            callback(@"");
        }
        else { callback(@"error"); }
    }];
}

@end
