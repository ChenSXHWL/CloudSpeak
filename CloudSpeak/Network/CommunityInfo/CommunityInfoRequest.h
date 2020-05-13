//
//  CommunityInfoRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CommunityInfoRequest : RequestConfig

@property (copy, nonatomic) NSString *communityId;

@property (copy, nonatomic) NSString *zoneId;

@property (copy, nonatomic) NSString *unitId;

@property (copy, nonatomic) NSString *buildingId;

@end
