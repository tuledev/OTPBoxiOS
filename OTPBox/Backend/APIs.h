//
//  APIs.h
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIs : NSObject

+(void)mockAPIsCompletionCallback: (void(^)(NSString * error))callback;
+(void)mockAPIsCompletionWithErrorCallback: (void(^)(NSString * error))callback;

+ (APIs *)sharedInstance;

- (void)getInfo: (void(^)(NSDictionary *data, NSError * error))callback;
- (void)processWithMethod:(NSString *)method
              phoneNumber:(NSString *)phone
                 callback:(void(^)(NSDictionary *data, NSError * error))callback;
- (void)validateWithCode:(NSString *)code
             phoneNumber:(NSString *)phone
                callback:(void(^)(NSDictionary *data, NSError * error))callback;

- (void)overtime: (void(^)(NSDictionary *data, NSError * error))callback;
- (void)report: (void(^)(NSDictionary *data, NSError * error))callback;

@end

NS_ASSUME_NONNULL_END
