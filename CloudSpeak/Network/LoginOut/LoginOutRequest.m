//
//  LoginOutRequest.m
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/18.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "LoginOutRequest.h"

@implementation LoginOutRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/logout";
    
    self.appUserId = [LoginEntity shareManager].appUserId;
}

@end
