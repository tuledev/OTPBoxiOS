//
//  OTPActionDelegate.h
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#ifndef OTPActionDelegate_h
#define OTPActionDelegate_h



@protocol OTPBoxActionDelegate <NSObject>

@optional
- (void)onCallTapped;
- (void)onSMSTapped;
- (void)onInputPhoneDone: (NSString *)phoneNumber;

@end

#endif /* OTPActionDelegate_h */
