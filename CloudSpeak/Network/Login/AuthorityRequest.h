//
//  AuthorityRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2018/6/14.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface AuthorityRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *communityId;
@end
