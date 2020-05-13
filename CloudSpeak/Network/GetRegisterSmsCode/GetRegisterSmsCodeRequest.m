//
//  GetRegisterSmsCodeRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/5.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetRegisterSmsCodeRequest.h"

@implementation GetRegisterSmsCodeRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/getRegisterSmsCode";
    
    
}

@end
