//
//  OTPConfigManager.h
//  OTPBox
//
//  Created by tuledev on 6/8/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTPConfigManager : NSObject

@property (nonatomic) NSNumber * defautOTPMethod;
@property (nonatomic, retain) NSMutableArray <NSNumber *> * visibleOTPMethod;

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * timeoutText;

@property (nonatomic) NSInteger otpCodeLength;
@property (nonatomic) NSInteger otpWrongLimit;

@property (nonatomic) NSInteger resendTimeout;
@property (nonatomic) NSInteger resendLimit;
@property (nonatomic) NSInteger sessionTimeout;

@property (nonatomic, retain) NSString * reportText;
@property (nonatomic) BOOL userCanReport;

+ (OTPConfigManager *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
