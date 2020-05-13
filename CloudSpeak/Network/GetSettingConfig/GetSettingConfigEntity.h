//
//  GetSettingConfigEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface GetSettingConfigEntity : EntityConfig

@property (copy, nonatomic) NSString *qrcodeSetting;

@property (copy, nonatomic) NSString *leftbar;

@property (copy, nonatomic) NSString *infoSetting;

@property (copy, nonatomic) NSString *networkSetting;

@property (copy, nonatomic) NSString *deviceSetting;

@property (copy, nonatomic) NSString *otherSetting;

@property (copy, nonatomic) NSString *accessSetting;

@end
