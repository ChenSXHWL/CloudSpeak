//
//  WarrantyVC.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/2.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "HouseList.h"
#import "UserInfoEntity.h"
@interface WarrantyVC : BaseViewController

@property (strong, nonatomic)NSArray *dataArray;
@property (strong, nonatomic)NSArray *repairStatusList;
@property (strong, nonatomic)NSArray *repairTypeList;
@property (strong, nonatomic)UserInfoEntity *userInfoEntity;

@end
