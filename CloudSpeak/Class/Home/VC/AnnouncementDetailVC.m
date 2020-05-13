//
//  AnnouncementDetailVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AnnouncementDetailVC.h"
#import "NoticeReadRequest.h"
@interface AnnouncementDetailVC ()
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *markLabel;

@property (strong, nonatomic) UILabel *titleLabel;

//@property (strong, nonatomic) UILabel *readLabel;
//
@property (strong, nonatomic) UILabel *readNumber;
//
@property (strong, nonatomic) UILabel *timeLabel;
//
@property (strong, nonatomic) UIImageView *contentImage;
//
@property (strong, nonatomic) UILabel *contentLabel;
//
@property (strong, nonatomic) NoticeReadRequest *noticeReadRequest;


@end

@implementation AnnouncementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小区公告";
    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    
    UIView *backView= [[UIView alloc]initWithFrame:CGRectMake(6, 70, SCREEN_WIDTH-12, SCREEN_HEIGHT-70)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    self.backView = backView;
    
    UILabel *markLabel = [UILabel new];
    markLabel.textColor = [UIColor whiteColor];
    markLabel.text = @"紧急";
    markLabel.backgroundColor = [UIColor redColor];
    markLabel.layer.cornerRadius = 12;
    markLabel.layer.masksToBounds = YES;
    markLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:markLabel];
    self.markLabel = markLabel;
    self.markLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:88/255.0 blue:107/255.0 alpha:1];

    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"春江里程紧急停电通知";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
//    UILabel *readLabel = [UILabel new];
//    readLabel.text = @"已阅";
//    readLabel.textColor = TextDeepGaryColor;
//    [self.view addSubview:readLabel];
//    self.readLabel = readLabel;
    
    UILabel *readNumber = [UILabel new];
    readNumber.textColor = TextDeepGaryColor;
    readNumber.text = @"阅读量：60";
    readNumber.font = [UIFont systemFontOfSize:14];
    [backView addSubview:readNumber];
    self.readNumber = readNumber;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.text = @"2017-08-07 14:11:45";
    timeLabel.textColor = TextDeepGaryColor;
    timeLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIImageView *contentImage = [UIImageView new];
    [backView addSubview:contentImage];
    self.contentImage = contentImage;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"奥术大师大所大所大所多啊实打实的阿萨德阿萨德阿萨德阿萨德啊身法自行车342 秩序自行车axzc zdxf weg zxc zxczxczx fas飒飒的小册子 微办公发V型从v";
    contentLabel.numberOfLines = 0;
    [backView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
   
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.top.equalTo(self.backView.mas_top).offset(16);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.markLabel.mas_bottom).offset(6);
    }];
    
//    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right).offset(-16);
//        make.centerY.equalTo(self.markLabel.mas_centerY);
//    }];
    
    [self.readNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(24);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(-24);
        make.centerY.equalTo(self.readNumber.mas_centerY);
    }];
    
    [self.contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
        if (self.propertyNnoticeListEntity.imgUrl.length<2) {
            make.height.mas_equalTo(0);
        }else{
            make.height.mas_equalTo((SCREEN_WIDTH-64)/2);
        }
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImage.mas_bottom).offset(12);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
    }];
    
    self.markLabel.text = self.propertyNnoticeListEntity.noticeType;
    self.titleLabel.text = self.propertyNnoticeListEntity.noticeTitle;
    self.readNumber.text = [NSString stringWithFormat:@"阅读量:%@",self.propertyNnoticeListEntity.readNum];
    self.timeLabel.text = self.propertyNnoticeListEntity.createTime;
    self.contentLabel.text = self.propertyNnoticeListEntity.noticeContent;
    NSString *url = [NSString stringWithFormat:@"%@%@",self.propertyNnoticeListEntity.domain,self.propertyNnoticeListEntity.imgUrl];
    [self.contentImage imageShwoActivityIndicatorWithUrlString:url placeHolder:@""];

    
    if ([self.propertyNnoticeListEntity.noticeType isEqualToString:@"紧急"]) {
        self.markLabel.backgroundColor =RGB(253, 88, 107);
    }else if ([self.propertyNnoticeListEntity.noticeType isEqualToString:@"新闻"]) {
        self.markLabel.backgroundColor =RGB(106, 140, 180);
    }else if ([self.propertyNnoticeListEntity.noticeType isEqualToString:@"提示"]) {
        self.markLabel.backgroundColor =RGB(255, 182, 95);
    }else if ([self.propertyNnoticeListEntity.noticeType isEqualToString:@"活动"]) {
        self.markLabel.backgroundColor =RGB(0, 188, 156);
    } else{
        self.markLabel.backgroundColor =RGB(0, 186, 252);
    }

}

-(void)popToVC{
    
    self.announcementDetailVCBlock([NSString stringWithFormat:@"%d",self.propertyNnoticeListEntity.readNum.intValue+1]);
    
    [super popToVC];
    
}

-(void)buildVM{
    self.noticeReadRequest = [NoticeReadRequest Request];
    self.noticeReadRequest.noticeId = self.propertyNnoticeListEntity.noticeId;
    self.noticeReadRequest.appUserId = [LoginEntity shareManager].appUserId;
    [[SceneModelConfig SceneModel] SEND_ACTION:self.noticeReadRequest];
    
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
