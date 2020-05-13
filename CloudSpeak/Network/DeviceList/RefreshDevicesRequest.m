//
//  RefreshDevicesRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2018/5/8.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RefreshDevicesRequest.h"

@implementation RefreshDevicesRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/refreshDevices";
    
}
@end
