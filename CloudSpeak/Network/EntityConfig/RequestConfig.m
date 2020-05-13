//
//  RequestConfig.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/5.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RequestConfig

- (void)loadRequest
{
    [super loadRequest];
    
    self.METHOD = @"POST";
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *authorization = [NSString stringWithFormat:@"%@:%@:%@:%@",APP_key,dateTime,[LoginEntity shareManager].appUserId,[LoginEntity shareManager].uuid];
    NSData *data = [authorization dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *sign = [[NSString stringWithFormat:@"%@%@%@",APP_key,APP_secret,dateTime] MD5];
    
    //指定编码方式.默认0
    NSString *base64String= [data base64EncodedStringWithOptions:0];
    //    base64String = [base64String uppercaseString];
    
    if (!(sign.length>10)) {
        [[GCDQueue mainQueue] queueBlock:^{
            self.httpHeaderFields = [NSMutableDictionary dictionaryWithObjectsAndKeys:sign,@"sign",base64String,@"authorization",nil];
        } afterDelay:0.2f];
    }else{
        self.httpHeaderFields = [NSMutableDictionary dictionaryWithObjectsAndKeys:sign,@"sign",base64String,@"authorization",nil];
    }
//    NSLog(@"httpHeaderFields====%@",self.httpHeaderFields);
//    NSLog(@"sign====%@",sign);
//    NSLog(@"base64String====%@",base64String);

//    if (![LoginEntity shareManager].authorization.length) return;
//
//    self.httpHeaderFields = [NSMutableDictionary dictionaryWithObject:[LoginEntity shareManager].authorization forKey:@"authorization"];
}

@end
