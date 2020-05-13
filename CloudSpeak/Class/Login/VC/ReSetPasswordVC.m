//
//  ReSetPasswordVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ReSetPasswordVC.h"
#import "GuideVC.h"
#import "ReSetPwdVM.h"
#import "BXTabBarController.h"
#import "BaseNavigationController.h"

@interface ReSetPasswordVC ()

@property (strong, nonatomic) UITextField *phoneTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@property (strong, nonatomic) CustomBlueButton *customBlueButton;

@property (strong, nonatomic) ReSetPwdVM *reSetPwdVM;

@end

@implementation ReSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupVM];
    
    [self setupRAC];
    
}

- (void)setupUI
{
    self.title = @"设置密码";
    
    UITextField *phoneTextField = [UITextField new];
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.placeholder = @"新密码";
    phoneTextField.keyboardType=UIKeyboardTypeASCIICapable;
    [self.phoneView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    UITextField *passwordTextField = [UITextField new];
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.keyboardType=UIKeyboardTypeASCIICapable;
    passwordTextField.placeholder = @"确认密码";
    [self.passwordView addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    CustomBlueButton *customBlueButton = [CustomBlueButton setupCustomBlueButton:@"确 定"];
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
    
    [self.customBlueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.whiteBackgroundView.mas_bottom).offset(32);
    }];
}

- (void)setupVM
{
    self.reSetPwdVM = [ReSetPwdVM SceneModel];
    
    self.customBlueButton.rac_command = self.reSetPwdVM.resetPwdCommand;
    
    self.reSetPwdVM.resetPwdRequest.telNum = self.phone;
    
    RAC(self.reSetPwdVM.resetPwdRequest, password) = self.phoneTextField.rac_textSignal;
    
    RAC(self.reSetPwdVM.resetPwdRequest, confirmPassword) = self.passwordTextField.rac_textSignal;
    
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.reSetPwdVM.resetPwdRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.isLogin) {
            
            NSString *scheme = [LoginEntity shareManager].scheme;
            
            NSString *url = [LoginEntity shareManager].url;
            
            [LoginManage loginOut];
            
            GuideVC *guideVC = [GuideVC new];
            
            guideVC.isLogin = YES;
            
            guideVC.scheme = scheme;
            
            guideVC.formalStr = url;
            
            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
            
        } else {
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [[NSNotificationCenter defaultCenter] postNotification:@"rootVC" withObject:self.phone];

//            [[NSNotificationCenter defaultCenter] postNotificationName:@"rootVC" object:nil userInfo:@{@"phone":self.phone}];

        }
        
    }];
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
