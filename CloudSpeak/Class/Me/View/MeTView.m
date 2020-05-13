//
//  MeTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeTView.h"
#import "MeTVHeadView.h"

#define MeTVTitles @[@[@"我的钥匙",@"我的小区",@"免打扰",@"呼叫转移"],@[@"开门记录",@"用户反馈",@"帮助",@"关于APP",@"分享APP"]]

#define MeTVClassName @[@[@"MeMyKeyVC",@"MyNeighborhoodVC",@"MonitorSetVC",@"MeCallTransVC"],@[@"HomeMessageVC",@"AdviceVC",@"MeHelpVC",@"MeAboutVC",@"MeShareAppVC"]]

@interface MeTView ()

@property (strong, nonatomic) MeTVHeadView *meTVHeadView;

@end

@implementation MeTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 7;
        
        MeTVHeadView *meTVHeadView = [[MeTVHeadView alloc] init];
        
        meTVHeadView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 4);
        
        self.meTVHeadView = meTVHeadView;
        
        self.tableHeaderView = meTVHeadView;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        @weakify(self);
        [meTVHeadView whenTapped:^{
            @strongify(self);
            self.clickBlock(@"MeInfoVC");
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 4;
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            
            UIImageView *codeImage = [UIImageView new];
            
            codeImage.image = [UIImage imageNamed:@"tabBar_icon_customer_default"];
            
            [cell.contentView addSubview:codeImage];
            
            [codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right).offset(0);
                make.width.height.mas_equalTo(20);
            }];
            
        }
        
    }
    
    cell.textLabel.textColor = TextMainBlackColor;
    
    cell.textLabel.text = MeTVTitles[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    if (indexPath.section == 0) {
    
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        
//    }
    
    self.clickBlock(MeTVClassName[indexPath.section][indexPath.row]);
}

- (void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity
{
    _userInfoEntity = userInfoEntity;
    
    self.meTVHeadView.userInfoEntity = userInfoEntity;
}

@end
