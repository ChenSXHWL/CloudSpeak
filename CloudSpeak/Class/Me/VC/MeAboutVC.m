//
//  MeAboutVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeAboutVC.h"
#import "VersionUpRequest.h"
#import "VersionUpEntity.h"
@interface MeAboutVC ()

@property (strong, nonatomic) VersionUpRequest *versionUpRequest;

@property (strong, nonatomic) VersionUpEntity *versionUpEntity;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *label;

@property (assign, nonatomic) BOOL isUpData;

@property (strong, nonatomic) CustomBlueButton *button;


@end

@implementation MeAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCREEN_WIDTH / 4);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-100-kTopHeight);
    }];
    
    UILabel *label = [UILabel new]; 
//    label.text = @"当前版本 : V1.2.0_20180704";
    label.text = appCurVersion;

    label.textColor = TextDeepGaryColor;
    [self.view addSubview:label];
    self.label = label;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView.mas_centerX);
        make.top.equalTo(imageView.mas_bottom).offset(16);
        make.height.mas_equalTo(20);
    }];
    CustomBlueButton *button = [CustomBlueButton setupCustomBlueButton:@"检测升级"];
    [self.view addSubview:button];
    self.isUpData = NO;
    [button addTarget:self action:@selector(upDataTouch) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTopHeight);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(44);
    }];

    [self buildVM];
}
-(void)buildVM{
    self.versionUpRequest = [VersionUpRequest Request];
    self.versionUpRequest.appUserId = [LoginEntity shareManager].appUserId;
    [[RACObserve(self.versionUpRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }]subscribeNext:^(id x) {
        self.versionUpEntity = [[VersionUpEntity alloc]initWithDictionary:self.versionUpRequest.output[@"version"] error:nil];
//        NSString *appCurVersion = @"1.2.0";

        if ([self.versionUpEntity.appVersion isEqualToString:appCurVersion]) {
            [AYProgressHud progressHudShowShortTimeMessage:@"无版本更新"];
        }else{
            
            [self buildUI];
            
            self.isUpData = YES;
            [self.button setTitle:@"升级" forState:UIControlStateNormal];

        }

    }];
    
}
-(void)buildUI{
    if (self.backView) {
        self.backView.hidden = NO;
    }else{
        self.backView = [UIView new];
        self.backView.hidden = NO;
        [self.view addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label.mas_bottom).offset(24);
            make.left.right.bottom.equalTo(self.view);
        }];
        
        UIScrollView *backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2-92 )];
        backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (self.versionUpEntity.appVersion.length)/20 *18+324);  //非常重要
        backScrollView.contentOffset =  CGPointMake(0, 0);
        //    scrollView.backgroundColor = [UIColor redColor];
        //显示水平方向的滚动条(默认YES)
        backScrollView.showsHorizontalScrollIndicator = NO;
        //显示垂直方向的滚动条(默认YES)
        backScrollView.showsVerticalScrollIndicator = NO;
        [self.backView addSubview:backScrollView];

            
        UILabel *lableA = [UILabel new];
        lableA.text = @"已有更新版本，请点击【升级】进行版本更新";
        lableA.font = [UIFont systemFontOfSize:13];
        [backScrollView addSubview:lableA];
        [lableA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backView.mas_centerX);
            make.top.equalTo(backScrollView.mas_top).offset(6);
        }];
        
        UILabel *lableB = [UILabel new];
        lableB.text =[NSString stringWithFormat:@"i尚社区V%@更新内容如下:",self.versionUpEntity.appVersion];
        [backScrollView addSubview:lableB];
        [lableB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(16);
            make.top.equalTo(lableA.mas_bottom).offset(24);
        }];
        
        UILabel *contenText = [UILabel new];
        contenText.text = self.versionUpEntity.upgradeDetail;
        [backScrollView addSubview:contenText];
        [contenText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lableB.mas_bottom).offset(18);
            make.left.equalTo(self.backView.mas_left).offset(16);
            make.right.equalTo(self.backView.mas_right).offset(-16);
        }];
        
        UIImageView *contenImage = [UIImageView new];
        contenImage.image  = [UIImage imageNamed:@"banner"];
        [contenImage imageShwoActivityIndicatorWithUrlString:self.versionUpEntity.qrcodeUrl placeHolder:@"banner"];
        [backScrollView addSubview:contenImage];
        [contenImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(24);
            make.right.equalTo(self.backView).offset(-24);
            make.top.equalTo(contenText.mas_bottom).offset(16);
            make.height.mas_equalTo((SCREEN_WIDTH-48)/2);
        }];
        
       
    }
  
}
-(void)upDataTouch{
    
    if (self.isUpData==NO) {
        [[SceneModelConfig SceneModel] SEND_ACTION:self.versionUpRequest];

       }else{
               
    
        self.backView.hidden = YES;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppStoreUrl]];
    }
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
