//
//  InvalidCodeRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface InvalidCodeHighRequest : RequestConfig

@property (copy, nonatomic) NSNumber *deviceGroupId;//设备分组id

//@property (copy, nonatomic) NSString *householdId;//业主id

@property (copy, nonatomic) NSString *communityCode;//社区编号

@property (copy, nonatomic) NSString *time;//日期时间段JSON保护以下2个参数；示例：[{ "start_time": 1233,"end_time": 3344,"once": 3344}，{ "start_time": 1233,"end_time": 3344,"once": 3344}]

@property (copy, nonatomic) NSString *appUserId;//app用户id

@property (copy, nonatomic) NSString *startDate;//最早时间

@property (copy, nonatomic) NSString *endDate;//最晚时间

//@property (copy, nonatomic) NSNumber *times;//开锁次数：无限次：0；一次：1；

@end
