//
//  Formatter.h
//  OTPBox
//
//  Created by tuledev on 6/10/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Formatter : NSObject

+ (NSAttributedString *)formatText: (NSString *)string data:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
