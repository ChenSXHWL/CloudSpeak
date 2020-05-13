//
//  SetPasswordVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SetPasswordVC.h"
#import "LoginVC.h"
#import "RegisterVM.h"

@interface SetPasswordVC ()

@property (strong, nonatomic) UITextField *phoneTextField;

@property (strong, nonatomic) UITextField *passwordTextField;

@property (strong, nonatomic) CustomBlueButton *customBlueButton;

@property (strong, nonatomic) RegisterVM *registerVM;


@end

@implementation SetPasswordVC

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
    phoneTextField.keyboardType=UIKeyboardTypeASCIICapable;
    phoneTextField.placeholder = @"新密码";
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
    self.registerVM = [RegisterVM SceneModel];
    
    self.customBlueButton.rac_command = self.registerVM.registerCommand;
    
    self.registerVM.registerRequest.loginName = self.phone;
    
    RAC(self.registerVM.registerRequest, password) = self.phoneTextField.rac_textSignal;
    
    RAC(self.registerVM.registerRequest, confirmPassword) = self.passwordTextField.rac_textSignal;
    

}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.registerVM.registerRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        //            [[NSNotificationCenter defaultCenter] postNotification:@"rootVC" withObject:self.phone];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rootVC" object:nil userInfo:@{@"phone":self.phone}];
        
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
