//
//  RegisterRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/register";
}

@end
