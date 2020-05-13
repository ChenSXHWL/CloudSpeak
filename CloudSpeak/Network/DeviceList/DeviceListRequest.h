//
//  DeviceListRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface DeviceListRequest : RequestConfig

@property (copy, nonatomic) NSString *communityCode;//小区编码

@property (copy, nonatomic) NSString *buildingId;//楼栋id

@property (copy, nonatomic) NSString *unitId;//单元id

@end
