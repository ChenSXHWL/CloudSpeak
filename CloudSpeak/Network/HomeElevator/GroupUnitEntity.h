//
//  GroupUnitEntity.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface GroupUnitEntity : EntityConfig

@property (copy, nonatomic) NSString *buildingName;//楼栋名称

@property (copy, nonatomic) NSString *unitName;//单元名称

@property (copy, nonatomic) NSString *roomGroup;//房号字符串；使用逗号隔开

@property (copy, nonatomic) NSString *unitId;//单元ID

@property (copy, nonatomic) NSString *buildingId;//楼栋ID

@property (copy, nonatomic) NSString *sipAccount;//

@property (copy, nonatomic) NSString *deviceNumList;//

@end
