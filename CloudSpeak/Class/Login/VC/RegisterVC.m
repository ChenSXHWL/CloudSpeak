//
//  RegisterVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RegisterVC.h"
#import "SetPasswordVC.h"
#import "GetRegiterSmsCodeVM.h"

@interface RegisterVC ()
{
    int start;
}
@property (strong, nonatomic) UITextField *phoneTextField;

@property (strong, nonatomic) UITextField *codeTextField;

@property (strong, nonatomic) UIView *singleView;

@property (strong, nonatomic) UIButton *getCodeButton;

@property (strong, nonatomic) CustomBlueButton *customBlueButton;

@property (strong, nonatomic) NSTimer *getCodeTimer;

@property (strong, nonatomic) GetRegiterSmsCodeVM *getRegiterSmsCodeVM;

@end

@implementation RegisterVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.getCodeTimer invalidate];
    
    self.getCodeTimer = nil;
    
    [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    self.getCodeButton.userInteractionEnabled = YES;
    
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
    self.title = @"注册";
    
    UITextField *phoneTextField = [UITextField new];
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.placeholder = @"请输入手机号";
    [self.phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    UIView *singleView = [UIView new];
    singleView.backgroundColor = RGB(200, 200, 200);
    [self.whiteBackgroundView addSubview:singleView];
    self.singleView = singleView;
    
    UITextField *codeTextField = [UITextField new];
    codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    codeTextField.placeholder = @"请输入验证码";
    [self.passwordView addSubview:codeTextField];
    self.codeTextField = codeTextField;
    
    UIButton *getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [getCodeButton setTitleColor:TextDeepGaryColor forState:UIControlStateDisabled];
    [getCodeButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:getCodeButton];
    self.getCodeButton = getCodeButton;
    
    CustomBlueButton *customBlueButton = [CustomBlueButton setupCustomBlueButton:@"下一步"];
    [customBlueButton setBackgroundImage:[UIImage imageNamed:@"login_bg_in"] forState:UIControlStateNormal];
    [customBlueButton setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateDisabled];
    [self.view addSubview:customBlueButton];
    self.customBlueButton = customBlueButton;
    
    
}

- (void)setupConstraint
{
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.phoneView);
    }];
    
    [self.singleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset(8);
        make.bottom.equalTo(self.whiteBackgroundView.mas_bottom).offset(-8);
        make.width.mas_equalTo(0.5);
        make.right.equalTo(self.whiteBackgroundView.mas_right).offset(-100);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.passwordView);
        make.right.equalTo(self.singleView.mas_left);
    }];
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteBackgroundView.mas_right).offset(-2);
        make.bottom.equalTo(self.whiteBackgroundView.mas_bottom).offset(0);
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.equalTo(self.singleView.mas_right);
    }];
    
    [self.customBlueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.whiteBackgroundView.mas_bottom).offset(32);
    }];
}

- (void)setupVM
{
    self.getRegiterSmsCodeVM = [GetRegiterSmsCodeVM SceneModel];
    
    /*获取验证码*/
    self.getCodeButton.rac_command = self.getRegiterSmsCodeVM.getCodeCommond;
    
    RAC(self.getRegiterSmsCodeVM.getRegisterSmsCodeRequest, telNum) = self.phoneTextField.rac_textSignal;
    
    /*下一步 验证验证码*/
    self.customBlueButton.rac_command = self.getRegiterSmsCodeVM.nextCommond;
    
    RAC(self.getRegiterSmsCodeVM.checkSmsCodeRequest, telNum) = self.phoneTextField.rac_textSignal;
    
    RAC(self.getRegiterSmsCodeVM.checkSmsCodeRequest, smsCode) = self.codeTextField.rac_textSignal;
    
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.getRegiterSmsCodeVM.getRegisterSmsCodeRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        start = 59;
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d(s)",start --] forState:UIControlStateNormal];
        
        self.getCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getCodeTimeRun) userInfo:nil repeats:YES];
        
        self.getCodeButton.userInteractionEnabled = NO;
        
    }];
    
    [[RACObserve(self.getRegiterSmsCodeVM.checkSmsCodeRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        SetPasswordVC *setPasswordVC = [SetPasswordVC new];
        
        setPasswordVC.phone = self.phoneTextField.text;
        
        [self.navigationController pushViewController:setPasswordVC animated:YES];
        
    }];
}

- (void)getCodeTimeRun
{
    if (start == 0) {
        
        start = 59;
        
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.getCodeTimer invalidate];
        
        self.getCodeButton.userInteractionEnabled = YES;
        
    } else {
        
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d(s)",start --] forState:UIControlStateNormal];
        
        self.getCodeButton.userInteractionEnabled = NO;
        
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
