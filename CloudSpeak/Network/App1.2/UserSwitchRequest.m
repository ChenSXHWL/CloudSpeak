//
//  UserSwitchRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UserSwitchRequest.h"

@implementation UserSwitchRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/user/changeSwitch";
    
}
@end
