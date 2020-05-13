//
//  OpenRecordEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface OpenRecordEntity : EntityConfig

@property (copy, nonatomic) NSString *imgUrl;

@property (copy, nonatomic) NSString *openType;

@property (copy, nonatomic) NSString *openDay;

@property (copy, nonatomic) NSString *domain;

@property (copy, nonatomic) NSString *openTime;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *openStatus;

@end
