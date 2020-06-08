//
//  OTPBoxExpiredView.h
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTPExpiredViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTPExpiredView : UIView

@property (nonatomic, weak) id <OTPExpiredViewDelegate> delegate;

+ (OTPExpiredView *)createWithReport:(BOOL)canReport;

@end

NS_ASSUME_NONNULL_END
