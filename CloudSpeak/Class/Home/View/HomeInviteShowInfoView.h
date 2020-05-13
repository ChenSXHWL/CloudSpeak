//
//  HomeInviteShowInfoView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteCodeEntity.h"

@interface HomeInviteShowInfoView : UIView

@property (copy, nonatomic) InviteCodeEntity *inviteCodeEntity;

@property (copy, nonatomic) NSString *inviteCodeString;

- (void)layoutOpenView;

@end
