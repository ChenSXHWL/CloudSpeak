//
//  ManageSettingTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/30.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"

typedef void(^MeManageSettingCompletionBlock)(void);

@interface ManageSettingTView : AYCustomTView

@property (strong, nonatomic) MeManageSettingCompletionBlock manageSettingBlock;

@end
