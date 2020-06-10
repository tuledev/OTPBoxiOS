//
//  APIs.m
//  OTPBox
//
//  Created by tuledev on 5/21/20.
//  Copyright © 2020 Digitel. All rights reserved.
//

#import "APIs.h"
#import "../Controller/OTPConfigManager.h"

@interface APIs()

@end

@implementation APIs

+ (APIs *)sharedInstance {
    static APIs * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


+(void)mockAPIsCompletionCallback: (void(^)(NSString * error))callback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(@"");
    });
}

+(void)mockAPIsCompletionWithErrorCallback: (void(^)(NSString * error))callback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(@"Mã xác thực không đúng");
    });
}

- (void)getInfo: (void(^)(NSDictionary *data, NSError * error))callback {
    // making a POST request to /init
    NSString *targetUrl = @"https://box.otpbox.vn/api/v1/frontend/getInfo";
    NSURL * url = [NSURL URLWithString:targetUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Make an NSDictionary that would be converted to an NSData object sent over as JSON with the request body
    NSDictionary *data = @{@"secretKey": OTPConfigManager.sharedInstance.getClientID};
    NSLog(@"request data %@", data);
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          NSLog(@"%@",error);
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              if ([[json objectForKey:@"status"] boolValue]) {
                  callback([json objectForKey:@"data"], error);
              } else {
                  callback(nil, error);
              }
          }
      }] resume];
}

@end
