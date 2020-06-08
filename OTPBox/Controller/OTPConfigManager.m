//
//  OTPConfigManager.m
//  OTPBox
//
//  Created by tuledev on 6/8/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPConfigManager.h"

@interface OTPConfigManager()

@end

@implementation OTPConfigManager

+ (OTPConfigManager *)sharedInstance {
    static OTPConfigManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.resendTimeout = 50;
        self.sessionTimeout = 150;
        self.otpCodeLength = 4;
        self.otpWrongLimit = 3;
        self.resendLimit = 3;
        self.visibleOTPMethod = [NSMutableArray new];
        [self.visibleOTPMethod addObject:@0];
        [self.visibleOTPMethod addObject:@1];
        self.defautOTPMethod = @0;
    }
    return self;
}

@end
