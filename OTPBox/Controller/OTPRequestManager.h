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

+ (void)fetchInfo: (void(^)(NSString * error))callback;
+ (void)requestOTP:(NSNumber *)method
       phoneNumber:(NSString *)phone
          callback:(void(^)(NSString * error, NSString * errorCode))callback;
+ (void)verifyOTP:(NSString *)code
      phoneNumber:(NSString *)phone
         callback:(void(^)(NSDictionary * data, NSString * error, NSString * errorCode))callback;

+ (void)fetchResult:(void(^)(NSDictionary *data, NSString * error))callback;
+ (void)sendReport:(void(^)(NSDictionary *data, NSString * error))callback;

@end

NS_ASSUME_NONNULL_END
