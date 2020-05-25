//
//  OTPBoxExpiredView.m
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPExpiredView.h"

@implementation OTPExpiredView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onBackTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onBackTapped)]) {
        [self.delegate onBackTapped];
    }
}

- (IBAction)onReportTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onReportTapped)]) {
        [self.delegate onReportTapped];
    }
}

@end
