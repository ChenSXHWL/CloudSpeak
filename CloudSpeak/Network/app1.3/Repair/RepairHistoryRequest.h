//
//  RepairHistoryRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface RepairHistoryRequest : RequestConfig

@property (copy, nonatomic) NSString *communityId;//小区id

@property (copy, nonatomic) NSString *appUserId;//app用户id

@end
