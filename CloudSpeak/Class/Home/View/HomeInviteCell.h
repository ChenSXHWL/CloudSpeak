//
//  HomeInviteCell.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeInviteCell;

@protocol HomeInviteCellDelegate <NSObject>

- (void)homeInviteCell:(HomeInviteCell *)homeInviteCell selectRowAtLoc:(int)loc;

@end
@interface HomeInviteCell : UITableViewCell

@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) UIView *startMask;

@property (strong, nonatomic) UIButton *endButton;

@property (strong, nonatomic) UIView *endMask;

@property (strong, nonatomic) UILabel *startLable;

@property (strong, nonatomic) UILabel *endLable;

@property (weak, nonatomic) id <HomeInviteCellDelegate> homeInviteCellDelegate;

+ (instancetype)setupHomeInviteCell:(UITableView *)tableView;

@end
