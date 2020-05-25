//
//  OTPReportView.m
//  OTPBox
//
//  Created by tuledev on 5/25/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPReportView.h"

@interface OTPReportView()
@property (weak, nonatomic) IBOutlet UILabel *lbCountDown;
@property (nonatomic) NSInteger countdown;
@property (retain, nonatomic) NSTimer * timer;

@end

@implementation OTPReportView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)startCountDown {
    self.countdown = 3;
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(fireCountDown)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)fireCountDown {
    if (self.countdown == 0) {
        [self endCountDown];
        return;
    }
    self.countdown -= 1;
    [self updateCountDownLable:self.countdown];
}
    
- (void)endCountDown {
    [self.timer invalidate];
    self.timer = nil;
    
    if ([self.delegate respondsToSelector:@selector(onDoneReportHandler)]) {
        [self.delegate onDoneReportHandler];
    }
}

- (void)updateCountDownLable: (NSInteger)countdown {
    _lbCountDown.text = [NSString stringWithFormat:@"Chúng tôi sẽ tiến hành kiểm tra và chỉnh sửa nếu phát hiện có lỗi.\nQuay lại sau %lds",(long)countdown];
}
    

+ (OTPReportView *)loadFromNIB{
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPReportView"
                                                                                owner:self options:nil];
    OTPReportView * view;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPReportView class]]) {
            view = (OTPReportView *)object;
            break;
        }
    }
    [view startCountDown];
    return view;
}


@end
