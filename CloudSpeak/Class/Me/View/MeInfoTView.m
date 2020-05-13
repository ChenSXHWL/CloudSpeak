//
//  MeInfoTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeInfoTView.h"
#import "MeInfoTVHeadView.h"
//#import "MeInfoTVFootView.h"
#import "UpdateInfoVM.h"

#define MeInfoTVTitles @[@"姓名",@"账号"]

@interface MeInfoTView ()

@property (strong, nonatomic) MeInfoTVHeadView *meInfoTVHeadView;

//@property (strong, nonatomic) MeInfoTVFootView *meInfoTVFootView;

@property (strong, nonatomic) NSArray *infoValues;

@property (strong, nonatomic) UpdateInfoVM *updateInfoVM;

@end

@implementation MeInfoTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self) {
        
        [self setupUI];
        
        [self setupVM];
        
        [self setupBlock];
        
    }
    return self;
}

- (void)setupUI
{
    self.rowHeight = SCREEN_WIDTH / 7;
    
    MeInfoTVHeadView *meInfoTVHeadView = [[MeInfoTVHeadView alloc] init];
    
    meInfoTVHeadView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 4);
    
    self.tableHeaderView = meInfoTVHeadView;
    
    self.meInfoTVHeadView = meInfoTVHeadView;
//    
//    MeInfoTVFootView *meInfoTVFootView = [[MeInfoTVFootView alloc] init];
//    
//    meInfoTVFootView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 7);
//    
//    self.tableFooterView = meInfoTVFootView;
//    
//    self.meInfoTVFootView = meInfoTVFootView;
}

- (void)setupVM
{
    self.updateInfoVM = [UpdateInfoVM SceneModel];
}

- (void)setupBlock
{
    @weakify(self);
    self.meInfoTVHeadView.meInfoTVHeadViewBlock = ^(NSString *imgUrl, NSString *domain) {
        @strongify(self);
        
        self.updateInfoVM.updateInfoRequest.imgUrl = imgUrl;
        
        self.updateInfoVM.updateInfoRequest.domain = domain;
        
        if (!self.updateInfoVM.updateInfoRequest.imgUrl.length) return;
        
        self.updateInfoVM.updateInfoRequest.requestNeedActive = YES;
        
    };
    
    [[RACObserve(self.updateInfoVM.updateInfoRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        self.meInfoTViewBlock();
        
    }];
}

- (void)saveInfo
{
    
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
        
        UIView *singleView = [UIView new];
        
        singleView.backgroundColor = RGB(242, 242, 242);
        
        [cell.contentView addSubview:singleView];
        
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
            make.bottom.equalTo(cell.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    cell.detailTextLabel.text = self.infoValues[indexPath.row];
    
    cell.detailTextLabel.textColor = TextMainBlackColor;
    
    cell.textLabel.textColor = TextDeepGaryColor;
    
    cell.textLabel.text = MeInfoTVTitles[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity
{
    _userInfoEntity = userInfoEntity;
    
    self.meInfoTVHeadView.userInfoEntity = userInfoEntity;
    
//    self.meInfoTVFootView.userInfoEntity = userInfoEntity;
    
    NSString *name = userInfoEntity.nickName.length ? userInfoEntity.nickName : @"";
    
    NSString *accout = userInfoEntity.loginName.length ? userInfoEntity.loginName : @"";
    
    self.infoValues = @[name, accout];
    
    [self reloadData];
}

@end
