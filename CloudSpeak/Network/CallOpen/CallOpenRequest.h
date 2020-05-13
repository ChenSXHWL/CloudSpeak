//
//  CallOpenRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CallOpenRequest : RequestConfig

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *interactiveType;

@property (copy, nonatomic) NSString *imgUrl;

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *openStatus;

@end
