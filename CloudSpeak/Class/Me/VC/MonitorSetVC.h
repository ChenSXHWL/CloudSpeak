//
//  MonitorSetVC.h
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/20.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "BaseViewController.h"

#import "UserInfoEntity.h"
typedef void(^MeInfoVCBlock)(void);
typedef void(^MonitorSetVCBlock)(UserInfoEntity *);

@interface MonitorSetVC : BaseViewController

@property (strong, nonatomic)UserInfoEntity *userInfoEntity;

//@property (strong, nonatomic) MeInfoVCBlock meInfoVCBlock;

@property (strong, nonatomic) MonitorSetVCBlock communityInfoVCBlock;

@end
