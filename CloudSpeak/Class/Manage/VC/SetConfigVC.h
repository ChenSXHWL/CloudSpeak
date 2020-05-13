//
//  SetConfigVC.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "GetConfigEntity.h"

typedef void(^SetConfigVCBlock)(NSString *, BOOL);

@interface SetConfigVC : BaseViewController

@property (strong, nonatomic) GetConfigEntity *getConfigEntity;

@property (copy, nonatomic) NSDictionary *getDeviceInfo;

@property (copy, nonatomic) NSString *sysXML;

@property (strong, nonatomic) SetConfigVCBlock setConfigVCBlock;

@end
