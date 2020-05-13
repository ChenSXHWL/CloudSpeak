//
//  CommunityPhoneRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CommunityPhoneRequest : RequestConfig

@property (strong, nonatomic)NSString * communityCode;

@property (strong, nonatomic)NSString * phoneType;

@end
