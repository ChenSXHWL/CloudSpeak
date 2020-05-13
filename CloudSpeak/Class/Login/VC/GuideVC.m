//
//  GuideVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GuideVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"
#import "EngineeringRequest.h"
#import "EnviroumentChange.h"
@interface GuideVC () <CSEnviroumentChangeDelegate>

@property (strong, nonatomic) UIImageView *guideImageView;

@property (strong, nonatomic) UIView *registerView;

@property (strong, nonatomic) UIView *loginView;

@property (strong, nonatomic) UIButton *registerButton;

@property (strong, nonatomic) UIButton *loginButton;

@property (strong, nonatomic) UIButton *engineeringButton;

@property (strong, nonatomic) EnviroumentChange *enviroumentChange;

//@property (strong, nonatomic) UIButton *formalButton;
//
//@property (strong, nonatomic) UIButton *developmentButton;

@property (assign, nonatomic) int engNumber;

@property (strong, nonatomic) EngineeringRequest *engineeringRequest;

@property (strong, nonatomic) NSString *developmentStr;

@property (assign, nonatomic) BOOL selectPro;

@end

@implementation GuideVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.engNumber = 0;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self setupConstraint];
    
//    [self setupVM];
    
    
    if (self.isLogin) {
        
        [self loginInfo];
        
    }
    
}

- (void)setUI
{
    UIImageView *guideImageView = [UIImageView new];
    guideImageView.userInteractionEnabled = YES;
    guideImageView.backgroundColor = TextShallowGaryColor;
//    if (iPhoneX) {
//        guideImageView.image = [UIImage imageNamed:@"欢迎页x"];
//    }else{
        guideImageView.image = [UIImage imageNamed:@"欢迎页"];
//    }
    [self.view addSubview:guideImageView];
    self.guideImageView = guideImageView;
    
    UIView *registerView = [UIView new];
    registerView.backgroundColor = [UIColor clearColor];
    [guideImageView addSubview:registerView];
    self.registerView = registerView;
    
    UIView *loginView = [UIView new];
    loginView.backgroundColor = [UIColor clearColor];
    [guideImageView addSubview:loginView];
    self.loginView = loginView;
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerButton setBackgroundColor:[UIColor whiteColor]];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    [registerButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    registerButton.layer.borderColor = TextBlueColor.CGColor;
    registerButton.layer.borderWidth = 1;
    [registerView addSubview:registerButton];
    [registerButton addTarget:self action:@selector(registerInfo) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton = registerButton;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setBackgroundColor:TextBlueColor];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginView addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginInfo) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = loginButton;
    
    UIButton *engineeringButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [engineeringButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:engineeringButton];
    [engineeringButton addTarget:self action:@selector(engineeringInfo) forControlEvents:UIControlEventTouchUpInside];
    self.engineeringButton = engineeringButton;

    
    EnviroumentChange *enviroumentChange = [EnviroumentChange setupEnviroumentChange];
    enviroumentChange.url = self.formalStr;
    enviroumentChange.delegate = self;
    enviroumentChange.hidden = YES;
    [self.view addSubview:enviroumentChange];
    self.enviroumentChange = enviroumentChange;
    
