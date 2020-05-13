//
//  CommunityPhoneRequest.m
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "CommunityPhoneRequest.h"

@implementation CommunityPhoneRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/property/communityPhone";
    
}
@end
