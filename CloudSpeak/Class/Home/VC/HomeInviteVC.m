//
//  HomeInviteVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteVC.h"
#import "HomeInviteOpenVC.h"
#import "HomeInviteShowInfoView.h"
#import "GetDeviceGroupVM.h"
#import "InviteCodeVM.h"
#import "FSCalendar.h"
#import "HomeInviteCell.h"
#import "UserInfoVM.h"
#import "HouseList.h"
@interface HomeInviteVC ()<FSCalendarDataSource,FSCalendarDelegate,UITableViewDelegate,UITableViewDataSource,HomeInviteCellDelegate>

@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UIButton *tomorrowButton;
@property (weak, nonatomic) IBOutlet UIButton *oneTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *moreTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet UIView *locView;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIButton *modelButton;

@property (strong, nonatomic) HomeInviteShowInfoView *homeInviteShowInfoView;

@property (strong, nonatomic) GetDeviceGroupVM *getDeviceGroupVM;

@property (strong, nonatomic) InviteCodeVM *inviteCodeVM;

@property (assign, nonatomic) BOOL isPush;
@property (strong, nonatomic) UIView *calendarBackView;
@property (nonatomic, strong) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UILabel *doorLockLable;

@property (strong, nonatomic) UIView *dateView;
@property (assign, nonatomic) int statsRow;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) BOOL isStart;//YES 开始 NO结束

@property (strong, nonatomic) UIDatePicker *oneDatePicker;

@property (strong, nonatomic) UIView *timeMask;
@property (strong, nonatomic) UIButton *noAllDay;
@property (assign, nonatomic) BOOL isAllDay;

@property (strong, nonatomic) UserInfoVM *userInfoVM;
@property (strong, nonatomic) UserInfoEntity *userInfoEntity;
@property (strong, nonatomic) NSString *roomString;

@property (strong, nonatomic) RefreshDevicesRequest *refreshDevicesRequest;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HomeInviteVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.isPush = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    
    if (self.isPush) return;
    
    [self.homeInviteShowInfoView removeFromSuperview];
    
    [self popToVC];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupVM];
    
    [self setupRAC];
    
}

