//
//  HomeMessageTVCell.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeMessageTVCell.h"
#import "AYBrowseImage.h"

@interface HomeMessageTVCell ()

@property (strong, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) UIImageView *photoImageView;

@property (strong, nonatomic) UIView *singleView;

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UILabel *openLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation HomeMessageTVCell

+ (instancetype)setupHomeMessageTVCell:(UITableView *)tableView
{
    static NSString *ID = @"HomeMessageTVCell";
    
    HomeMessageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[HomeMessageTVCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
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
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = [UIImage imageNamed:@"message_successful"];
    [self.contentView addSubview:rightImageView];
    self.rightImageView = rightImageView;
    
    UIImageView *photoImageView = [UIImageView new];
    photoImageView.userInteractionEnabled = YES;
    photoImageView.image = [UIImage imageNamed:@"tabBar_icon_plan"];
    photoImageView.backgroundColor = TextShallowGaryColor;
    [self.contentView addSubview:photoImageView];
    self.photoImageView = photoImageView;
    
    UIView *singleView = [UIView new];
    singleView.backgroundColor = TextShallowGaryColor;
    [self.contentView addSubview:singleView];
    self.singleView = singleView;
    
    UIView *topView = [UIView new];
    topView.backgroundColor = TextShallowGaryColor;
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = TextShallowGaryColor;
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel *openLabel = [UILabel new];
    openLabel.textColor = TextMainBlackColor;
    openLabel.text = @"APP开门";
    [self.contentView addSubview:openLabel];
    self.openLabel = openLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.textColor = TextDeepGaryColor;
    timeLabel.text = @"11:45 开启单元门";
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.width.equalTo(self.photoImageView.mas_height).multipliedBy(1.5);
    }];
    
    [self.singleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImageView.mas_right);
        make.right.equalTo(self.photoImageView.mas_left);
        make.centerY.equalTo(self.rightImageView.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.rightImageView.mas_top);
        make.centerX.equalTo(self.rightImageView.mas_centerX);
        make.width.mas_equalTo(1);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightImageView.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(1);
        make.centerX.equalTo(self.rightImageView.mas_centerX);
        make.width.mas_equalTo(1);
    }];
    
    [self.openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImageView.mas_right).offset(16);
        make.bottom.equalTo(self.singleView.mas_bottom).offset(-8);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImageView.mas_right).offset(16);
        make.top.equalTo(self.singleView.mas_bottom).offset(8);
    }];
}

- (void)setOpenRecordEntity:(OpenRecordEntity *)openRecordEntity
{
    _openRecordEntity = openRecordEntity;
    
    self.timeLabel.text = openRecordEntity.openTime;
    
    [self.photoImageView imageShwoActivityIndicatorWithUrlString:[NSString stringWithFormat:@"%@%@?imageView/1/w/200/h/100", openRecordEntity.domain, openRecordEntity.imgUrl] placeHolder:nil];
    
    if ([openRecordEntity.openStatus isEqualToString:@"1"]) {
        
        self.rightImageView.image = [UIImage imageNamed:@"message_successful"];
        
    } else {
        
        
        self.rightImageView.image = [UIImage imageNamed:@"message_failure"];
        
    }
    
    [self.photoImageView whenTapped:^{
                
        [AYBrowseImage browseNetworkImageWithImages:[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%@%@", openRecordEntity.domain, openRecordEntity.imgUrl]]] currentIndex:1];

    }];
    
}

- (void)setOpenDoorTypeLists:(NSArray *)openDoorTypeLists
{
    _openDoorTypeLists = openDoorTypeLists;
    
    for(int a = 0;a<openDoorTypeLists.count;a++){
        NSString *b = openDoorTypeLists[a][@"storeValue"];
        if (b.intValue==self.openRecordEntity.openType.intValue) {
            self.openLabel.text = openDoorTypeLists[a][@"displayValue"];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
