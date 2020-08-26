//
//  OTPBoxView.h
//  OTPBox
//
//  Created by tuledev on 5/18/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OTPBox/OTPActionDelegate.h>
#import <OTPBox/OTPExpiredViewDelegate.h>
#import <OTPBox/OTPReportViewDelegate.h>
NS_ASSUME_NONNULL_BEGIN

@protocol OTPBoxDelegate <NSObject>

@optional
- (void)onResultHandler:(BOOL)success;
- (void)onReportHandler: (NSDictionary *) dict;

@end


@interface OTPBoxView : UIView <UITextFieldDelegate, OTPBoxActionDelegate, OTPExpiredViewDelegate, OTPReportViewDelegate>

@property (nonatomic, assign) id <OTPBoxDelegate> delegate;

+ (OTPBoxView *)createOTPBoxView;
+ (OTPBoxView *)showIn: (UIView *) superview;
+ (OTPBoxView *)showIn: (UIView *) superview phoneNumber:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
