//
//  Helper.m
//  OTPBox
//
//  Created by tuledev on 6/18/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "Helper.h"
#import <CoreText/CoreText.h>

#import "../Constants/Constants.m"

@implementation Helper

+ (void)loadFontWithName:(NSString *)fontName
{
    NSString *fontPath = [[NSBundle bundleWithIdentifier:OTPBOX_BUNDLE_ID] pathForResource:fontName ofType:@"otf"];
    NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
    
    if (provider)
    {
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        
        if (font)
        {
            CFErrorRef error = NULL;
            if (CTFontManagerRegisterGraphicsFont(font, &error) == NO)
            {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                CFRelease(errorDescription);
            }
            
            CFRelease(font);
        }
        
        CFRelease(provider);
    }
}

@end
