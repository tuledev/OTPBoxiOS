//
//  OTPManager.m
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPManager.h"
#import "../Backend/APIs.h"

@interface OTPManager()

@end

@implementation OTPManager

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

@end
