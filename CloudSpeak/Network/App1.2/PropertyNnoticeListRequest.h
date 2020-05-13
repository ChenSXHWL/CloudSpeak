//
//  PropertyNnoticeListRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface PropertyNnoticeListRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *communityId;

@property (copy, nonatomic) NSString *noticeType;

@property (copy, nonatomic) NSString *pageIndex;

@property (copy, nonatomic) NSString *pageSize;

@end
