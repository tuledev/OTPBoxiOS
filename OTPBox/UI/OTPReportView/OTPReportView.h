//
//  OTPReportView.h
//  OTPBox
//
//  Created by tuledev on 5/25/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTPReportViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTPReportView : UIView

@property (nonatomic, weak) id <OTPReportViewDelegate> delegate;

+ (OTPReportView *)loadFromNIB;

- (void)updateData: (NSDictionary *)data;
    
@end

NS_ASSUME_NONNULL_END
