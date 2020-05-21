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

@end

NS_ASSUME_NONNULL_END