- (void)setupUI
{
    self.title = @"访客邀请";
    
    self.dataArray = [NSMutableArray new];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记录" style:UIBarButtonItemStyleDone target:self action:@selector(inviteRecord)];
    
    HomeInviteShowInfoView *homeInviteShowInfoView = [HomeInviteShowInfoView new];
    [[UIApplication sharedApplication].keyWindow addSubview:homeInviteShowInfoView];
    self.homeInviteShowInfoView = homeInviteShowInfoView;

    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kTopHeight+12);
        make.left.equalTo(self.view.mas_left).offset(16);
    }];
    
    //高级模式UI---
    self.calendarBackView = [UIView new];
    self.calendarBackView.backgroundColor = [UIColor whiteColor];
    self.calendarBackView.hidden = YES;
    [self.view addSubview:self.calendarBackView];
    [self.calendarBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.modelButton.mas_bottom).offset(8);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    UILabel *calendTitle = [UILabel new];
    calendTitle.text = @"选择日期（支持最长15天）";
    calendTitle.font = [UIFont systemFontOfSize:14];
    [self.calendarBackView addSubview:calendTitle];
    [calendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.calendarBackView.mas_centerX);
            make.top.equalTo(self.calendarBackView.mas_top);
    }];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _calendar = [self calendar];
    [self.calendarBackView addSubview:_calendar];

    UILabel *timerTitle = [UILabel new];
    timerTitle.text = @"选择时间段（支持多时间段）";
    timerTitle.font = [UIFont systemFontOfSize:14];
    [self.calendarBackView addSubview:timerTitle];
    [timerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.calendarBackView.mas_centerX);
        make.top.equalTo(_calendar.mas_bottom).offset(6);
    }];
    
    UIButton *addTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTime setImage:[UIImage imageNamed:@"Add_Time"] forState:UIControlStateNormal];
    [addTime addTarget:self action:@selector(addTimeTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarBackView addSubview:addTime];
    [addTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.calendarBackView.mas_right).offset(-16);
        make.top.equalTo(self.calendar.mas_bottom).offset(0);
        make.height.width.mas_equalTo(32);
    }];
    if (SCREEN_HEIGHT>700) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,248+18, SCREEN_WIDTH, 72+100) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,248+18, SCREEN_WIDTH, 72) style:UITableViewStylePlain];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.calendarBackView addSubview:self.tableView];
    
    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [self.calendarBackView addSubview:lineA];
    [lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH-32);
        make.centerX.equalTo(self.calendarBackView.mas_centerX);
    }];
    
    UIView *chooseView = [UIView new];
    [self.calendarBackView addSubview:chooseView];
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineA.mas_bottom);
        make.left.right.equalTo(self.calendarBackView);
        make.height.mas_equalTo(44);
    }];
    @weakify(self);
    [chooseView whenTapped:^{
        @strongify(self);
        
        NSMutableArray *array = [NSMutableArray array];
        BOOL publi = YES;
        for (GetDeviceGroupEntity *entity in self.getDeviceGroupVM.getDeviceGroups) {
            if (entity.deviceGroupType.intValue == 2 && publi==YES) {
                [array addObject:@"公共钥匙"];
                publi = NO;
            }else{
                [array addObject:entity.deviceGroupName];
            }
        }

        [MMPickerView showPickerViewInView:self.view withStrings:@[array] withOptions:nil completion:^(NSArray *selectedString) {
            @strongify(self);
            NSNumber *select = selectedString[0];
            GetDeviceGroupEntity *entity = self.getDeviceGroupVM.getDeviceGroups[select.intValue];
            if (entity.deviceGroupType.intValue == 2) {
                self.doorLockLable.text = @"公共钥匙";
                self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId = @(0);
            }else{
                self.doorLockLable.text = entity.deviceGroupName;//选择完 门卡发送弹窗赋值
                
                self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId = @(entity.deviceGroupId.intValue);
            }
        }];
    }];
    
    
    UILabel *chooseLable = [UILabel new];
    chooseLable.text = @"选择门锁";
    chooseLable.textColor = TextShallowGaryColor;
    [chooseView addSubview:chooseLable];
    [chooseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseView.mas_centerY);
        make.left.equalTo(chooseView.mas_left).offset(16);
    }];
   
    
    UIImageView *doorImage = [UIImageView new];
    doorImage.image = [UIImage imageNamed:@"next"];
    [self.calendarBackView addSubview:doorImage];
    [doorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseView.mas_centerY);
        make.right.equalTo(chooseView.mas_right).offset(-16);
        make.width.height.mas_equalTo(22);
    }];
    
    self.doorLockLable = [UILabel new];
//    self.doorLockLable.text = @"公共钥匙";
//    self.doorLockLable.textColor = TextShallowGaryColor;
    [chooseView addSubview:self.doorLockLable];
    [self.doorLockLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseView.mas_centerY);
        make.right.equalTo(doorImage.mas_left).offset(-16);
    }];
    
    UIButton *confirmTime = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmTime.backgroundColor = TextBlueColor;
    [confirmTime setTitle:@"确认申请" forState:UIControlStateNormal];
    [confirmTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmTime addTarget:self action:@selector(confirmTimeTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.calendarBackView addSubview:confirmTime];
    [confirmTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.calendarBackView.mas_centerX);
        make.bottom.equalTo(self.calendarBackView.mas_bottom).offset(-24);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(SCREEN_WIDTH-32);
    }];

    self.dateView = [UIView new];
    self.dateView.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:0.5];
    self.dateView.hidden  = YES;
    [self.view addSubview:self.dateView];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    

    self.oneDatePicker = [[UIDatePicker alloc] init];
    self.oneDatePicker.frame = CGRectMake(0, (SCREEN_HEIGHT-300-64)/2, SCREEN_WIDTH, 300); // 设置显示的位置和大小
    self.oneDatePicker.backgroundColor = [UIColor whiteColor];
    self.oneDatePicker.date = [NSDate date]; // 设置初始时间
    // [oneDatePicker setDate:[NSDate dateWithTimeIntervalSinceNow:48 * 20 * 18] animated:YES]; // 设置时间，有动画效果
    self.oneDatePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    self.oneDatePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
    self.oneDatePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
    self.oneDatePicker.datePickerMode = UIDatePickerModeTime; // 设置样式
    self.oneDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    self.oneDatePicker.minuteInterval = 15;

    [self.oneDatePicker setCalendar:[NSCalendar currentCalendar]];
