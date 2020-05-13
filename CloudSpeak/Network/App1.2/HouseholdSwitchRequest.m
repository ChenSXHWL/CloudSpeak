//
//  HouseholdSwitchRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HouseholdSwitchRequest.h"

@implementation HouseholdSwitchRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/user/household/switch";
    
}
@end
