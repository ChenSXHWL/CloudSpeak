//
//  LoginEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 14-5-16.
//  Copyright (c) 2017年 com.dnake. All rights reserved.
//

#import "EntityConfig.h"
//#import "CommunityList.h"

@interface LoginEntity : EntityConfig

@property (copy, nonatomic) NSArray * communityList;
@property (strong, nonatomic) NSNumber * changeVillage;//1变 0不变

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *roleId;

@property (copy, nonatomic) NSString *sipAccount;

@property (copy, nonatomic) NSString *sipPassword;

@property (copy, nonatomic) NSString *phone;

@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSString *authorization;

@property (copy, nonatomic) NSString *sipMobile;

@property (copy, nonatomic) NSString *sipNumber;

@property (strong, nonatomic) NSNumber *page;

@property (copy, nonatomic) NSString *scheme;

@property (copy, nonatomic) NSString *url;

@property (copy, nonatomic) NSString *uuid;

+ (LoginEntity *)shareManager;

//- (void)modelOfDictionary;

@end
