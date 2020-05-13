//
//  HouseList.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface HouseList : EntityConfig

@property (copy, nonatomic) NSString *buildingName;

@property (copy, nonatomic) NSString *unitName;

@property (copy, nonatomic) NSString *roomNum;

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *roomId;

@property (copy, nonatomic) NSString *communityName;

@property (copy, nonatomic) NSString *unitId;

@property (copy, nonatomic) NSString *zoneName;

@property (copy, nonatomic) NSString *communityId;

@property (copy, nonatomic) NSString *buildingId;

@property (copy, nonatomic) NSString *zoneId;

@property (copy, nonatomic) NSString *householdName;

@property (copy, nonatomic) NSString *householdType;//住户类型

@property (copy, nonatomic) NSString *callSwitch;//业主呼叫开关:0关闭，1开启

@property (copy, nonatomic) NSString *sipSwitch;//呼叫转移开关：1关；0开 2夜间；

@property (copy, nonatomic) NSString *householdStatus;//业主状态：0注销；1启用

@property (copy, nonatomic) NSString *dueDate;//到期时间；

@end
