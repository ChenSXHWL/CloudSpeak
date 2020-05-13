//
//  HouseholdInfoRequest.m
//  neighborplatform
//
//  Created by 陈思祥 on 2018/4/23.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "HouseholdInfoRequest.h"

@implementation HouseholdInfoRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/user/household/info";
    
    self.appUserId = [LoginEntity shareManager].appUserId;
    
}
@end
