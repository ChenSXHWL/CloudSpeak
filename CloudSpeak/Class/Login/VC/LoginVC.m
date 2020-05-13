//
//  LoginVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/8.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "LoginVC.h"
#import "ForgetPasswordVC.h"
#import "LoginVM.h"
#import "BXTabBarController.h"

@interface LoginVC ()

@property (strong, nonatomic) UITextField *phoneTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@property (strong, nonatomic) UIButton *forgetPasswordButton;

@property (strong, nonatomic) CustomBlueButton *customBlueButton;

@property (strong, nonatomic) LoginVM *loginVM;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupVM];
    
    [self setupRAC];
    
}

- (void)setupUI
{
    self.title = @"登录";
    
    UITextField *phoneTextField = [UITextField new];
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneTextField.placeholder = @"手机号";
//    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    UITextField *passwordTextField = [UITextField new];
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.keyboardType=UIKeyboardTypeASCIICapable;
    passwordTextField.placeholder = @"密码";
    passwordTextField.secureTextEntry = YES;
    [self.passwordView addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetPasswordButton setTitleColor:TextDeepGaryColor forState:UIControlStateNormal];
    [forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordMetho) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
    self.forgetPasswordButton = forgetPasswordButton;
    
    CustomBlueButton *customBlueButton = [CustomBlueButton setupCustomBlueButton:@"登 录"];
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
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.passwordView);
    }];
    
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(self.whiteBackgroundView.mas_bottom).offset(16);
    }];
    
    [self.customBlueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.forgetPasswordButton.mas_bottom).offset(32);
    }];
}

- (void)setupVM
{
    self.loginVM = [LoginVM SceneModel];
    
    self.customBlueButton.rac_command = self.loginVM.loginCommand;
    
    RAC(self.loginVM.loginRequest, loginName) = self.phoneTextField.rac_textSignal;
    
    RAC(self.loginVM.loginRequest, password) = self.passwordTextField.rac_textSignal;
    
    self.loginVM.scheme = self.scheme;
    
    self.loginVM.url = self.url;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginEntity shareManager].phone.length>0&&!(self.loginPhone.length>10)) {
        self.loginVM.loginRequest.loginName = [LoginEntity shareManager].phone;
        self.phoneTextField.text = [LoginEntity shareManager].phone;
        
    }
    
    if (self.loginPhone.length>10) {
        self.loginVM.loginRequest.loginName = self.loginPhone;
        self.phoneTextField.text = self.loginPhone;
    }
    

}
- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.loginVM.loginRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        self.loginPhone = @"";
        
        BXTabBarController *tabVC = [[BXTabBarController alloc] init];
        
        [self presentViewController:tabVC animated:YES completion:nil];
        
    }];
}

- (void)forgetPasswordMetho
{
    [self.navigationController pushViewController:[ForgetPasswordVC new] animated:YES];
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
