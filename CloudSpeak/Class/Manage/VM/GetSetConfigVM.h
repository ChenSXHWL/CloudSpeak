//
//  GetSetConfigVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "GetSettingConfigRequest.h"
#import "GetSettingConfigEntity.h"

@interface GetSetConfigVM : SceneModelConfig

@property (strong, nonatomic) GetSettingConfigRequest *getSettingConfigRequest;

@end
