//
//  HomeMessageTVCell.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenRecordEntity.h"

@interface HomeMessageTVCell : UITableViewCell

+ (instancetype)setupHomeMessageTVCell:(UITableView *)tableView;

@property (strong, nonatomic) OpenRecordEntity *openRecordEntity;

@property (strong, nonatomic) NSArray *openDoorTypeLists;

@end
