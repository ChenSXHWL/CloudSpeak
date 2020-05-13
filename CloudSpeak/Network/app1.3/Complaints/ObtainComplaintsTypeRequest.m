//
//  ObtainComplaintsTypeRequest.m
//  CloudSpeak
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ObtainComplaintsTypeRequest.h"

@implementation ObtainComplaintsTypeRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/property/complainType";
    
}
@end
