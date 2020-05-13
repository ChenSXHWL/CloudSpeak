//
//  InviteCodeVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "InviteCodeRequest.h"
#import "InviteCodeEntity.h"
#import "InvalidCodeHighRequest.h"
@interface InviteCodeVM : SceneModelConfig

@property (strong, nonatomic) InviteCodeRequest *inviteCodeRequest;

@property (strong, nonatomic) InviteCodeEntity *inviteCodeEntity;

@property (strong, nonatomic) InvalidCodeHighRequest *invalidCodeHighRequest;

@end
