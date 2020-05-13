//
//  ComplaintsPhoneTBViewCell.m
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsPhoneTBViewCell.h"
@interface ComplaintsPhoneTBViewCell ()


@end
@implementation ComplaintsPhoneTBViewCell
+ (instancetype)setupComplaintsPhoneTBViewCell:(UITableView *)tableView
{
    static NSString *ID = @"ComplaintsPhoneTBViewCell";
    
    ComplaintsPhoneTBViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[ComplaintsPhoneTBViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self buildUI];

    }
    return self;
}
-(void)buildUI{
    UILabel *phoneName = [UILabel new];
    [self.contentView addSubview:phoneName];
    self.phoneName = phoneName;
    
    
    UIButton *phone = [UIButton buttonWithType:UIButtonTypeCustom];
    [phone setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [phone addTarget:self action:@selector(phoneTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:phone];
    self.phone = phone;
}
-(void)phoneTouch:(UIButton *)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",sender.titleLabel.text];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.phoneName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(120);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
