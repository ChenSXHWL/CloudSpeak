//
//  HomeGuardCVCell.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeGuardCVCell.h"
#import "HomeFunctionButton.h"

@interface HomeGuardCVCell ()

@property (strong, nonatomic) UIImageView *guardImageView;

@property (strong, nonatomic) UILabel *guardlabel;

@end

@implementation HomeGuardCVCell

+ (instancetype)setupHomeGuardCVCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HomeGuardCVCell";
    
    [collectionView registerClass:[HomeGuardCVCell class] forCellWithReuseIdentifier:identifier];
    
    HomeGuardCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
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
    guardlabel.text = @"单元门";
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

- (void)setGetMyKeyEntity:(GetMyKeyEntity *)getMyKeyEntity
{
    _getMyKeyEntity = getMyKeyEntity;
    
    self.guardlabel.text = getMyKeyEntity.deviceName;
    
    if ([getMyKeyEntity.onlineStatus isEqualToString:@"0"]) {
        
        self.guardlabel.textColor = TextShallowGaryColor;
        
        self.guardImageView.image = [UIImage imageNamed:@"monitor_door_in"];
        
    } else {
        
        self.guardlabel.textColor = TextMainBlackColor;
        
        self.guardImageView.image = [UIImage imageNamed:@"monitor_door"];
        
    }
    
    
}

@end
