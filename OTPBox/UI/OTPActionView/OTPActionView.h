//
//  OTPActionView.h
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTPActionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTPActionView : UIView

+ (OTPActionView *)createOTPActionsWithDelegate: (id<OTPBoxActionDelegate> _Nonnull)delegate;

@end

NS_ASSUME_NONNULL_END
