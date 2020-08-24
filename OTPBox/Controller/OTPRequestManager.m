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

//+ (void)verifyOTP:(NSString *)otp callback:(void(^)(NSString * error))callback {
////    if (requestNumber == 0) {
//    if (![otp isEqualToString:@"1111"]) {
//        [APIs mockAPIsCompletionWithErrorCallback:^(NSString * _Nonnull error) {
//            callback(error);
//        }];
//        requestNumber ++;
//    } else {
//        [APIs mockAPIsCompletionCallback:^(NSString * _Nonnull error) {
//            callback(error);
//        }];
//        requestNumber = 0;
//    }
//}

+ (void)invokeCallbackInMainQueue:(void(^)(NSString * error))callback error:(NSString *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(error);
    });
}

+(void)fetchInfo: (void(^)(NSString * error))callback {
    [APIs.sharedInstance getInfo:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSLog(@"REsponse getInfo %@", response);
        if (error == nil) {
            BOOL success = [[response objectForKey:@"status"] boolValue];
            if (success) {
                NSDictionary * data = (NSDictionary *)[response objectForKey:@"data"];
                NSDictionary * otpBoxData = (NSDictionary * )[data objectForKey:@"otpbox_data"];
                NSLog(@"%@ config", otpBoxData);
                
                NSNumber * defaultOTPMethod = [(NSString *)[otpBoxData objectForKey:@"default"] isEqualToString:@"voice"] ? @0 : @1;
                NSLog(@"%@ %@ config defaultOTPMethod", defaultOTPMethod, [otpBoxData objectForKey:@"default"]);
                
                NSMutableArray<NSNumber *> * visibleMethod = [NSMutableArray new];
                
                if ([otpBoxData objectForKey:@"voice_allow"] != (id)[NSNull null]  && [[otpBoxData objectForKey:@"voice_allow"] boolValue]) {
                    [visibleMethod addObject:@0];
                }
                
                if ([otpBoxData objectForKey:@"sms_allow"] != (id)[NSNull null]  && [[otpBoxData objectForKey:@"sms_allow"] boolValue]) {
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
                
                [self invokeCallbackInMainQueue:callback error:@""];
            } else {
                NSString * errMess = (NSString *)[response objectForKey:@"errMess"];
                [self invokeCallbackInMainQueue:callback error:errMess];
            }
        }
        else {
            [self invokeCallbackInMainQueue:callback error:@"Đã có lỗi xảy ra vui lòng thử lại sau"];
        }
    }];
}

+ (void)requestOTP:(NSNumber *)method
       phoneNumber:(NSString *)phone
          callback:(void(^)(NSString * error, NSString * errorCode))callback {
    NSString * methodString = @"default";
    if ([method integerValue] == 0) methodString = @"voice";
    if ([method integerValue] == 1) methodString = @"sms";
    [APIs.sharedInstance processWithMethod:methodString phoneNumber:phone callback:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSLog(@"REsponse requestOTP %@", response);
        if (error == nil) {
            BOOL success = [[response objectForKey:@"status"] boolValue];
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(@"", @"");
                });
            } else {
                NSString * errMess = (NSString *)[response objectForKey:@"errMess"];
                NSString * errCode = (NSString *)[response objectForKey:@"errCode"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(errMess, errCode);
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(@"Đã có lỗi xảy ra vui lòng thử lại sau", @"Unknown");
            });
        }
    }];
}

+ (void)verifyOTP:(NSString *)code
      phoneNumber:(NSString *)phone
         callback:(void(^)(NSDictionary * data, NSString * error, NSString * errorCode))callback {
    [APIs.sharedInstance validateWithCode:code phoneNumber:phone callback:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSLog(@"REsponse verifyOTP %@", response);
        if (error == nil) {
            BOOL success = [[response objectForKey:@"status"] boolValue];
            if (success) {
                NSDictionary * data = (NSDictionary *)[response objectForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(data, @"", @"");
                });
            } else {
                NSString * errMess = (NSString *)[response objectForKey:@"errMess"];
                NSString * errCode = (NSString *)[response objectForKey:@"errCode"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(nil, errMess, errCode);
                });
            }
        }
        else {
            callback(nil, @"Đã có lỗi xảy ra vui lòng thử lại sau", @"Unknown");
        }
    }];
}

+ (void)fetchResult:(void(^)(NSDictionary *data, NSString * error))callback {
    [APIs.sharedInstance overtime:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSLog(@"resulll %@", response);
        if (error == nil) {
            BOOL success = [[response objectForKey:@"status"] boolValue];
            if (success) {
                NSDictionary * data = (NSDictionary *)[response objectForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(data, @"");
                });
            } else {
                NSString * errMess = (NSString *)[response objectForKey:@"errMess"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(nil, errMess);
                });
            }
        }
        else {
            callback(nil, @"Đã có lỗi xảy ra vui lòng thử lại sau");
        }
    }];
}

+ (void)sendReport:(void(^)(NSDictionary *data, NSString * error))callback {
    [APIs.sharedInstance report:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
        NSLog(@"resulll %@", response);
        if (error == nil) {
            BOOL success = [[response objectForKey:@"status"] boolValue];
            if (success) {
                NSDictionary * data = (NSDictionary *)[response objectForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(data, @"");
                });
            } else {
                NSString * errMess = (NSString *)[response objectForKey:@"errMess"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(nil, errMess);
                });
            }
        }
        else {
            callback(nil, @"Đã có lỗi xảy ra vui lòng thử lại sau");
        }
    }];
}

@end
