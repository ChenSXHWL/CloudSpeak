//
//  PropertyNnoticeListEntity.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface PropertyNnoticeListEntity : EntityConfig

@property (copy, nonatomic) NSString *imgUrl;//图片地址

@property (copy, nonatomic) NSString *noticeContent;//内容

@property (copy, nonatomic) NSString *noticeId;//id

@property (copy, nonatomic) NSString *createTime;//创建时间

@property (copy, nonatomic) NSString *readNum;//阅读数

@property (copy, nonatomic) NSString *noticeTime;//公告时间

@property (copy, nonatomic) NSString *noticeTitle;//标题

@property (copy, nonatomic) NSString *noticeType;//公告类型

@property (copy, nonatomic) NSString *readFlag;//公告状态：0未读，1已读

@property (copy, nonatomic) NSString *domain;//图片头

@end
