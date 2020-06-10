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
        self.canUserReport = NO;
        
        [self readInfoFile];
    }
    return self;
}

- (void)readInfoFile {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"OTPBox-Info" ofType:@"plist"];
    if (path == nil) {
        NSLog(@"Warning: OTPBox-Info.plist not found!!!");
        return;
    }
    NSDictionary * configData = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.clientID = [configData valueForKey:@"CLIENT_ID"];
    self.bunbleID = [configData valueForKey:@"BUNDLE_ID"];
}

- (void)updateOTPConfigForDefautOTPMethod:(NSNumber *)defautOTPMethod
                         visibleOTPMethod:(NSMutableArray <NSNumber *> *) visibleOTPMethod
                                    title:(NSString *) title
                              timeoutText:(NSString *)timeoutText
                            otpCodeLength:(NSInteger)otpCodeLength
                            otpWrongLimit:(NSInteger)otpWrongLimit
                               resendText:(NSString *)resendText
                               resendByText:(NSString *)resendByText
                            resendTimeout:(NSInteger)resendTimeout
                              resendLimit:(NSInteger)resendLimit
                           sessionTimeout:(NSInteger)sessionTimeout
                               reportText:(NSString *)reportText
                            userCanReport:(BOOL)canUserReport {
    self.defautOTPMethod = defautOTPMethod;
    self.visibleOTPMethod = visibleOTPMethod;
    self.title = title;
    self.timeoutText = timeoutText;
    self.otpCodeLength = otpCodeLength;
    self.otpWrongLimit = otpWrongLimit;
    self.resendText = resendText;
    self.resendByText = resendByText;
    self.resendTimeout = 6;//resendTimeout;
    self.sessionTimeout = 1;// sessionTimeout;
    self.resendLimit = resendLimit;
    self.reportText = reportText;
    self.canUserReport = canUserReport;
}

- (NSString *)getClientID {
    return self.clientID;
}

@end
