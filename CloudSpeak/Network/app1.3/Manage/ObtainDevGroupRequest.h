//
//  ObtainDevGroupRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface ObtainDevGroupRequest : RequestConfig

@property (strong, nonatomic)NSString * communityCode;
@property (strong, nonatomic)NSString * deviceNum;

@end
