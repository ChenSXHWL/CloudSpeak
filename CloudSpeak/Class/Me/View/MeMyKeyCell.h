//
//  MeMyKeyCell.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeMyKeyCell : UITableViewCell

@property (strong, nonatomic) UILabel *keyName;

@property (strong, nonatomic) UILabel *dueLabel;

@property (strong, nonatomic) UILabel *currentLabel;

+ (instancetype)setupMeMyKeyCell:(UITableView *)tableView;
@end
