//
//  MeInfoTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"
#import "UserInfoEntity.h"

typedef void(^MeInfoTViewBlock)(void);

@interface MeInfoTView : AYCustomTView

@property (strong, nonatomic) UserInfoEntity *userInfoEntity;

@property (strong, nonatomic) MeInfoTViewBlock meInfoTViewBlock;

- (void)saveInfo;

@end
