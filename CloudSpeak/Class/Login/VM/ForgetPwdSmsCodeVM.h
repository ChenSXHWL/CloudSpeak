//
//  ForgetPwdSmsCodeVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "ForgetPwdSmsCodeRequest.h"
#import "CheckPwdByFgSmsCodeRequest.h"

@interface ForgetPwdSmsCodeVM : SceneModelConfig

@property (strong, nonatomic) ForgetPwdSmsCodeRequest *forgetPwdSmsCodeRequest;

@property (strong, nonatomic) RACCommand *forgetPwdSmsCodeCommond;

@property (strong, nonatomic) CheckPwdByFgSmsCodeRequest *checkPwdByFgSmsCodeRequest;

@property (strong, nonatomic) RACCommand *checkPwdByFgSmsCodeCommond;



@end
