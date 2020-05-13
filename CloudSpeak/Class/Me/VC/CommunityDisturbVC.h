//
//  CommunityDisturbVC.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "HouseList.h"

typedef void(^CommunityInfoVCBlock)(HouseList *);

@interface CommunityDisturbVC : BaseViewController

@property (strong, nonatomic) HouseList *houseList;

@property (strong, nonatomic) CommunityInfoVCBlock communityInfoVCBlock;

@end
