//
//  ReBootRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface ReBootRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *communityCode;

@end
