//
//  HomeInviteCell.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteCell.h"
@interface HomeInviteCell()

@property (strong, nonatomic) UIView *startLine;

@property (strong, nonatomic) UIView *endLine;

@property (strong, nonatomic) UILabel *zhiLabel;


@end

@implementation HomeInviteCell

+ (instancetype)setupHomeInviteCell:(UITableView *)tableView
{
    static NSString *ID = @"HomeInviteCell";
    
    HomeInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[HomeInviteCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor= [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    self.zhiLabel = [UILabel new];
    self.zhiLabel.text = @"至";
    self.zhiLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.zhiLabel];
    
    self.startLine = [UIView new];
    self.startLine.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.startLine];
    
    self.endLine = [UIView new];
    self.endLine.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.endLine];
    
    self.startLable = [UILabel new];
    self.startLable.text = @"上午11:00";
    self.startLable.textColor = TextDeepGaryColor;
    self.startLable.textAlignment = NSTextAlignmentCenter;
    self.startLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.startLable];
    
    self.endLable = [UILabel new];
    self.endLable.text = @"下午11:00";
    self.endLable.textColor = TextDeepGaryColor;
    self.endLable.textAlignment = NSTextAlignmentCenter;
    self.endLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.endLable];

    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startButton addTarget:self action:@selector(startTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.startButton];
    
    self.endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.endButton addTarget:self action:@selector(endTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.endButton];
    
    self.startMask = [UIView new];
    self.startMask.hidden = YES;
    self.startMask.backgroundColor = RGBA(230, 230, 230, 0.6);
    [self.contentView addSubview:self.startMask];
    
    self.endMask = [UIView new];
    self.endMask.hidden = YES;
    self.endMask.backgroundColor = RGBA(230, 230, 230, 0.6);
    [self.contentView addSubview:self.endMask];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setImage:[UIImage imageNamed:@"Del_Time"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteButton];

}
-(void)startTouch:(id)sender{
    if ([_homeInviteCellDelegate respondsToSelector:@selector(homeInviteCell:selectRowAtLoc:)]) {
        [_homeInviteCellDelegate homeInviteCell:self selectRowAtLoc:1];
    }
   
}
-(void)endTouch:(id)sender{
    if ([_homeInviteCellDelegate respondsToSelector:@selector(homeInviteCell:selectRowAtLoc:)]) {
        [_homeInviteCellDelegate homeInviteCell:self selectRowAtLoc:2];
    }
}
-(void)deleteTouch:(id)sender{
    if ([_homeInviteCellDelegate respondsToSelector:@selector(homeInviteCell:selectRowAtLoc:)]) {
        [_homeInviteCellDelegate homeInviteCell:self selectRowAtLoc:0];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.zhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.startLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.zhiLabel.mas_bottom).offset(2);
        make.right.equalTo(self.zhiLabel.mas_left);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH/3-20);
    }];
    
    [self.endLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startLine.mas_centerY);
        make.left.equalTo(self.zhiLabel.mas_right);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH/3-20);
    }];
    
    [self.startLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.zhiLabel.mas_centerY);
        make.left.right.equalTo(self.startLine);
    }];
    
    [self.endLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.zhiLabel.mas_centerY);
        make.left.right.equalTo(self.endLine);
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.startLable);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.startMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.startLable);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.endLable);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.endMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.endLable);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.startButton.mas_left);
        make.centerY.equalTo(self.startLable.mas_centerY);
        make.height.width.mas_equalTo(32);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
