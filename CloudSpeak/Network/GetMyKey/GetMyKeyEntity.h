//
//  GetMyKeyEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface GetMyKeyEntity : EntityConfig

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *roomNum;

@property (copy, nonatomic) NSString *sipAccount;

@property (copy, nonatomic) NSString *onlineStatus;

@property (copy, nonatomic) NSString *deviceGps;//经纬度信息

@property (copy, nonatomic) NSString *deviceAddress;//设备地址

@property (copy, nonatomic) NSString *buildingCode;//楼栋号

@property (copy, nonatomic) NSString *unitCode;//单元号

@property (copy, nonatomic) NSString *dueDate;//到期时间



@end
