//
//  HomeGuardLocVC.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "NavigationBarColorVC.h"
#import "GetMyKeyEntity.h"

typedef void(^HomeGuardLocVCBlock)(NSString *);

@interface HomeGuardLocVC : NavigationBarColorVC

@property (strong, nonatomic) UIImageView *videoView;

@property (copy, nonatomic) GetMyKeyEntity *getMyKeyEntity;

@property (strong, nonatomic) HomeGuardLocVCBlock homeGuardLocVCBlock;

@property (assign, nonatomic) BOOL isTest;

@end
