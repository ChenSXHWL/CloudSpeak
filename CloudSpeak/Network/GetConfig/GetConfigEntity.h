//
//  GetConfigEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"
#import "Volumn.h"
#import "Ad.h"
#import "Uid.h"
#import "Lan.h"
#import "Talk.h"
#import "Gps.h"
#import "Sip.h"
#import "Stun.h"
#import "Gid.h"
#import "Admin.h"
#import "Panel.h"
#import "Dnps.h"
#import "Version.h"

@interface GetConfigEntity : EntityConfig

@property (strong, nonatomic) Volumn *volume;

@property (strong, nonatomic) Ad *ad;

@property (strong, nonatomic) Uid *uid;

@property (strong, nonatomic) Lan *lan;

@property (strong, nonatomic) Talk *talk;

@property (strong, nonatomic) Gps *gps;

@property (strong, nonatomic) Sip *sip;

@property (strong, nonatomic) Stun *stun;

@property (strong, nonatomic) Gid *gid;

@property (strong, nonatomic) Admin *admin;

@property (strong, nonatomic) Panel *panel;

@property (strong, nonatomic) Dnps *dnps;

@property (strong, nonatomic) Version *version;

@end