//    [self.oneDatePicker setLocale:[NSLocale currentLocale]];
//    [self.oneDatePicker setLocale:[NSLocale systemLocale]];

    // 以下为全部样式
    // typedef NS_ENUM(NSInteger, UIDatePickerMode) {
    //    UIDatePickerModeTime,           // 只显示时间
    //    UIDatePickerModeDate,           // 只显示日期
    //    UIDatePickerModeDateAndTime,    // 显示日期和时间
    //    UIDatePickerModeCountDownTimer  // 只显示小时和分钟 倒计时定时器
    // };
//    [self.oneDatePicker setCalendar:[NSCalendar currentCalendar]];//24小时制

    [self.oneDatePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    
    [self.dateView addSubview:self.oneDatePicker]; // 添加到View上
  
    UIButton *allDay = [UIButton buttonWithType:UIButtonTypeCustom];
    [allDay setTitle:@"全天" forState:UIControlStateNormal];
    allDay.titleLabel.font = [UIFont systemFontOfSize:24];
    [allDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allDay addTarget:self action:@selector(allDayTcouh) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:allDay];
    [allDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.oneDatePicker.mas_centerY).offset(-80);
        make.centerX.equalTo(self.oneDatePicker.mas_centerX).offset(-60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    
    self.noAllDay = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.noAllDay setTitle:@" " forState:UIControlStateNormal];
    self.noAllDay.titleLabel.font = [UIFont systemFontOfSize:24];
    self.noAllDay.hidden = YES;
    [self.noAllDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.noAllDay addTarget:self action:@selector(noAllDayTcouh) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:self.noAllDay];
    [self.noAllDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allDay.mas_bottom).offset(0);
        make.centerX.equalTo(self.oneDatePicker.mas_centerX).offset(-60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(80);
    }];

    
    self.timeMask = [UIView new];
    self.timeMask.backgroundColor = BXAlphaColor(230, 230, 230, 0.5);
    self.timeMask.hidden = YES;
    [self.dateView addSubview:self.timeMask];
    [self.timeMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneDatePicker.mas_centerX).offset(-12);
        make.top.bottom.right.equalTo(self.oneDatePicker);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setBackgroundColor:[UIColor whiteColor]];
    [confirmButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateView.mas_right);
        make.top.equalTo(self.oneDatePicker.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor blackColor]];
    [cancelButton addTarget:self action:@selector(cancelTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateView.mas_left);
        make.top.equalTo(self.oneDatePicker.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.height.mas_equalTo(44);
    }];
    
    UIView *lineB = [UIView new];
    lineB.backgroundColor = LineEdgeGaryColor;
    [self.dateView addSubview:lineB];
    [lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneDatePicker.mas_bottom);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH-32);
    }];
    
    UIView *lineC = [UIView new];
    lineC.backgroundColor = LineEdgeGaryColor;
    [self.dateView addSubview:lineC];
    [lineC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneDatePicker.mas_bottom);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(44);
    }];

}
-(void)allDayTcouh{
    self.timeMask.hidden =  NO;
    self.noAllDay.hidden = NO;

}
-(void)noAllDayTcouh{
    self.timeMask.hidden =  YES;
    self.noAllDay.hidden = YES;
}
- (FSCalendar *)calendar {
    
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 18, SCREEN_WIDTH, 222)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        //设置翻页方式为水平
        _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
        //设置是否用户多选
        _calendar.allowsMultipleSelection = YES;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        //这个属性控制"上个月"和"下个月"标签在静止时刻的透明度          _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.backgroundColor = [UIColor whiteColor];
        //设置周字体颜色
        _calendar.appearance.weekdayTextColor = [UIColor blackColor];
        //设置头字体颜色
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        
        //创建点击跳转显示上一月和下一月button
        UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        previousButton.frame = CGRectMake(_calendarBackView.centerX - 50 - 6.5, 10, 24, 24);
        previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousButton setImage:[UIImage imageNamed:@"Up_Time"] forState:UIControlStateNormal];
        [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_calendar addSubview:previousButton];
        [previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_calendar.mas_centerX).offset(-SCREEN_WIDTH/4);
            make.centerY.equalTo(_calendar.calendarHeaderView.mas_centerY);
            make.width.height.mas_equalTo(32);
        }];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
 //       nextButton.frame = CGRectMake(_calendarBackView.centerX + 50, 10, 24, 24);
        nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextButton setImage:[UIImage imageNamed:@"Down_Time"] forState:UIControlStateNormal];