//    UIButton *formalButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [formalButton setBackgroundColor:[UIColor whiteColor]];
//    formalButton.titleLabel.font = [UIFont systemFontOfSize:19];
//    [formalButton setTitle:@"正式环境" forState:UIControlStateNormal];
//    [formalButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
//    formalButton.layer.borderColor = TextBlueColor.CGColor;
//    formalButton.layer.borderWidth = 1;
//    [enviroumentChange addSubview:formalButton];
//    [formalButton addTarget:self action:@selector(formalInfo) forControlEvents:UIControlEventTouchUpInside];
//    self.formalButton = formalButton;
//    
//    UIButton *developmentButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [developmentButton setBackgroundColor:TextBlueColor];
//    developmentButton.titleLabel.font = [UIFont systemFontOfSize:19];
//    [developmentButton setTitle:@"测试环境" forState:UIControlStateNormal];
//    [developmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [enviroumentChange addSubview:developmentButton];
//    [developmentButton addTarget:self action:@selector(developmentInfo) forControlEvents:UIControlEventTouchUpInside];
//    self.developmentButton = developmentButton;
    
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"rootVC" object:nil] subscribeNext:^(NSNotification *x) {
    
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"rootVC" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        if (x==nil) {
            
        }else{
            self.loginPhone = x.userInfo[@"phone"];
        }
        [self loginInfo];
    }];
    
    [AYCloudSpeakApi cloudSpeakApi].isOutLogin = NO;
    
    if (!self.formalStr.length) {
        
        self.formalStr = ISHome_Host;
        
        self.scheme = @"http";
    }
    
}
-(void)engineeringInfo{
    self.engNumber +=1;
    NSLog(@"se==%D",self.engNumber);
    if (self.engNumber==10) {
        self.enviroumentChange.hidden = NO;
//        [[SceneModel SceneModel] SEND_ACTION:self.engineeringRequest];
//        [AYProgressHud progressHudLoadingRequest:self.engineeringRequest showInView:self.view detailString:@""];
    }
    if (self.engNumber==15) {
        self.engNumber = 0;
        self.enviroumentChange.hidden = YES;
    }
}
-(void)formalInfo{
    self.engNumber = 0;
    self.enviroumentChange.hidden = YES;
    self.selectPro = YES;
}
-(void)developmentInfo{
    self.engNumber = 0;
    self.enviroumentChange.hidden = YES;
    self.selectPro = NO;
}
- (void)setupConstraint
{
    [self.guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.guideImageView.mas_left);
        make.bottom.equalTo(self.guideImageView.mas_bottom).offset(- 60);
        make.width.mas_equalTo(SCREEN_WIDTH / 2);
        make.height.mas_equalTo(50);
    }];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.registerView.mas_right);
        make.centerY.equalTo(self.registerView.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerView.mas_left).offset(24);
        make.right.equalTo(self.registerView.mas_right).offset(-8);
        make.top.bottom.equalTo(self.registerView);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginView.mas_left).offset(8);
        make.right.equalTo(self.loginView.mas_right).offset(-24);
        make.top.bottom.equalTo(self.loginView);
    }];
    
    [self.engineeringButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(80);
    }];
    
    [self.enviroumentChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.registerButton.mas_top).offset(-10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
//    [self.formalButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.enviroumentChange.mas_left).offset(24);
//        make.top.bottom.equalTo(self.enviroumentChange);
//        make.width.mas_equalTo(SCREEN_WIDTH/2-32);
//    }];
//    
//    [self.developmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.enviroumentChange.mas_right).offset(-24);
//        make.top.bottom.equalTo(self.enviroumentChange);
//        make.width.mas_equalTo(SCREEN_WIDTH/2-32);
//    }];
    
}
-(void)setupVM{
    self.engineeringRequest = [EngineeringRequest Request];
    @weakify(self);
    [[RACObserve(self.engineeringRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        self.formalStr = self.engineeringRequest.output[@"formal"];
        
        if ([self.engineeringRequest.output[@"test"] hasPrefix:@"http://"]) {
            
//            self.developmentStr = [self.engineeringRequest.output[@"test"] substringFromIndex:7];
            self.developmentStr = @"119.23.146.101:8080/cmp";
            
        }
    }];
}
- (void)registerInfo
{
    self.enviroumentChange.hidden = YES;
    
    [Action actionConfigScheme:self.scheme host:self.formalStr client:@"" codeKey:@"isSuccess" rightCode:1 msgKey:@"msg"];
    
    [self.navigationController pushViewController:[RegisterVC new] animated:YES];
}

- (void)loginInfo
{
    
    LoginVC *loginVC = [LoginVC new];
    
//    if (!self.selectPro) {
//        
//        loginVC.url = self.formalStr;
//        
//        
//                
//    } else {
//        
//        loginVC.scheme = self.scheme;
//        
//        loginVC.url = self.developmentStr;
//        
//    }
    
    if (self.loginPhone.length>10) {
        loginVC.loginPhone = self.loginPhone;
    }
    
    loginVC.scheme = self.scheme;
    
    loginVC.url = self.formalStr;
    
    self.enviroumentChange.hidden = YES;
    self.engNumber = 0;
    
    [Action actionConfigScheme:self.scheme host:self.formalStr client:@"" codeKey:@"isSuccess" rightCode:1 msgKey:@"msg"];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (void)enviroumentChange:(EnviroumentChange *)enviroumentChange selectSipServiceWithLoc:(int)loc
{
    
}

- (void)enviroumentChange:(EnviroumentChange *)enviroumentChange selectUrlServiceWithLoc:(int)loc
{
    switch (loc) {
        case 0:
        {
            self.selectPro = YES;
            
            self.formalStr = ISHome_Host;
            
            self.scheme = @"https";
        }
            break;
        case 1:
        {
            self.selectPro = NO;
            
            self.formalStr = CeSi_Host;
            
            self.scheme = @"http";
        }
            break;
        case 2:
        {
            self.selectPro = NO;
            
            self.formalStr = SanXing_Host;//@"119.23.146.101:8080/cmp"
            
            self.scheme = @"http";
        }
            break;
        case 3:
        {
            self.selectPro = NO;
            
            self.formalStr = BiGui_Host;//@"112.74.80.35:8080/cmp"
            
            self.scheme = @"http";
        }
            break;
        case -1:
        {
            self.selectPro = NO;
            
            self.formalStr = ISHome_Host;
            
            self.scheme = @"http";
        }
            break;
            
        default:
            break;
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
