//
//  UIView+nib.m
//  OTPBox
//
//  Created by tuledev on 5/22/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(nib)


@end

@implementation UIView(nib)

+ (id)loadViewFromNibNamed: (NSString *)name owner: (id)owner {
    NSArray *bundle = [[NSBundle bundleWithIdentifier:@"Digipay.OTPBox"] loadNibNamed:name owner:owner options:nil];
    return bundle[0];
}

@end

