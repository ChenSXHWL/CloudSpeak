//
//  VersionUpEntity.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface VersionUpEntity : EntityConfig

@property (copy, nonatomic) NSString *appVersion;//app版本


@property (copy, nonatomic) NSString *qrcodeUrl;//下载二维码

@property (copy, nonatomic) NSString *appLogo;//applogo地址

@property (copy, nonatomic) NSString *upgradeDetail;//更新详情

@property (copy, nonatomic) NSString *appType;//升级类型，1强制升级，2一般升级；

@end
