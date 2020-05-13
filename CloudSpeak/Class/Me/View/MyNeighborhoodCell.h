//
//  MyNeighborhoodCell.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNeighborhoodCell : UITableViewCell

@property (strong, nonatomic) UILabel *neighborhoodName;

@property (strong, nonatomic) UILabel *residentsA;

@property (strong, nonatomic) UILabel *residentsB;

@property (strong, nonatomic) UILabel *residentsMarkA;

@property (strong, nonatomic) UILabel *residentsMarkB;

@property (strong, nonatomic) UILabel *validityA;

@property (strong, nonatomic) UILabel *validityB;

@property (strong, nonatomic) UILabel *stateMarkA;

@property (strong, nonatomic) UILabel *stateMarkB;

@property (strong, nonatomic) UILabel *currentLabel;

@property (strong, nonatomic) NSArray *dataArray;

+ (instancetype)setupMyNeighborhoodCell:(UITableView *)tableView;
@end
