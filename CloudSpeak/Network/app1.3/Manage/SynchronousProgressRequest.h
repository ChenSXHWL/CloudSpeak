//
//  SynchronousProgressRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface SynchronousProgressRequest : RequestConfig

@property (strong, nonatomic)NSString * syncType;//同步类型，多类型逗号隔开faceid，card，dynamic，config

@property (strong, nonatomic)NSString * deviceNum;
@property (strong, nonatomic)NSString * uuid;

@end
