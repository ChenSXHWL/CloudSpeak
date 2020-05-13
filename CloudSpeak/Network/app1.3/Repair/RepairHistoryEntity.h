//
//  RepairHistoryEntity.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface RepairHistoryEntity : EntityConfig

@property (copy, nonatomic) NSString *createtime;//上报时间

@property (copy, nonatomic) NSNumber *id;//内容

@property (copy, nonatomic) NSString *repairStatus;//报修状态： 1未处理，2处理

@property (copy, nonatomic) NSString *endVisitDate;//上门截止时间

@property (copy, nonatomic) NSString *location;//地址

@property (copy, nonatomic) NSString *reportProblem;//报修原因

@property (copy, nonatomic) NSString *reportImgUrl;//图片地址url，逗号隔开

@property (copy, nonatomic) NSString *communityName;//小区名字

@property (copy, nonatomic) NSString *startVisitDate;//上门开始时间

@property (copy, nonatomic) NSString *repairType;//报修类型

@property (copy, nonatomic) NSString *modifytime;//处理时间

@property (copy, nonatomic) NSString *deviceNum;//处理时间


@end
