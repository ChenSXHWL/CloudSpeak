//
//  LoginRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/login";
    
    self.platform = @(0);
    
    self.clusterAccountId =  ClusterAccountId;
}

@end
