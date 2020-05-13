//
//  UploadConfigRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UploadConfigRequest.h"

@implementation UploadConfigRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/uploadConfig";
    self.unitId = @"0";
    self.unitCode = @"0";
    self.buildingId = @"0";
    self.buildingCode = @"0";
}

@end
