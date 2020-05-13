//
//  UserInfoVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "UserInfoRequest.h"
#import "UserInfoEntity.h"

@interface UserInfoVM : SceneModelConfig

@property (strong, nonatomic) UserInfoRequest *userInfoRequest;

@property (strong, nonatomic) UserInfoEntity *userInfoEntity;

@end
