//
//  HomeInviteOpenTVCell.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteOpenTVCell.h"
#import "AYTimeSetting.h"

@interface HomeInviteOpenTVCell ()

@property (strong, nonatomic) UILabel *codeLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UILabel *useTimeLabel;

@property (strong, nonatomic) UILabel *isUseLabel;

@end

@implementation HomeInviteOpenTVCell

+ (instancetype)setupHomeInviteOpenTVCell:(UITableView *)tableView
{
    static NSString *ID = @"HomeInviteOpenTVCell";
    
    HomeInviteOpenTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[HomeInviteOpenTVCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
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
    UILabel *codeLabel = [UILabel new];
    codeLabel.text = @"0000";
    codeLabel.font = [UIFont systemFontOfSize:40];
    codeLabel.textColor = TextBlueColor;
    [self.contentView addSubview:codeLabel];
    self.codeLabel = codeLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.text = @"2017-03-07 11:20:00";
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = TextDeepGaryColor;
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *useTimeLabel = [UILabel new];
    useTimeLabel.text = @"今天 仅一次";
    useTimeLabel.font = [UIFont systemFontOfSize:15];
    useTimeLabel.textColor = TextBlueColor;
    [self.contentView addSubview:useTimeLabel];
    self.useTimeLabel = useTimeLabel;
    
    UILabel *isUseLabel = [UILabel new];
    isUseLabel.text = @"未使用";
    isUseLabel.font = [UIFont systemFontOfSize:15];
    isUseLabel.textColor = TextDeepGaryColor;
    [self.contentView addSubview:isUseLabel];
    self.isUseLabel = isUseLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(16);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-8);
    }];
    
    [self.isUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(8);
    }];
    
    [self.useTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.isUseLabel.mas_centerY);
        make.right.equalTo(self.isUseLabel.mas_left).offset(-8);
    }];
    
}

- (void)setOpenHistoryEntity:(OpenHistoryEntity *)openHistoryEntity
{
    _openHistoryEntity = openHistoryEntity;
    
    NSDate *date1 = [self stringToDate:openHistoryEntity.validityEndTime withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDate *date2 = localeDate;
    
    NSComparisonResult result = [date1 compare:date2];
    
    if (openHistoryEntity.dataStatus.intValue == 0 || result == NSOrderedAscending) {
        
        self.codeLabel.textColor = TextShallowGaryColor;
        self.timeLabel.textColor = TextShallowGaryColor;
        self.isUseLabel.textColor = TextShallowGaryColor;
        self.useTimeLabel.textColor = TextShallowGaryColor;
        
        self.userInteractionEnabled = NO;
        self.isUseLabel.text = @"已失效";
        self.useTimeLabel.text = @" ";
        
    } else {
        
        self.codeLabel.textColor = TextBlueColor;
        self.timeLabel.textColor = TextDeepGaryColor;
        self.isUseLabel.textColor = TextDeepGaryColor;
        self.useTimeLabel.textColor = TextBlueColor;
        
        self.userInteractionEnabled = YES;
        
        self.useTimeLabel.hidden = NO;
        
        NSArray *inviteCodeType = @[@"今天 无限次", @"今天 仅一次", @"明天 无限次", @"明天 仅一次", @"高级模式"];
        
        if (openHistoryEntity.inviteCodeType.integerValue - 1 == 4 ||openHistoryEntity.inviteCodeType.integerValue - 1 == 1 || openHistoryEntity.inviteCodeType.integerValue - 1 == 3) {
            
            if (openHistoryEntity.useTimes.integerValue == 0) {
                
                self.isUseLabel.text = @"未使用";
                
                self.useTimeLabel.text = inviteCodeType[openHistoryEntity.inviteCodeType.intValue - 1];
                
            } else {
                
                self.isUseLabel.text = @"已使用";
                
                self.useTimeLabel.text = @" ";
                
            }
            
        } else {
            
            self.isUseLabel.text = @" ";
            
            if (openHistoryEntity.inviteCodeType==nil) {
                
                self.codeLabel.text = openHistoryEntity.inviteCode;

                self.timeLabel.text = @"";
                return;
            }
            
            self.useTimeLabel.text = inviteCodeType[openHistoryEntity.inviteCodeType.intValue - 1];
        }
        
    }
    
    self.codeLabel.text = openHistoryEntity.inviteCode;
    
    self.timeLabel.text = openHistoryEntity.validityEndTime;
}

//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
