//
//  GetDeviceGroupEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface GetDeviceGroupEntity : EntityConfig

@property (copy, nonatomic) NSString *deviceGroupName;

@property (copy, nonatomic) NSString *deviceGroupId;

@property (copy, nonatomic) NSString *deviceGroupType;

@end