//        nextButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_calendar addSubview:nextButton];
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_calendar.mas_centerX).offset(SCREEN_WIDTH/4);
            make.centerY.equalTo(_calendar.calendarHeaderView.mas_centerY);
            make.width.height.mas_equalTo(32);
        }];
        //设置当天的字体颜色
//        _calendar.todayColor = COLOR_BLUE;
    }
    return _calendar;
}
- (void)nextClicked:(id)sender
{
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (void)previousClicked:(id)sender
{
    NSDate *prevMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.calendar.currentPage options:0];
    [self.calendar setCurrentPage:prevMonth animated:YES];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    //...
    if (calendar.selectedDates.count == 14) {
    }
    
}
//取消选中的日期进行相关操作
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date {
    //...
}
- (void)setupConstraint
{
    [self.homeInviteShowInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}

- (void)setupVM
{
    self.getDeviceGroupVM = [GetDeviceGroupVM SceneModel];
    
    self.inviteCodeVM = [InviteCodeVM SceneModel];
    
    self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId = @(0);//默认高级模式的公共权限

//    self.userInfoVM = [UserInfoVM SceneModel];
//    
//    self.userInfoVM.userInfoRequest.requestNeedActive = YES;

    self.refreshDevicesRequest = [RefreshDevicesRequest Request];
    self.refreshDevicesRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue] [@"communityCode"];
    [[SceneModel SceneModel] SEND_ACTION:self.refreshDevicesRequest];
}

