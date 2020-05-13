//
//  ConfigDevGroupTBVCell.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObtainDevGroupEntity.h"
@interface ConfigDevGroupTBVCell : UITableViewCell

@property (strong, nonatomic) UILabel *groupTypeLabel;
@property (strong, nonatomic)UIImageView *checkImage;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)ObtainDevGroupEntity *obtainDevGroupEntity;
@property (strong, nonatomic) NSString *deviceNum;

+ (instancetype)setupConfigDevGroupTBVCell:(UITableView *)tableView;

@end
