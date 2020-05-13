//
//  HomeInviteOpenTVCell.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenHistoryEntity.h"

@interface HomeInviteOpenTVCell : UITableViewCell

+ (instancetype)setupHomeInviteOpenTVCell:(UITableView *)tableView;

@property (strong, nonatomic) OpenHistoryEntity *openHistoryEntity;

@end
