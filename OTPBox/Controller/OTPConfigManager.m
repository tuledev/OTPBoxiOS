//
//  OTPConfigManager.m
//  OTPBox
//
//  Created by tuledev on 6/8/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPConfigManager.h"

@interface OTPConfigManager()

@property (nonatomic, retain) NSString * clientID;
@property (nonatomic, retain) NSString * bunbleID;

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
        self.sessionTimeout = 20;
        self.otpCodeLength = 4;
        self.otpWrongLimit = 3;
        self.resendLimit = 3;
        self.visibleOTPMethod = [NSMutableArray new];
        [self.visibleOTPMethod addObject:@0];
        [self.visibleOTPMethod addObject:@1];
        self.defautOTPMethod = @0;
        self.userCanReport = NO;
        
        [self readConfigFile];
    }
    return self;
}

- (void)readConfigFile {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"OTPBox-Info" ofType:@"plist"];
    if (path == nil) {
        NSLog(@"Warning: OTPBox-Info.plist not found!!!");
        return;
    }
    NSDictionary * configData = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.clientID = [configData valueForKey:@"CLIENT_ID"];
    self.bunbleID = [configData valueForKey:@"BUNDLE_ID"];
}

@end
