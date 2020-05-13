//
//  CheckAuthorizationVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/6/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//
#import "SceneModelConfig.h"
#import <EasyIOS/EasyIOS.h>
#import "CheckAuthorizationRequest.h"

@interface CheckAuthorizationVM : SceneModelConfig

@property (strong, nonatomic) CheckAuthorizationRequest *checkAuthorizationRequest;

@end
