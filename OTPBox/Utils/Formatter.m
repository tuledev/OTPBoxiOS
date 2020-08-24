//
//  Formatter.m
//  OTPBox
//
//  Created by tuledev on 6/10/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Formatter.h"
#import "../Constants/Constants.m"

@implementation Formatter

+ (NSAttributedString *)formatText: (NSString *)string data:(NSDictionary *)data {
    NSString * text = [self replaceValueInString:string data:data];
    UIFont * font = NORMAL_TEXT_FONT;
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:@{ NSFontAttributeName : font, NSForegroundColorAttributeName: NORMAL_TEXT_COLOR}];
    
    NSMutableParagraphStyle * style = [NSMutableParagraphStyle new];
    style.lineHeightMultiple = 1.3;
    style.alignment = NSTextAlignmentCenter;
    
    [attributedString addAttributes:@{ NSParagraphStyleAttributeName: style } range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}

+ (NSString *)replaceValueInString:(NSString *)origin data:(NSDictionary *)data {
    NSString *result = origin;
    for (NSString * key in data) {
        result = [result stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", key] withString:[data objectForKey:key]];
    }
    result = [result stringByReplacingOccurrencesOfString:@"{newLine}" withString:@"\n"];
    return result;
}

@end
