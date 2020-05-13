//
//  ConfigDevGroupTBVCell.m
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ConfigDevGroupTBVCell.h"

@implementation ConfigDevGroupTBVCell


+ (instancetype)setupConfigDevGroupTBVCell:(UITableView *)tableView
{
    static NSString *ID = @"ConfigDevGroupTBVCell";
    
    ConfigDevGroupTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[ConfigDevGroupTBVCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
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
    UILabel *groupTypeLabel = [UILabel new];
    groupTypeLabel.text = @"单元权限组";
    groupTypeLabel.layer.cornerRadius = 6;
    groupTypeLabel.layer.masksToBounds = YES;
    groupTypeLabel.backgroundColor = TextBlueColor;
    groupTypeLabel.textAlignment = NSTextAlignmentCenter;
    groupTypeLabel.textColor = [UIColor whiteColor];
    [self addSubview:groupTypeLabel];
    self.groupTypeLabel = groupTypeLabel;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"权限组11";
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *checkImage = [UIImageView new];
    checkImage.image = [UIImage imageNamed:@"check"];
    [self addSubview:checkImage];
    checkImage.hidden = YES;
    self.checkImage = checkImage;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.groupTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.groupTypeLabel);
        make.left.equalTo(self.groupTypeLabel.mas_right).offset(18);
    }];
    
    [self.checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self);
        make.height.width.mas_equalTo(30);
    }];
}
-(void)setDeviceNum:(NSString *)deviceNum{
    _deviceNum = deviceNum;
}
-(void)setObtainDevGroupEntity:(ObtainDevGroupEntity *)obtainDevGroupEntity{
    _obtainDevGroupEntity = obtainDevGroupEntity;
    
    self.groupTypeLabel.text = obtainDevGroupEntity.groupTypeName;
    self.titleLabel.text = obtainDevGroupEntity.deviceGroupName;
    self.checkImage.hidden = YES;

    if (obtainDevGroupEntity.deviceNums.length) {
       NSArray *array = [obtainDevGroupEntity.deviceNums componentsSeparatedByString:@","];
        for (int i = 0; i<array.count; i++) {
            NSString *deviceNum = array[i];
            if ([deviceNum isEqualToString:self.deviceNum] ) {
                self.checkImage.hidden = NO;
            }
        }
    }
    
    
}
@end
