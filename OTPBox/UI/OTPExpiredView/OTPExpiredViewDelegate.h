//
//  OTPExpiredViewDelegate.h
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#ifndef OTPExpiredViewDelegate_h
#define OTPExpiredViewDelegate_h

@protocol OTPExpiredViewDelegate <NSObject>

@optional

- (void)onBackTapped;
- (void)onReportTapped;

@end


#endif /* OTPExpiredViewDelegate_h */
