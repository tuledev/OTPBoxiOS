//
//  OTPAction.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPAction.h"

@interface OTPAction()
@property (weak, nonatomic) IBOutlet UILabel *lbIconCall;
@property (weak, nonatomic) IBOutlet UILabel *lbIconSMS;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnSMS;

@end

@implementation OTPAction

- (void) configUI {
//    if (self.lbIconCall != nil) {
//        [self.lbIconCall removeFromSuperview];
//        [self.btnCall addSubview:self.lbIconCall];
//        [self.lbIconCall setUserInteractionEnabled:true];
//    }
//    if (self.lbIconSMS != nil) {
//        [self.lbIconSMS removeFromSuperview];
//        [self.btnSMS addSubview:self.lbIconSMS];
//        [self.lbIconSMS setUserInteractionEnabled:true];
//    }
}

- (IBAction)onCallTapped:(id)sender {
    NSLog(@"calllllllllllll");
}
- (IBAction)onSMSTapped:(id)sender {
}

+ (OTPAction *)create: (NSInteger)type {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"]
                       loadNibNamed: type == 0 ? @"OTPActionCall" : @"OTPActionSMS"
                       owner:self options:nil];
    OTPAction * item;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPAction class]]) {
            item = (OTPAction *)object;
            break;
        }
    }
    [item configUI];

    return item;
}

@end
