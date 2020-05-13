//
//  DeviceListEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface DeviceListEntity : EntityConfig

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *sipAccount;

@end
