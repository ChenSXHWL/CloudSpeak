//
//  SceneModelConfig.m
//  ishanghome
//
//  Created by DNAKE_AY on 17/1/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import <CommonCrypto/CommonCryptor.h>
#import "LoginRequest.h"
#import "GuideVC.h"
#import "CheckAuthorizationRequest.h"
@implementation SceneModelConfig

- (void)loadSceneModel
{
    [super loadSceneModel];
    
}
-(void)SEND_ACTION:(Request *)req{
    
    NSArray *array = [req.PATH componentsSeparatedByString:@"/"];

    if ([array[3] isEqualToString:@"base"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        NSString *authorization = [NSString stringWithFormat:@"%@:%@",APP_key,dateTime];
        NSData *data = [authorization dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String= [data base64EncodedStringWithOptions:0];
        req.httpHeaderFields = [NSMutableDictionary dictionaryWithObjectsAndKeys:base64String,@"authorization",nil];
    }
    NSMutableDictionary * requestParams = [req.requestParams mutableCopy];
    
    [requestParams removeObjectForKey:@"cipher"];
    
    NSString *cipher;
    
    if (requestParams.allKeys.count>0) {
        NSLog(@"requestParamsSSS === %@",requestParams);
        
        for (int i = 0; i<requestParams.allKeys.count; i++) {
            NSLog(@"allKeys === %@",requestParams.allKeys[i]);
            NSLog(@"allValues === %@",requestParams.allValues[i]);
            
            if (i==0) {
                cipher = [NSString stringWithFormat:@"%@=%@",requestParams.allKeys[i],requestParams.allValues[i]];
            }else{
                cipher = [NSString stringWithFormat:@"%@&%@=%@",cipher,requestParams.allKeys[i],requestParams.allValues[i]];
            }
        }
        NSLog(@"cipher === %@",cipher);
        cipher = [self HttpEncrtpt:cipher key:APP_secret];
        NSLog(@"cipherRC4 === %@",cipher);
        
        requestParams = [[NSDictionary dictionaryWithObject:cipher forKey:@"cipher"] mutableCopy];
        NSLog(@"requestParams === %@",requestParams);
        NSMutableDictionary *dic =[requestParams mutableCopy];
        req.params = nil;
        req.params = dic ;
    }
    NSNumber *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"networkStatus"];

    if (status.intValue==0) {
        return [AYProgressHud progressHudShowShortTimeMessage:@"连接失败，请检查你的网络后重试！"];
    }
    
    [super SEND_ACTION:req];
}
-(void)SEND_IQ_ACTION:(Request *)req{
    
    NSArray *array = [req.PATH componentsSeparatedByString:@"/"];
    
    if ([array[3] isEqualToString:@"base"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        NSString *authorization = [NSString stringWithFormat:@"%@:%@",APP_key,dateTime];
        NSData *data = [authorization dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String= [data base64EncodedStringWithOptions:0];
        req.httpHeaderFields = [NSMutableDictionary dictionaryWithObjectsAndKeys:base64String,@"authorization",nil];
    }
    NSMutableDictionary * requestParams = [req.requestParams mutableCopy];
    
    [requestParams removeObjectForKey:@"cipher"];
    
    NSString *cipher;
    
    if (requestParams.allKeys.count>0) {
        NSLog(@"requestParamsSSS === %@",requestParams);
        
        for (int i = 0; i<requestParams.allKeys.count; i++) {
            NSLog(@"allKeys === %@",requestParams.allKeys[i]);
            NSLog(@"allValues === %@",requestParams.allValues[i]);
            
            if (i==0) {
                cipher = [NSString stringWithFormat:@"%@=%@",requestParams.allKeys[i],requestParams.allValues[i]];
            }else{
                cipher = [NSString stringWithFormat:@"%@&%@=%@",cipher,requestParams.allKeys[i],requestParams.allValues[i]];
            }
        }
        NSLog(@"cipher === %@",cipher);
        cipher = [self HttpEncrtpt:cipher key:APP_secret];
        NSLog(@"cipherRC4 === %@",cipher);
        
        requestParams = [[NSDictionary dictionaryWithObject:cipher forKey:@"cipher"] mutableCopy];
        NSLog(@"requestParams === %@",requestParams);
        NSMutableDictionary *dic =[requestParams mutableCopy];
        req.params = nil;
        req.params = dic ;
    }
    NSNumber *status = [[NSUserDefaults standardUserDefaults] objectForKey:@"networkStatus"];

    if (status.intValue==0) {
        return [AYProgressHud progressHudShowShortTimeMessage:@"连接失败，请检查你的网络后重试！"];
    }
    [super SEND_IQ_ACTION:req];
}

- (NSString *)HttpEncrtpt:(NSString *)plainText key:(NSString *)newKey {
    
    NSMutableString *result = [[NSMutableString alloc]init];
    
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    char *plainByte = (char *)[plainTextData bytes];
    
    NSData *md5KeyData = [newKey dataUsingEncoding:NSUTF8StringEncoding];
    //rc4
    NSData *retData = [self RC4Encrypt11:plainByte plainTextLength:plainTextData.length key:(char *)[md5KeyData bytes] akeyLength:md5KeyData.length];
    
    NSString *str = [self convertDataToHexStr:retData];
    
    return str;
}
-(NSData *)RC4Encrypt11:(char *)plainText plainTextLength:(uint32_t )ptLength
                    key:(char *)akey akeyLength:(uint32_t)akeyLength
{
    CCCryptorRef cryptor = NULL;
    NSData* data ;//=[plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData* key; //=[akey dataUsingEncoding:NSUTF8StringEncoding];
    
    data = [NSData dataWithBytes:plainText length:ptLength];
    
    key = [NSData dataWithBytes:akey length:akeyLength];
    // 1. Create a cryptographic context.
    CCCryptorStatus status = CCCryptorCreate(kCCEncrypt, kCCAlgorithmRC4, kCCOptionPKCS7Padding, [key bytes], [key length], NULL, &cryptor );
    
    NSAssert(status == kCCSuccess, @"Failed to create a cryptographic context.");
    
    NSMutableData *retData = [NSMutableData new];
    
    // 2. Encrypt or decrypt data.
    NSMutableData *buffer = [NSMutableData data];
    [buffer setLength:CCCryptorGetOutputLength(cryptor, [data length], true)]; // We'll reuse the buffer in -finish
    
    size_t dataOutMoved;
    status = CCCryptorUpdate(cryptor, data.bytes, data.length, buffer.mutableBytes, buffer.length, &dataOutMoved);
    NSAssert(status == kCCSuccess, @"Failed to encrypt or decrypt data");
    [retData appendData:[buffer subdataWithRange:NSMakeRange(0, dataOutMoved)]];
    
    // 3. Finish the encrypt or decrypt operation.
    status = CCCryptorFinal(cryptor, buffer.mutableBytes, buffer.length, &dataOutMoved);
    NSAssert(status == kCCSuccess, @"Failed to finish the encrypt or decrypt operation");
    [retData appendData:[buffer subdataWithRange:NSMakeRange(0, dataOutMoved)]];
    CCCryptorRelease(cryptor);
    
    return retData;
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

- (void)handleActionMsg:(Request *)msg
{
    
    if (msg.state == RequestStateSending) return;
    
    NSString *success = msg.output[@"isSuccess"];
//    NSString *error = msg.output[@"msg"];

    if (success.intValue == 3) {
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[GuideVC class]]||[[URLNavigation navigation].currentViewController isKindOfClass:[LoginVC class]]) {
            return ;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"successLoginOut" object:@"您的账号已在别处登录，请确认是否是本人登录"];
        
    }else {
        if ([msg isKindOfClass:[CheckAuthorizationRequest class]]) {
            if (success.intValue==0){
                
                if ([[URLNavigation navigation].currentViewController isKindOfClass:[GuideVC class]]||[[URLNavigation navigation].currentViewController isKindOfClass:[LoginVC class]]) {
                    return ;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"successLoginOut" object:@"您的账号已经失效"];
                
            }
        }
        
    }
}

@end


