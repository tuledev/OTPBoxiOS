//
//  APIs.m
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "APIs.h"

@implementation APIs

+(void)mockAPIsCompletionCallback: (void(^)(NSString * error))callback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(@"");
    });
}

+(void)mockAPIsCompletionWithErrorCallback: (void(^)(NSString * error))callback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(@"Mã xác thực không đúng");
    });
}

@end
