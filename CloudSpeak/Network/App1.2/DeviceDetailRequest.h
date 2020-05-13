//
//  DeviceDetailRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface DeviceDetailRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceNum;//业主ID

@property (copy, nonatomic) NSString *communityCode;//

//@property (copy, nonatomic) NSString *appUserId;//

@end
