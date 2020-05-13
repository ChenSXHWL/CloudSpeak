//
//  OpenHistoryRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface OpenHistoryRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *pageIndex;

@property (copy, nonatomic) NSString *pageSize;

@end
