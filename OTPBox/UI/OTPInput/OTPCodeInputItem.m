//
//  OTPCodeInputItem.m
//  OTPBox
//
//  Created by tuledev on 5/19/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "OTPCodeInputItem.h"
@interface OTPCodeInputItem ()
@property (weak, nonatomic) IBOutlet UIView *viewCursor;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;

@end

@implementation OTPCodeInputItem

- (void)setSelected {
    self.backgroundColor = [[UIColor alloc] initWithRed:0 green:124 blue:201 alpha:0.2];
    self.viewCursor.hidden = false;
}
- (void)setUnselected {
    self.backgroundColor = [[UIColor alloc] initWithRed:246 green:247 blue:250 alpha:1];
    self.viewCursor.hidden = true;
}
- (void)updateValue: (NSString *) value {
    self.lbValue.text = value;
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
