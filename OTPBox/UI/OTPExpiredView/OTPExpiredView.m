//
//  OTPBoxExpiredView.m
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPExpiredView.h"

@interface OTPExpiredView()

@property (weak, nonatomic) IBOutlet UIView *viewWithReport;
@property (weak, nonatomic) IBOutlet UIView *viewWithoutReport;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *lbDetail;


@end

@implementation OTPExpiredView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (OTPExpiredView *)createWithReport:(BOOL)canReport {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPBoxExpiredView"
                                                                                    owner:self options:nil];
    OTPExpiredView *expiredView;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPExpiredView class]]) {
            expiredView = (OTPExpiredView *)object;
            break;
        }
    }
    [expiredView renderWithReport:canReport];
    
    return expiredView;
}

- (void)renderWithReport: (BOOL)canReport {
    if (canReport) {
        [self.containerView bringSubviewToFront:self.viewWithReport];
        self.viewWithoutReport.alpha = 0;
    } else {
        [self.containerView bringSubviewToFront:self.viewWithoutReport];
        [self.lbDetail setText:@""];
        self.viewWithReport.alpha = 0;
    }
}
    

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
