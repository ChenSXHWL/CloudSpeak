//
//  HistoryComplaintsRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface HistoryComplaintsRequest : RequestConfig

@property (strong, nonatomic)NSString * communityId;

@property (strong, nonatomic)NSString * appUserId;

@property (strong, nonatomic)NSString * complainType;//投诉类型

@property (strong, nonatomic)NSString * complainStatus;//投诉处理状态

@end
