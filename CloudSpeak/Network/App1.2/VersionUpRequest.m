//
//  VersionUpRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "VersionUpRequest.h"

@implementation VersionUpRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/app/version";
    
}
@end
