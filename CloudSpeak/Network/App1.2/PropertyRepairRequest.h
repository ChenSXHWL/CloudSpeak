//
//  PropertyRepairRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface PropertyRepairRequest : RequestConfig

@property (copy, nonatomic) NSString *communityId;//小区id

@property (copy, nonatomic) NSString *appUserId;//app用户id

@property (copy, nonatomic) NSString *deviceId;//设备id

@property (copy, nonatomic) NSString *reportProblem;//报修原因

@property (copy, nonatomic) NSString *reportImgUrl;//多图url，逗号隔开

@end
