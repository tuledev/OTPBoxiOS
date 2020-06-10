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

@property (nonatomic, retain) NSString * sessionID;

@end

@implementation APIs

static NSString * BASE_URL = @"https://box.otpbox.vn/api/v1/frontend";

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

- (instancetype)init {
    if (self = [super init]) {
        self.sessionID = @"";
    }
    return self;
}

- (void)getInfo: (void(^)(NSDictionary *data, NSError * error))callback {
    self.sessionID = @"";
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/getInfo"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *data = @{@"secretKey": OTPConfigManager.sharedInstance.getClientID};
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
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              callback(json, nil);
              NSDictionary * dataDict = (NSDictionary *)[json objectForKey:@"data"];
              if ([dataDict objectForKey:@"sessID"] != nil) {
                  self.sessionID = (NSString *)[dataDict objectForKey:@"sessID"];
              }
          } else {
            callback(nil , error);
          }
      }] resume];
}

- (void)processWithMethod:(NSString *)method
              phoneNumber:(NSString *)phone
                 callback:(void(^)(NSDictionary *data, NSError * error))callback {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/process"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *data = @{
                           @"method": method,
                           @"phone": phone,
                           @"sessID": self.sessionID
                           };
    NSLog(@"process params %@", data);
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
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              callback(json, nil);
          } else {
              callback(nil , error);
          }
      }] resume];
}

- (void)validateWithCode:(NSString *)code
             phoneNumber:(NSString *)phone
                callback:(void(^)(NSDictionary *data, NSError * error))callback {
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/validating"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *data = @{
                           @"code": code,
                           @"phone": phone,
                           @"sessID": self.sessionID
                           };
    NSLog(@"process params %@", data);
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
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              callback(json, nil);
          } else {
              callback(nil , error);
          }
      }] resume];
}

- (void)overtime: (void(^)(NSDictionary *data, NSError * error))callback {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/overtime"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *data = @{@"sessID": self.sessionID};
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
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              callback(json, nil);
          } else {
              callback(nil , error);
          }
      }] resume];
}

- (void)report: (void(^)(NSDictionary *data, NSError * error))callback {
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, @"/report"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSDictionary *data = @{@"sessID": self.sessionID};
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
          if (error == nil) {
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error ];
              callback(json, nil);
          } else {
              callback(nil , error);
          }
      }] resume];
}

@end
