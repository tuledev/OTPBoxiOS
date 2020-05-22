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

NS_ASSUME_NONNULL_BEGIN

@protocol OTPBoxDelegate <NSObject>

@optional
- (void)okButtonTapped;

@end


@interface OTPBoxView : UIView <UITextFieldDelegate, OTPBoxActionDelegate, OTPExpiredViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewInputOTP;
@property (weak, nonatomic) IBOutlet UIView *viewAction;

@property (nonatomic, assign) id <OTPBoxDelegate> delegate;

+ (OTPBoxView *)showIn: (UIView *) superview;

@end

NS_ASSUME_NONNULL_END
