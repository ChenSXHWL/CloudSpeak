//
//  EngineeringRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/7/31.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EngineeringRequest.h"

@implementation EngineeringRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/getConfigUrl";
    self.SCHEME = @"https";
    self.HOST = @"cmp.ishanghome.com/cmp";
    self.METHOD = @"GET";
}
@end
