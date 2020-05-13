//
//  SynchronousDevRequest.m
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "SynchronousDevRequest.h"

@implementation SynchronousDevRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/sync";
    
}
@end