- (void)setupRAC
{
    
    @weakify(self);
    [[RACObserve(self.userInfoVM, userInfoEntity) filter:^BOOL(UserInfoEntity *value) {
        return value != nil;
    }] subscribeNext:^(UserInfoEntity *x) {
        @strongify(self);
        
        self.userInfoEntity = x;
        
    }];

    [[RACObserve(self.getDeviceGroupVM, getDeviceGroups) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        
        if (x.count) {
//            self.roomString = self.getDeviceGroupVM.getDeviceGroupRequest.output[@"roomNum"];

            GetDeviceGroupEntity *entity = x[0];
            
            if (entity.deviceGroupType.intValue==2) {
                self.addressLabel.text = @"公共钥匙";
                
                self.homeInviteShowInfoView.inviteCodeString = @"公共钥匙";
                
                self.inviteCodeVM.inviteCodeRequest.deviceGroupId = @(0);
                self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId = @(0);

            }else{
            
                self.addressLabel.text = entity.deviceGroupName;
                
                self.doorLockLable.text = entity.deviceGroupName;

                self.inviteCodeVM.inviteCodeRequest.deviceGroupId = @(entity.deviceGroupId.intValue);
                
                self.homeInviteShowInfoView.inviteCodeString = entity.deviceGroupName;
                
                self.confirmButton.userInteractionEnabled = YES;
                
                [self.confirmButton setBackgroundColor:TextBlueColor];
            
            }
        }
    }];
    
    [[RACObserve(self.inviteCodeVM.inviteCodeRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        self.homeInviteShowInfoView.inviteCodeEntity = [[InviteCodeEntity alloc] initWithDictionary:self.inviteCodeVM.inviteCodeRequest.output error:nil];
        if (self.inviteCodeVM.inviteCodeRequest.deviceGroupId.intValue == 0) {
            self.homeInviteShowInfoView.inviteCodeString = @"公共钥匙";
        }
        [UIView animateWithDuration:0.5 animations:^{
            [self.homeInviteShowInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo([UIApplication sharedApplication].keyWindow);
            }];
            
            [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
            
        }];
        
        
    }];
    
    [[RACObserve(self.inviteCodeVM.invalidCodeHighRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        self.homeInviteShowInfoView.inviteCodeEntity = [[InviteCodeEntity alloc] initWithDictionary:self.inviteCodeVM.invalidCodeHighRequest.output error:nil];
        if (self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId.intValue == 0) {
            self.homeInviteShowInfoView.inviteCodeString = @"公共钥匙";
        }
        [UIView animateWithDuration:0.5 animations:^{
            [self.homeInviteShowInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo([UIApplication sharedApplication].keyWindow);
            }];
            
            [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
            
        }];
        
        
    }];
    

    
    [self.addressView whenTapped:^{					 
        @strongify(self);
        
        NSMutableArray *array = [NSMutableArray array];
        BOOL publi = YES;
        for (GetDeviceGroupEntity *entity in self.getDeviceGroupVM.getDeviceGroups) {
            if (entity.deviceGroupType.intValue == 2 && publi==YES) {
                [array addObject:@"公共钥匙"];
                publi = NO;
            }else{
                [array addObject:entity.deviceGroupName];
            }
        }

        [MMPickerView showPickerViewInView:self.view withStrings:@[array] withOptions:nil completion:^(NSArray *selectedString) {
            @strongify(self);
            NSNumber *select = selectedString[0];
            if (self.getDeviceGroupVM.getDeviceGroups.count>0) {
                GetDeviceGroupEntity *entity = self.getDeviceGroupVM.getDeviceGroups[select.intValue];
                if (entity.deviceGroupType.intValue == 2) {
                    self.addressLabel.text = @"公共钥匙";
                    self.homeInviteShowInfoView.inviteCodeString =  @"公共钥匙";//选择完 门卡发送弹窗赋值
                    self.inviteCodeVM.inviteCodeRequest.deviceGroupId = @(0);
                }else{
                    self.addressLabel.text = entity.deviceGroupName;
                    self.homeInviteShowInfoView.inviteCodeString = entity.deviceGroupName;//选择完 门卡发送弹窗赋值
                    
                    self.inviteCodeVM.inviteCodeRequest.deviceGroupId = @(entity.deviceGroupId.intValue);
                    
                }
            }else{
                
            }
            
        }];
        
    }];
    NSDictionary *dic = [LoginEntity shareManager].communityList[[[LoginEntity shareManager].page intValue]];
    self.roomString = dic[@"roomNum"];
}

- (void)inviteRecord
{
    self.isPush = YES;
    
    [self.navigationController pushViewController:[HomeInviteOpenVC new] animated:YES];
}
- (IBAction)clickToday {
    
    [self.todayButton setImage:[UIImage imageNamed:@"visitor_choose_in"] forState:UIControlStateNormal];
    [self.tomorrowButton setImage:[UIImage imageNamed:@"visitor_choose"] forState:UIControlStateNormal];
    
    self.inviteCodeVM.inviteCodeRequest.dateTag = @(0);
    
}
- (IBAction)clickTomorrow {
    
    [self.todayButton setImage:[UIImage imageNamed:@"visitor_choose"] forState:UIControlStateNormal];
    [self.tomorrowButton setImage:[UIImage imageNamed:@"visitor_choose_in"] forState:UIControlStateNormal];
    
    self.inviteCodeVM.inviteCodeRequest.dateTag = @(1);
}
- (IBAction)clickOneTime {
    
    [self.oneTimeButton setImage:[UIImage imageNamed:@"visitor_choose_in"] forState:UIControlStateNormal];
    [self.moreTimeButton setImage:[UIImage imageNamed:@"visitor_choose"] forState:UIControlStateNormal];
    
    self.inviteCodeVM.inviteCodeRequest.times = @(1);
}
- (IBAction)clickMoreTime {
    
    [self.oneTimeButton setImage:[UIImage imageNamed:@"visitor_choose"] forState:UIControlStateNormal];
    [self.moreTimeButton setImage:[UIImage imageNamed:@"visitor_choose_in"] forState:UIControlStateNormal];
    
    self.inviteCodeVM.inviteCodeRequest.times = @(0);
}
- (IBAction)clickConfirm {
        
    self.inviteCodeVM.inviteCodeRequest.requestNeedActive = YES;

}
- (IBAction)modelTouCh:(id)sender {
    if ([self.modelButton.titleLabel.text isEqualToString:@"高级模式"]) {
        self.calendarBackView.hidden = NO;
        [self.modelButton setTitle:@"简单模式" forState:UIControlStateNormal];
    }else{
        self.calendarBackView.hidden = YES;
        [self.modelButton setTitle:@"高级模式" forState:UIControlStateNormal];
    }
}
#pragma mark tableViewDelegate & dataSource

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 36;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeInviteCell *cell = [HomeInviteCell setupHomeInviteCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = 100+indexPath.row;
    cell.homeInviteCellDelegate = self;
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.endMask.hidden = NO;
    cell.startMask.hidden = NO;

    if ([dic[@"allDay"] isEqualToString:@"全天"]) {
        cell.startLable.text = @"全天";
        cell.endMask.hidden = NO;
        cell.startMask.hidden = YES;
    }else{
        if (self.isAllDay==YES) {
            cell.startMask.hidden = NO;
            cell.endMask.hidden = NO;
        }else{
            cell.startMask.hidden = YES;
            cell.endMask.hidden = YES;
        }
        if ([dic[@"startTime"] isEqualToString:@"1"]) {
            cell.startLable.text = @"";
        }else{
            cell.startLable.text = dic[@"startTime"];
        }
        
        if ([dic[@"endTime"] isEqualToString:@"1"]) {
            cell.endLable.text = @"";
        }else{
            cell.endLable.text = dic[@"endTime"];
        }

    }
    
       return cell;
}
-(void)homeInviteCell:(HomeInviteCell *)homeInviteCell selectRowAtLoc:(int)loc{
    self.statsRow = (int)homeInviteCell.tag-100;
    self.oneDatePicker.date = [NSDate date]; // 设置初始时间
    NSInteger timeSp = [[NSNumber numberWithDouble:[self.oneDatePicker.date timeIntervalSince1970]] integerValue];
    self.date = [NSString stringWithFormat:@"%ld",(long)timeSp/1000];
    self.dateString = [self formatter:self.oneDatePicker.date];
    NSArray *dataArray = [self.dateString componentsSeparatedByString:@":"];
    int a = [dataArray[1] intValue]- [dataArray[1] intValue]%15;
    if (a<10) {
        self.dateString = [NSString stringWithFormat:@"%@:0%D",dataArray[0],a];

    }else{
        self.dateString = [NSString stringWithFormat:@"%@:%D",dataArray[0],a];
    }
    if (loc == 0) {
        [self.dataArray removeObjectAtIndex:homeInviteCell.tag - 100];
        [self.tableView reloadData];
    }else if (loc == 1){
        self.dateView.hidden = NO;
        self.isStart = YES;
    }else{
        self.dateView.hidden = NO;
        self.isStart = NO;
    }
    
}
#pragma mark - 实现oneDatePicker的监听方法
- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    
    NSDate *select = [sender date]; // 获取被选中的时间
    NSInteger timeSp = [[NSNumber numberWithDouble:[select timeIntervalSince1970]] integerValue];
    self.date = [NSString stringWithFormat:@"%ld",(long)timeSp/1000];
   
    self.dateString = [self formatter:select];
    // 通过UIAlertView显示出来
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"时间提示" message:dateAndTime delegate:select cancelButtonTitle:@"Cancle" otherButtonTitles:nil, nil];
//    [alertView show];
    
    // 在控制台打印消息
    NSLog(@"%@", [sender date]);
}
-(NSString *)formatter:(NSDate *)select{
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"HH:mm"; // 设置时间和日期的格式
    NSString *dateAndTime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    return dateAndTime;
}
-(void)confirmTouch{
    if (self.dataArray.count<=self.statsRow) {//
        return;
    }
    
    
    NSDictionary *dic = self.dataArray[self.statsRow];
    NSMutableDictionary *mutDic = [dic mutableCopy];
    if (self.isStart==YES) {
        
        NSString *endTime = mutDic[@"endTime"];
        NSArray *endArray = [endTime componentsSeparatedByString:@":"];
        if (endArray.count>1) {
            NSArray *stratArray = [self.dateString componentsSeparatedByString:@":"];
            
            if ([stratArray[0] intValue]>[endArray[0] intValue]||([stratArray[0] intValue]==[endArray[0] intValue]&&[stratArray[1] intValue]>=[endArray[1] intValue])) {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"时间选择错误"];
                self.dateView.hidden = YES;
                return;
                
            }
        }
        
        [mutDic setObject:self.date forKey:@"startDate"];
        [mutDic setObject:self.dateString forKey:@"startTime"];
    }else{
        
        NSString *startTime = mutDic[@"startTime"];
        NSArray *stratArray = [startTime componentsSeparatedByString:@":"];
        NSArray *endArray = [self.dateString componentsSeparatedByString:@":"];

        if ([stratArray[0] intValue]>[endArray[0] intValue]||([stratArray[0] intValue]==[endArray[0] intValue]&&[stratArray[1] intValue]>=[endArray[1] intValue])) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"时间选择错误"];
            self.dateView.hidden = YES;
            return;
            
        }
        [mutDic setObject:self.date forKey:@"endDate"];
        [mutDic setObject:self.dateString forKey:@"endTime"];
    }
    if (self.timeMask.hidden==NO) {
        self.isAllDay = YES;
        [mutDic setObject:@"全天" forKey:@"allDay"];
        [mutDic setObject:@"00:00" forKey:@"startTime"];
        [mutDic setObject:@"23:59" forKey:@"endTime"];

    }else{
        self.isAllDay = NO;
        [mutDic setObject:@"非全天" forKey:@"allDay"];
    }
    dic = [mutDic copy];
    [self.dataArray replaceObjectAtIndex:self.statsRow withObject:dic];
    self.timeMask.hidden = YES;//每次确定隐藏 全天遮罩
    self.noAllDay.hidden = YES;

    self.dateView.hidden = YES;
    [self.tableView reloadData];
    
}
-(void)cancelTouch{
    self.dateView.hidden = YES;
}
-(void)addTimeTouch{
    
    NSDictionary *dic = @{@"startTime":@"1",@"endTime":@"1",@"startDate":@"1",@"endDate":@"1"};
    
    [self.dataArray addObject:dic];
    [self.tableView reloadData];
}
-(void)confirmTimeTouch{
    if (!(self.calendar.selectedDates.count>0)) {
        return [AYProgressHud progressHudShowShortTimeMessage:@"请选择日期"];
        
    }
    if (!(self.dataArray.count>0)) {
        return [AYProgressHud progressHudShowShortTimeMessage:@"请选择时间"];
        
    }
//    if (!self.inviteCodeVM.invalidCodeHighRequest.deviceGroupId) {
//        return [AYProgressHud progressHudShowShortTimeMessage:@"请选择门锁"];
//    }
    
    NSMutableArray *mutabArr = [NSMutableArray new];
//    if (!(self.userInfoVM.userInfoEntity.communityList.count>0)) {
//        return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号房间信息错误"];
//    }
//    CommunityListArrayEntity *model =self.userInfoVM.userInfoEntity.communityList[0] ;
//
//    HouseList *roomModel = model.householdList[0];
    
    
    for (int j =0 ; j<self.calendar.selectedDates.count; j++) {
        NSDate *day = self.calendar.selectedDates[j];
        NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
        selectDateFormatter.dateFormat = @"YYYY:MM:dd"; // 设置时间和日期的格式
        NSString *dateAndTime = [selectDateFormatter stringFromDate:day]; // 把date类型转为设置好格式的string类型
        BOOL b = YES;
        for (int i=0; i<self.dataArray.count; i++) {
            
            if (b==NO) {

                break;
            }
            
            NSDictionary *dic = self.dataArray[i];
            
            NSString *startStr;
            NSString *endStr;
            
            if (self.isAllDay==YES) {
                b = NO;
                startStr = [self convertToDate:dateAndTime :@"00:00"];
                endStr = [self convertToDate:dateAndTime :@"23:59"];
                
            }else{
                if ([dic[@"startTime"] isEqualToString:@"1"]) {
                    return [AYProgressHud progressHudShowShortTimeMessage:@"存在开始时间为空,请选择时间"];
                }
                if ([dic[@"endTime"] isEqualToString:@"1"]) {
                    return [AYProgressHud progressHudShowShortTimeMessage:@"存在结束时间为空,请选择时间"];
                }
                
                startStr = [self convertToDate:dateAndTime :dic[@"startTime"]];
                endStr = [self convertToDate:dateAndTime :dic[@"endTime"]];
            }
            if (!(self.roomString.length>1)) {
                return [AYProgressHud progressHudShowShortTimeMessage:@"房间信息错误"];
            }
            NSDictionary *dica = @{@"startTime":startStr,@"endTime":endStr,@"once":@"0",@"room":self.roomString};
            [mutabArr addObject:dica];
            
        }
        

    }
    
       NSString *time;
    if (mutabArr.count>0) {
        
        NSDictionary *start =  mutabArr[0];
        self.inviteCodeVM.invalidCodeHighRequest.startDate = start[@"startTime"];
        if (mutabArr.count==1) {
            NSDictionary *end =  mutabArr[mutabArr.count-1];
            self.inviteCodeVM.invalidCodeHighRequest.endDate = end[@"endTime"];

        }else{
            NSString *max = mutabArr[0][@"endTime"];

            for (int i = 0; i<mutabArr.count-1; i++) {
                NSDictionary *ends =  mutabArr[i+1];
                if (max.intValue>=[ends[@"endTime"] intValue]) {
                    
                }else{
                    max = ends[@"endTime"];
                }
            }
            self.inviteCodeVM.invalidCodeHighRequest.endDate = max;

        }
        time = [self convertToJsonData:[mutabArr copy]];
    }else{
        time = nil;
    }
    self.inviteCodeVM.invalidCodeHighRequest.time = time;
    
    self.inviteCodeVM.invalidCodeHighRequest.requestNeedActive = YES;
}
-(NSString *)convertToDate:(NSString *)timeA :(NSString *)timeB{
    NSString * dateAndTime = [NSString stringWithFormat:@"%@ %@",timeA,timeB];
    NSDateFormatter *dateFormatteri = [NSDateFormatter new];
    [dateFormatteri setDateFormat:@"YYYY:MM:dd HH:mm"];
    NSDate *myDate = [dateFormatteri dateFromString:dateAndTime];
    NSInteger  time = [[NSNumber numberWithDouble:[myDate timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)time];
}
-(NSString *)convertToJsonData:(NSArray *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
