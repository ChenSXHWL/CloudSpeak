//
//  UploadConfigRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface UploadConfigRequest : RequestConfig

@property (copy, nonatomic) NSString *configStr;

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *timeStamp;

@property (copy, nonatomic) NSString *zoneId;

@property (copy, nonatomic) NSString *buildingId;

@property (copy, nonatomic) NSString *unitId;

@property (copy, nonatomic) NSString *sipAccount;

@property (copy, nonatomic) NSString *deviceCode;

@property (copy, nonatomic) NSString *enterFlag;

@property (copy, nonatomic) NSString *outFlag;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *buildingCode;

@property (copy, nonatomic) NSString *unitCode;

@property (copy, nonatomic) NSString *gpsAddress;

@property (copy, nonatomic) NSString *defCommunityCode;

@property (copy, nonatomic) NSString *deviceType;

@property (copy, nonatomic) NSString <Ignore> *communityId;

@end
