//
//  ComplaintsPhoneTBViewCell.h
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintsPhoneTBViewCell : UITableViewCell


@property (strong, nonatomic)UILabel *phoneName;
@property (strong, nonatomic)UIButton *phone;


+ (instancetype)setupComplaintsPhoneTBViewCell:(UITableView *)tableView;
@end
