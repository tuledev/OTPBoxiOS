//
//  OTPAction.h
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPActionItem : UIView

+ (OTPActionItem *)create: (NSInteger)type;

@end

NS_ASSUME_NONNULL_END