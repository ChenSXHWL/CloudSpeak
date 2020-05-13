//
//  MeTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"
#import "UserInfoEntity.h"

typedef void(^ClickHeadOrCellToPushBlock)(NSString *);

@interface MeTView : AYCustomTView

@property (strong, nonatomic) ClickHeadOrCellToPushBlock clickBlock;

@property (strong, nonatomic) UserInfoEntity *userInfoEntity;

@end
