//
//  HouseholdInfoRequest.h
//  neighborplatform
//
//  Created by 陈思祥 on 2018/4/23.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface HouseholdInfoRequest : RequestConfig

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *buildingCode;

@property (copy, nonatomic) NSString *unitCode;

@property (copy, nonatomic) NSString *deviceGroupId;

@end
