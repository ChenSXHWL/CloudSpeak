//
//  ManageSettingTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/30.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageSettingTView.h"
#import "ManageSettingTVFootView.h"
#import "AYAlertViewController.h"

#define MeSettingTitles @[@"账号",@"修改密码"]

@interface ManageSettingTView ()

@end

@implementation ManageSettingTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 7;
        
        self.scrollEnabled = NO;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        ManageSettingTVFootView *manageSettingTVFootView = [[ManageSettingTVFootView alloc] init];
        
        manageSettingTVFootView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 7);
        
        self.tableFooterView = manageSettingTVFootView;
        
        
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        
    }
    
    cell.textLabel.textColor = TextMainBlackColor;
    
    cell.textLabel.text = MeSettingTitles[indexPath.row];
    
    cell.detailTextLabel.textColor = TextMainBlackColor;
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"18950136993";
    } else {
        cell.detailTextLabel.text = @"";
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
    
    if (indexPath.row == 0) return;
    
    [AYAlertViewController alertViewController:[[URLNavigation navigation] currentViewController] Title:nil message:@"为了保障您的账户安全,请输入原密码" cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:YES value:@"" alert:^(UIAlertController *action) {
        
        //            if (![[[[action.textFields[0] text] MD5] lowercaseString] isEqualToString:[LoginEntity shareManager].password]) return [AYProgressHud progressHudShowShortTimeMessage:@"密码错误"];
        //
        //            SetPasswordVC *vc = [SetPasswordVC new];
        //            //修改密码（登陆后）
        //            vc.isLoaded = YES;
        //
        //            [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
//    self.manageSettingBlock();
    
}


@end
