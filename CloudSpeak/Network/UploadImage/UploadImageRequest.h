//
//  UploadImageRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface UploadImageRequest : RequestConfig

@property (copy, nonatomic) NSString *cipher;

@property (copy, nonatomic) NSString *communityCode;

+(NSString*)HloveyRC4:(NSString*)aInput key:(NSString*)aKey;

@end
