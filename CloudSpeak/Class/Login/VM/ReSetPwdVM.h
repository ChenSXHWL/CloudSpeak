//
//  ReSetPwdVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "ResetPwdRequest.h"

@interface ReSetPwdVM : SceneModelConfig

@property (strong, nonatomic) ResetPwdRequest *resetPwdRequest;

@property (strong, nonatomic) RACCommand *resetPwdCommand;

@end
