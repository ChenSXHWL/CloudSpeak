//
//  ElevatorControlRequest.h
//  neighborplatform
//
//  Created by 陈思祥 on 2018/3/22.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface ElevatorControlRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceList;//设备编码 设备列表，逗号隔开多设备

@property (copy, nonatomic) NSString *communityCode;//小区号

@property (copy, nonatomic) NSString *householdId;//住户id

@property (copy, nonatomic) NSString *floor;//楼层(保留字段)

@property (copy, nonatomic) NSString *direct;//方向：1-上行、2-下行

@end
