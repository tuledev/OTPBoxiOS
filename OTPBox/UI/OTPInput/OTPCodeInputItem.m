//
//  OTPCodeInputItem.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPCodeInputItem.h"
#import "../../Utils/UIColor+hex.m"

@interface OTPCodeInputItem ()
@property (weak, nonatomic) IBOutlet UIView *viewCursor;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;

@end

@implementation OTPCodeInputItem

- (void)setSelected {
    self.backgroundColor = [UIColor colorWithHexString:@"0086c926"];
    self.viewCursor.hidden = false;
}
- (void)setUnselected {
    self.backgroundColor = [UIColor colorWithHexString:@"f6f7fa"];
    self.viewCursor.hidden = true;
}
- (void)updateValue: (NSString *) value {
    self.lbValue.text = value;
}

- (void)error: (BOOL)hasError {
    self.backgroundColor = [UIColor colorWithHexString:@"c6334426"];
}

+ (OTPCodeInputItem *)create {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:@"OTPCodeInputItem"
                                                                                owner:self options:nil];
    OTPCodeInputItem *inputItem;
    for (id object in bundle) {
        if ([object isKindOfClass:[OTPCodeInputItem class]]) {
            inputItem = (OTPCodeInputItem *)object;
            break;
        }
    }
    
    [inputItem setUnselected];

    return inputItem;
    
}

@end
