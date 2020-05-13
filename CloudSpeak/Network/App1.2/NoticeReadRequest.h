//
//  NoticeReadRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface NoticeReadRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *noticeId;

@end
