//
//  MeSettingTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeSettingTView.h"
#import "MeSettingFootView.h"
#import "AYAlertViewController.h"
#import "ReSetPasswordVC.h"
#import "GuideVC.h"
#import "BaseNavigationController.h"
#import "LoginOutVM.h"
#import "OpenView.h"
#define MeSettingTitles @[@"MIC音量调节",@"修改密码"]

@interface MeSettingTView ()

@property (strong, nonatomic) LoginOutVM *loginOutVM;

@end

@implementation MeSettingTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 7;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        MeSettingFootView *meSettingFootView = [[MeSettingFootView alloc] init];
        
        meSettingFootView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 7);
        
        self.tableFooterView = meSettingFootView;
        
        @weakify(self);
        meSettingFootView.loginOutBlock = ^ {
            @strongify(self);
            
            NSString *scheme = [LoginEntity shareManager].scheme;
            
            NSString *url = [LoginEntity shareManager].url;
            
            [LoginManage loginOut];
                
            GuideVC *guideVC = [GuideVC new];
            
            guideVC.isLogin = YES;
            
            guideVC.scheme = scheme;
            
            guideVC.formalStr = url;
//            [[OpenView sharedInstance] removeFromSuperview];
            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
            
            self.loginOutVM.loginOutRequest.requestNeedActive = YES;
        };
        
        self.loginOutVM = [LoginOutVM SceneModel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isMic) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (_isMic) {
        if (indexPath.row == 0) {
            cell.textLabel.textColor = TextMainBlackColor;
            
            cell.textLabel.text = MeSettingTitles[indexPath.row];

        }else if (indexPath.row==1) {
            
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@""];
            
            UISlider *mic = [[UISlider alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-100, 44)];
            [cell.contentView addSubview:mic];
            self.micSlider = mic;
            
        }else if (indexPath.row==2){
            
            cell.textLabel.textColor = TextMainBlackColor;
            
            cell.textLabel.text = MeSettingTitles[indexPath.row-1];

        }
        
    }else{
        cell.textLabel.textColor = TextMainBlackColor;
        
        cell.textLabel.text = MeSettingTitles[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
//        self.isMic = !self.isMic;
//        [self reloadData];
        return;
    }
    if (self.isMic) {
        return;
    }
    [AYAlertViewController alertViewController:[[URLNavigation navigation] currentViewController] Title:nil message:@"为了保障您的账户安全,请输入原密码" cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:YES value:@"" alert:^(UIAlertController *action) {
        
        if (![[action.textFields[0] text] isEqualToString:[LoginEntity shareManager].password])
            
            return [AYProgressHud progressHudShowShortTimeMessage:@"密码错误"];

            ReSetPasswordVC *vc = [ReSetPasswordVC new];
        
            vc.phone = [LoginEntity shareManager].phone;
        
            vc.isLogin = YES;

            [[URLNavigation navigation].currentViewController.navigationController pushViewController:vc animated:YES];
        
        
        
    }];
    
//    self.meSettingBlock();
    
}

@end
