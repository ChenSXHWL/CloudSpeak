//
//  HomeGuardCView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetMyKeyEntity;

typedef void(^GuardBlock)(GetMyKeyEntity *);

@interface HomeGuardCView : UICollectionView

+ (instancetype)setupHomeGuardCView;

@property (strong, nonatomic) GuardBlock guardBlock;

@end
