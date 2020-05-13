//
//  GetConfigVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "GetConfigRequest.h"
#import "GetConfigEntity.h"

#import "CommunityInfoRequest.h"
#import "CommunityInfoEntity.h"

@interface GetConfigVM : SceneModelConfig

@property (strong, nonatomic) GetConfigRequest *getConfigRequest;

@property (strong, nonatomic) GetConfigEntity *getConfigEntity;

@property (strong, nonatomic) CommunityInfoRequest *communityInfoRequest;

@property (strong, nonatomic) CommunityInfoEntity *communityInfoEntity;


@end
