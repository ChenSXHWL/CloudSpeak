//
//  MeInfoVC.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoEntity.h"

typedef void(^MeInfoVCBlock)(void);

@interface MeInfoVC : BaseViewController

@property (strong, nonatomic) MeInfoVCBlock meInfoVCBlock;

@property (strong, nonatomic) UserInfoEntity *userInfoEntity;

@end
