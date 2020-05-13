//
//  MyNeighborhoodCell.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MyNeighborhoodCell.h"

@interface MyNeighborhoodCell ()


@end

@implementation MyNeighborhoodCell

+ (instancetype)setupMyNeighborhoodCell:(UITableView *)tableView
{
    static NSString *ID = @"MyNeighborhoodCell";
    
    MyNeighborhoodCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[MyNeighborhoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
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
    UILabel *neighborhoodName = [UILabel new];
    neighborhoodName.text = @"华美小区";
    neighborhoodName.font = [UIFont systemFontOfSize:18];
    neighborhoodName.textColor = [UIColor blackColor];
    [self.contentView addSubview:neighborhoodName];
    self.neighborhoodName = neighborhoodName;
    
    UILabel *residentsA = [UILabel new];
//    residentsA.text = @"34栋01单元0401";
    residentsA.font = [UIFont systemFontOfSize:14];
    residentsA.textColor = TextDeepGaryColor;
    [self.contentView addSubview:residentsA];
    self.residentsA = residentsA;

    UILabel *residentsB = [UILabel new];
//    residentsB.text = @"34栋01单元0402";
    residentsB.font = [UIFont systemFontOfSize:14];
    residentsB.textColor = TextDeepGaryColor;
    [self.contentView addSubview:residentsB];
    self.residentsB = residentsB;

    UILabel *residentsMarkA = [UILabel new];
//    residentsMarkA.text = @"[租客]";
    residentsMarkA.font = [UIFont systemFontOfSize:14];
    residentsMarkA.textColor = TextBlueColor;
    [self.contentView addSubview:residentsMarkA];
    self.residentsMarkA = residentsMarkA;

    UILabel *residentsMarkB = [UILabel new];
//    residentsMarkB.text = @"[租客]";
    residentsMarkB.font = [UIFont systemFontOfSize:14];
    residentsMarkB.textColor = TextBlueColor;
    [self.contentView addSubview:residentsMarkB];
    self.residentsMarkB = residentsMarkB;

    UILabel *validityA = [UILabel new];
    validityA.font = [UIFont systemFontOfSize:14];
    validityA.textColor = TextBlueColor;
    [self.contentView addSubview:validityA];
    self.validityA = validityA;
    
    UILabel *validityB = [UILabel new];
    validityB.font = [UIFont systemFontOfSize:14];
    validityB.textColor = TextBlueColor;
    [self.contentView addSubview:validityB];
    self.validityB = validityB;
    
    UILabel *stateMarkA = [UILabel new];
    stateMarkA.font = [UIFont systemFontOfSize:14];
    stateMarkA.textColor = TextBlueColor;
    [self.contentView addSubview:stateMarkA];
    self.stateMarkA = stateMarkA;
    
    UILabel *stateMarkB = [UILabel new];
    stateMarkB.font = [UIFont systemFontOfSize:14];
    stateMarkB.textColor = TextBlueColor;
    [self.contentView addSubview:stateMarkB];
    self.stateMarkB = stateMarkB;

    UILabel *currentLabel = [UILabel new];
    currentLabel.text = @"常用小区";
    currentLabel.hidden = YES;
    currentLabel.textColor = TextDeepGaryColor;
    currentLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:currentLabel];
    
    self.currentLabel = currentLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.neighborhoodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.contentView.mas_top).offset(8);
    }];
    
    [self.residentsA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.neighborhoodName);
        make.top.equalTo(self.neighborhoodName.mas_bottom).offset(8);
    }];
    
    [self.residentsMarkA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.residentsA.mas_right);
        make.centerY.equalTo(self.residentsA.mas_centerY);
    }];
    
    [self.validityA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.residentsMarkA.mas_right);
        make.centerY.equalTo(self.residentsA.mas_centerY);
    }];
    
    [self.stateMarkA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.validityA.mas_right);
        make.centerY.equalTo(self.residentsA.mas_centerY);
    }];
    
    [self.residentsB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.neighborhoodName);
        make.top.equalTo(self.residentsA.mas_bottom).offset(6);
    }];
    
    [self.residentsMarkB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.residentsB.mas_right);
        make.centerY.equalTo(self.residentsB.mas_centerY);
    }];
    
    [self.validityB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.residentsMarkB.mas_right);
        make.centerY.equalTo(self.residentsB.mas_centerY);
    }];
    
    [self.stateMarkB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.validityB.mas_right);
        make.centerY.equalTo(self.residentsB.mas_centerY);
    }];
    
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    HouseList *model = dataArray[0];
    _residentsA.text = [NSString stringWithFormat:@"%@%@%@",model.buildingName,model.unitName,model.roomNum];
    _residentsMarkA.text = [NSString stringWithFormat:@"[%@]",model.householdType];
    if (model.householdStatus.intValue==0) {
        _validityA.text = @"[注销]";
    }else{
        _validityA.text = @"[启用]";
    }
    
//    _stateMarkA.text = model.dueDate;
    
    if (dataArray.count>1) {
        HouseList *model = dataArray[1];
        _residentsB.text = [NSString stringWithFormat:@"%@%@%@",model.buildingName,model.unitName,model.roomNum];
        _residentsMarkB.text = [NSString stringWithFormat:@"[%@]",model.householdType];
        if (model.householdStatus.intValue==0) {
            _validityB.text = @"[注销]";
        }else{
            _validityB.text = @"[启用]";
        }
//        _stateMarkB.text = model.dueDate;
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
