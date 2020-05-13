//
//  GetRegiterSmsCodeVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/5.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
/*获取验证码*/
#import "GetRegisterSmsCodeRequest.h"
#import "GetRegisterSmsCodeEntity.h"
/*下一步 验证验证码*/
#import "CheckSmsCodeRequest.h"

@interface GetRegiterSmsCodeVM : SceneModelConfig

/*获取验证码*/
@property (strong, nonatomic) GetRegisterSmsCodeRequest *getRegisterSmsCodeRequest;

@property (strong, nonatomic) RACCommand *getCodeCommond;

/*下一步 验证验证码*/

@property (strong, nonatomic) CheckSmsCodeRequest *checkSmsCodeRequest;

@property (strong, nonatomic) RACCommand *nextCommond;

@end
