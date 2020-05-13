//
//  LoginVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "LoginRequest.h"
#import "LoginEntity.h"

@interface LoginVM : SceneModelConfig

@property (strong, nonatomic) LoginRequest *loginRequest;

@property (strong, nonatomic) RACCommand *loginCommand;

@property (copy, nonatomic) NSString *scheme;

@property (copy, nonatomic) NSString *url;

@end
