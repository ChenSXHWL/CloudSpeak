//
//  MeInfoTVHeadView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoEntity.h"

typedef void(^MeInfoTVHeadViewBlock)(NSString *, NSString *);

@interface MeInfoTVHeadView : UIView

@property (strong, nonatomic) UserInfoEntity *userInfoEntity;

@property (strong, nonatomic) MeInfoTVHeadViewBlock meInfoTVHeadViewBlock;

@end
