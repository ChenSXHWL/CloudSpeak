//
//  GetConfigRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface GetConfigRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *communityCode;

@end
