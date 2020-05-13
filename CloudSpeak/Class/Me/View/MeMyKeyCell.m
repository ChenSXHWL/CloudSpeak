//
//  MeMyKeyCell.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeMyKeyCell.h"

@interface MeMyKeyCell ()


@end

@implementation MeMyKeyCell

+ (instancetype)setupMeMyKeyCell:(UITableView *)tableView
{
    static NSString *ID = @"MeMyKeyCell";
    
    MeMyKeyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[MeMyKeyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
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
    UILabel *keyName = [UILabel new];
    keyName.text = @"华美小区";
    keyName.font = [UIFont systemFontOfSize:18];
    keyName.textColor = [UIColor blackColor];
    [self.contentView addSubview:keyName];
    self.keyName = keyName;
    
    UILabel *currentLabel = [UILabel new];
    currentLabel.text = @"常用钥匙";
    currentLabel.hidden = YES;
    currentLabel.textColor = TextDeepGaryColor;
    currentLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:currentLabel];
    self.currentLabel = currentLabel;
    
    UILabel *dueLabel = [UILabel new];
    dueLabel.text = @"华美小区";
    dueLabel.font = [UIFont systemFontOfSize:16];
    dueLabel.textColor = TextShallowGaryColor;
    [self.contentView addSubview:dueLabel];
    self.dueLabel = dueLabel;

 }

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.keyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-12);
    }];
    
    [self.dueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(12);
    }];
    
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
