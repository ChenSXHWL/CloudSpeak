//
//  DeviceDetailRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceDetailRequest.h"

@implementation DeviceDetailRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/detail";
    
}
@end
