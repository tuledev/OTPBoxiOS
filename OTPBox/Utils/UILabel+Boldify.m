//
//  UILabel+Boldify.m
//  OTPBox
//
//  Created by tuledev on 6/9/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Utils/UIColor+hex.m"
#import "../Style/Constants.m"

@interface UILabel(Boldify)

- (void) boldSubstring: (NSString*) substring;
- (void) boldRange: (NSRange) range;

@end

@implementation UILabel(Boldify)

- (void) boldRange: (NSRange) range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) return;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText setAttributes:@{NSFontAttributeName:BOLD_TEXT_FONT, NSForegroundColorAttributeName:BOLD_TEXT_COLOR} range:range];
    self.attributedText = attributedText;
}

- (void) boldSubstring: (NSString*) substring {
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}
@end

