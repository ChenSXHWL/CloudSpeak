//
//  AdvertisingListRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface AdvertisingListRequest : RequestConfig
@property (strong, nonatomic)NSString * communityCode;

@property (strong, nonatomic)NSString * pageIndex;

@property (strong, nonatomic)NSString * pageSize;

@end
