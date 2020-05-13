//
//  UserInfoEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"
#import "CommunityListArrayEntity.h"

@interface UserInfoEntity : EntityConfig

@property (copy, nonatomic) NSString *imgUrl;

@property (copy, nonatomic) NSString *nickName;

@property (copy, nonatomic) NSArray *communityList;

@property (copy, nonatomic) NSString *domain;

@property (copy, nonatomic) NSString *loginName;

@property (copy, nonatomic) NSString *sipAccount;

@property (copy, nonatomic) NSString *sipPassword;

@property (copy, nonatomic) NSString *sipMobile;

@property (copy, nonatomic) NSString *sipSwitch;

@property (copy, nonatomic) NSString *callSwitch;


@end
