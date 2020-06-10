//
//  OTPManager.h
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPRequestManager : NSObject

+ (void)verifyOTP:(NSString *) otp callback:(void(^)(NSString * error))callback;
+ (void)requestOTP:(void(^)(NSString * error))callback;

+(void)getInfo: (void(^)(NSString * error))callback;

@end

NS_ASSUME_NONNULL_END
