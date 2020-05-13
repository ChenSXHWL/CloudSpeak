//
//  GuideVC.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"

@interface GuideVC : BaseViewController

@property (assign, nonatomic) BOOL isLogin;

@property (strong, nonatomic) NSString *formalStr;

@property (copy, nonatomic) NSString *scheme;

@property (copy, nonatomic) NSString *loginPhone;

@end
