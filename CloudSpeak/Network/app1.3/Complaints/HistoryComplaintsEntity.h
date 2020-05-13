//
//  HistoryComplaintsEntity.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface HistoryComplaintsEntity : EntityConfig

@property (copy, nonatomic) NSString *createtime;//时间

@property (copy, nonatomic) NSString *content;//内容

@property (copy, nonatomic) NSString *complainType;//投诉类型

@property (copy, nonatomic) NSString *imgUrlList;//图片地址url，逗号隔开

@property (copy, nonatomic) NSString *complainStatus;//投诉处理状态

@end
