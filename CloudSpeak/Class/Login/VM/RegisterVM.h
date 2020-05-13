//
//  RegisterVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "RegisterRequest.h"

@interface RegisterVM : SceneModelConfig

@property (strong, nonatomic) RegisterRequest *registerRequest;

@property (strong, nonatomic) RACCommand *registerCommand;

@end
