//
//  DetailsWarrantyVC.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "RepairHistoryEntity.h"
@interface DetailsWarrantyVC : BaseViewController

@property (strong, nonatomic)RepairHistoryEntity *repairHistoryEntity;

@property (strong, nonatomic)NSArray *repairStatusList;
@property (strong, nonatomic)NSArray *repairTypeList;
@end
