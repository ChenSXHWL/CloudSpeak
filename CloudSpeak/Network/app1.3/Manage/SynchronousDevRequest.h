//
//  SynchronousDevRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface SynchronousDevRequest : RequestConfig

@property (strong, nonatomic)NSString * deviceNum;
@property (strong, nonatomic)NSString * communityCode;

@end
