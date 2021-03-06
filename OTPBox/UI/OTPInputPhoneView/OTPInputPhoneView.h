//
//  OTPInputPhoneView.h
//  OTPBox
//
//  Created by tuledev on 6/4/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OTPBox/OTPActionDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPInputPhoneView : UIView <UITextFieldDelegate>

- (void)setupUI: (BOOL)showMethods delegate:(id<OTPBoxActionDelegate>)delegate actions:(NSMutableArray <NSNumber *> *)actions;

@end

NS_ASSUME_NONNULL_END
