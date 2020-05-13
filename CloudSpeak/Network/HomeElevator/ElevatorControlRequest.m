//
//  ElevatorControlRequest.m
//  neighborplatform
//
//  Created by 陈思祥 on 2018/3/22.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ElevatorControlRequest.h"

@implementation ElevatorControlRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/elevator/appoint";

}
@end
