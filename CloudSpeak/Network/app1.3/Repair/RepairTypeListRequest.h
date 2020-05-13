//
//  RepairTypeListRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface RepairTypeListRequest : RequestConfig

@property (copy, nonatomic) NSString *communityCode;//小区id

@property (copy, nonatomic) NSString *appUserId;//app用户id

@end
