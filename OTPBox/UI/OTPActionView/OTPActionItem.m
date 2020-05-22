//
//  OTPAction.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPActionItem.h"

@interface OTPActionItem()
@property (weak, nonatomic) IBOutlet UILabel *lbIconCall;
@property (weak, nonatomic) IBOutlet UILabel *lbIconSMS;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnSMS;

@end

@implementation OTPActionItem

+ (OTPActionItem *)create: (NSInteger)type {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"]
                       loadNibNamed: type == 0 ? @"OTPActionCall" : @"OTPActionSMS"
                       owner:self options:nil];
    OTPActionItem * item;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPActionItem class]]) {
            item = (OTPActionItem *)object;
            break;
        }
    }
    [item configUI];
    
    return item;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action: [self.restorationIdentifier isEqualToString:@"OTPActionCall"] ? @selector(onCallTapped:) : @selector(onSMSTapped:)];
    [self addGestureRecognizer:gestureRecognizer];
    self.userInteractionEnabled = YES;
    gestureRecognizer.cancelsTouchesInView = NO;
}

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
    if ([self.delegate respondsToSelector:@selector(onCallTapped)]) {
        [self.delegate onCallTapped];
    }
}
- (IBAction)onSMSTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(onSMSTapped)]) {
        [self.delegate onSMSTapped];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0.1;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }];
}

@end
