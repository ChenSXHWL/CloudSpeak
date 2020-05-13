//
//  ComplaintsTBViewCell.h
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryComplaintsEntity.h"
@interface ComplaintsTBViewCell : UITableViewCell
@property (strong, nonatomic)NSArray *complainStatusList;
@property (strong, nonatomic)NSArray *complainTypeList;

@property (strong, nonatomic)HistoryComplaintsEntity *historyComplaintsEntity;
+ (instancetype)setupComplaintsTBViewCell:(UITableView *)tableView;

@end
