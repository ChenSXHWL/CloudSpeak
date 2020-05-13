//
//  ObtainDevGroupEntity.h
//  CloudSpeak
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface ObtainDevGroupEntity : EntityConfig
@property (strong, nonatomic)NSString * groupType;//设备组类型

@property (strong, nonatomic)NSString * deviceGroupName;//设备组名称

@property (strong, nonatomic)NSString * id;

@property (strong, nonatomic)NSString * groupTypeName;//设备组类型名称

@property (strong, nonatomic)NSString * deviceNums;//

@property (strong, nonatomic)NSString * unitId;//单元id

@property (assign, nonatomic)BOOL  choose;//YES 选中


@end
