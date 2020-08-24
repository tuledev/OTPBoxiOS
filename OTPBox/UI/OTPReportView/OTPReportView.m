//
//  OTPReportView.m
//  OTPBox
//
//  Created by tuledev on 5/25/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPReportView.h"

@interface OTPReportView()
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * img;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
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
    self.countdown = 30;
    
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
    _lbCountDown.text = [NSString stringWithFormat:@"%@ %lds", self.detail,(long)countdown];
}

- (void)updateData: (NSDictionary *)data {
    self.title = (NSString *)[data objectForKey:@"title"];
    self.detail = (NSString *)[data objectForKey:@"body"];
    self.img = (NSString *)[data objectForKey:@"img"];
    
    self.lbTitle.text = self.title;
    [self startCountDown];
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
    return view;
}


@end
