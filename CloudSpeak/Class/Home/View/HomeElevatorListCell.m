//
//  HomeElevatorListCell.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeElevatorListCell.h"

@interface HomeElevatorListCell ()



@end

@implementation HomeElevatorListCell

+ (instancetype)setupHomeElevatorListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HomeElevatorListCell";
    
    [collectionView registerClass:[HomeElevatorListCell class] forCellWithReuseIdentifier:identifier];
    
    HomeElevatorListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
    }
    
    return self;
    
}

- (void)setupUI
{
    UIImageView *guardImageView = [UIImageView new];
    guardImageView.contentMode = UIViewContentModeScaleAspectFit;
    guardImageView.image = [UIImage imageNamed:@"monitor_door"];
    [self.contentView addSubview:guardImageView];
    self.guardImageView = guardImageView;
    
    UILabel *guardlabel = [UILabel new];
    guardlabel.textColor = TextMainBlackColor;
    guardlabel.font = [UIFont systemFontOfSize:15];
    guardlabel.textAlignment = NSTextAlignmentCenter;
    guardlabel.text = @"楼栋01-单元A";
    [self.contentView addSubview:guardlabel];
    self.guardlabel = guardlabel;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.guardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
    }];
    
    [self.guardlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.guardImageView.mas_bottom);
    }];
}

@end
