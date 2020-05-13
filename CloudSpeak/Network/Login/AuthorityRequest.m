//
//  AuthorityRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2018/6/14.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "AuthorityRequest.h"

@implementation AuthorityRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/user/authority";
}

@end
