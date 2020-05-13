//
//  DeviceInfoEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface DeviceInfoEntity : EntityConfig

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *unitName;

@property (copy, nonatomic) NSString *deviceCode;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *communityName;

@property (copy, nonatomic) NSString *unitId;

@property (copy, nonatomic) NSString *buildingName;

@property (copy, nonatomic) NSString *zoneName;

@property (copy, nonatomic) NSString *buildingId;

@property (copy, nonatomic) NSString *zoneId;

@property (copy, nonatomic) NSString *communityId;

@property (copy, nonatomic) NSString *sipAccount;

@property (copy, nonatomic) NSString *sipPassword;

@property (copy, nonatomic) NSString *buildingCode;

@property (copy, nonatomic) NSString *unitCode;

@property (copy, nonatomic) NSString *gpsAddress;
//小区云对讲开关：0，关闭；1，打开；
@property (copy, nonatomic) NSString *cloudSwitch;

@property (copy, nonatomic) NSString *deviceId;

@end
