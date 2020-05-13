//
//  AdvertTableViewCell.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyNnoticeListEntity.h"
@interface AdvertTableViewCell : UITableViewCell

@property (strong, nonatomic)PropertyNnoticeListEntity *propertyNnoticeListEntity;

+ (instancetype)setupAdvertTableViewCell:(UITableView *)tableView;
@end
