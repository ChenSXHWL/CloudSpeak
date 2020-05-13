//
//  OpenRecordRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface OpenRecordRequest : RequestConfig

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *pageIndex;

@property (copy, nonatomic) NSString *pageSize;

@end
