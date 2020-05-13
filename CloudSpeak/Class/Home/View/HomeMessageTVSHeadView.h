//
//  HomeMessageTVSHeadView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenRecordEntity.h"


@interface HomeMessageTVSHeadView : UIView

@property (copy, nonatomic) OpenRecordEntity *openRecordEntity;

@property (assign, nonatomic) BOOL isShowLine;

@end
