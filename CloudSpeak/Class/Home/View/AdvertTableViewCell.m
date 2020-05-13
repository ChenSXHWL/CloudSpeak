//
//  AdvertTableViewCell.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AdvertTableViewCell.h"

@interface AdvertTableViewCell ()

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *typeLabel;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *readNumberLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIView *lineA;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIView *lineB;

@property (strong, nonatomic) UILabel *isUseLabel;

@property (strong, nonatomic) UIImageView *isUseImage;

@end

@implementation AdvertTableViewCell

+ (instancetype)setupAdvertTableViewCell:(UITableView *)tableView
{
    static NSString *ID = @"HomeInviteOpenTVCell";
    
    AdvertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[AdvertTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor= [UIColor clearColor];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 4;
    backView.layer.masksToBounds = YES;
    //阴影的颜色
    backView.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影的透明度
    backView.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    backView.layer.shadowRadius = 4.f;
    //阴影偏移量
    backView.layer.shadowOffset = CGSizeMake(4,4);
    [self.contentView addSubview:backView];
    self.backView = backView;
    
    UILabel *typeLabel = [UILabel new];
    typeLabel.text = @"紧急";
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.backgroundColor = [UIColor redColor];
    typeLabel.layer.cornerRadius = 10;
    typeLabel.layer.masksToBounds = YES;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:typeLabel];
    self.typeLabel = typeLabel;
    self.typeLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:88/255.0 blue:107/255.0 alpha:1];

    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"春江邺城紧急停电通知";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    [self.backView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *readNumberLabel = [UILabel new];
    readNumberLabel.text = @"阅读量:60";
    readNumberLabel.font = [UIFont systemFontOfSize:15];
    readNumberLabel.textColor = TextDeepGaryColor;
    [self.backView addSubview:readNumberLabel];
    self.readNumberLabel = readNumberLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.text = @"2017-03-07 11:20:00";
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = TextDeepGaryColor;
    [self.backView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [self.backView addSubview:lineA];
    self.lineA = lineA;
    
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"今天 仅一次aaa啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊嗷嗷嗷啊啊啊啊啊啊啊啊啊啊啊啊";
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 2;
//    contentLabel.textAlignment =
    [self.backView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIView *lineB = [UIView new];
    lineB.backgroundColor = LineEdgeGaryColor;
    [self.backView addSubview:lineB];
    self.lineB = lineB;

    UILabel *isUseLabel = [UILabel new];
    isUseLabel.text = @"点击查看详情";
    isUseLabel.font = [UIFont systemFontOfSize:15];
    isUseLabel.textColor = TextDeepGaryColor;
    [self.backView addSubview:isUseLabel];
    self.isUseLabel = isUseLabel;
    
    UIImageView *isUseImage = [UIImageView new];
    isUseImage.image = [UIImage imageNamed:@"indicate"];
    [self.backView addSubview:isUseImage];
    self.isUseImage = isUseImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.height.mas_equalTo(182);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(16);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(44);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel.mas_centerY);
        make.left.equalTo(self.typeLabel.mas_right).offset(16);
    }];
    
    [self.readNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_left);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.readNumberLabel.mas_right).offset(16);
        make.centerY.equalTo(self.readNumberLabel.mas_centerY);
    }];
    
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.readNumberLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineA.mas_bottom).offset(8);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
    }];
    
    [self.isUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.top.equalTo(self.lineB.mas_bottom).offset(16);
    }];
    
    [self.isUseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.isUseLabel.mas_centerY);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.width.height.mas_equalTo(24);
    }];
    

}
-(void)setPropertyNnoticeListEntity:(PropertyNnoticeListEntity *)propertyNnoticeListEntity{
    
    _propertyNnoticeListEntity = propertyNnoticeListEntity;
    
    self.typeLabel.text = propertyNnoticeListEntity.noticeType;

    if ([propertyNnoticeListEntity.noticeType isEqualToString:@"紧急"]) {
        self.typeLabel.backgroundColor =RGB(253, 88, 107);
    }else if ([propertyNnoticeListEntity.noticeType isEqualToString:@"新闻"]) {
        self.typeLabel.backgroundColor =RGB(106, 140, 180);
    }else if ([propertyNnoticeListEntity.noticeType isEqualToString:@"提示"]) {
        self.typeLabel.backgroundColor =RGB(255, 182, 95);
    }else if ([propertyNnoticeListEntity.noticeType isEqualToString:@"活动"]) {
        self.typeLabel.backgroundColor =RGB(0, 188, 156);
    } else{
        self.typeLabel.backgroundColor =RGB(0, 186, 252);
    }
    
//    switch (propertyNnoticeListEntity.noticeType.intValue) {
//        case 1:
//            self.typeLabel.text = propertyNnoticeListEntity.noticeType;
//            self.typeLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:88/255.0 blue:107/255.0 alpha:1];
//            break;
//        case 2:
//            self.typeLabel.text = @"通知";
//            self.typeLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:186/255.0 blue:252/255.0 alpha:1];
//            break;
//        case 3:
//            self.typeLabel.text = @"活动";
//            self.typeLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:186/255.0 blue:252/255.0 alpha:1];
//            break;
//        case 4:
//            self.typeLabel.text = @"提示";
//            self.typeLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:186/255.0 blue:252/255.0 alpha:1];
//            break;
//        case 5:
//            self.typeLabel.text = @"新闻";
//            self.typeLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:186/255.0 blue:252/255.0 alpha:1];
//            break;
//            
//            
//        default:
//            break;
//    }
    
    
    self.titleLabel.text = propertyNnoticeListEntity.noticeTitle;
    self.readNumberLabel.text = [NSString stringWithFormat:@"阅读量:%@",propertyNnoticeListEntity.readNum];
    self.timeLabel.text = propertyNnoticeListEntity.createTime;
    self.contentLabel.text = propertyNnoticeListEntity.noticeContent;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
