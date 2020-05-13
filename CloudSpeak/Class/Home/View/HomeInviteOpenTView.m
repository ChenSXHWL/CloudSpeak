//
//  HomeInviteOpenTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteOpenTView.h"
#import "HomeInviteOpenTVCell.h"
#import "OpenHistoryVM.h"
#import "InvalidCodeVM.h"

@interface HomeInviteOpenTView ()

@property (strong, nonatomic) OpenHistoryVM *openHistoryVM;

@property (strong, nonatomic) InvalidCodeVM *invalidCodeVM;

@end

@implementation HomeInviteOpenTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 4;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self setupVM];
        
        [self setupRAC];
        
        [self mjRefreshOpenDoorMessageRecord];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openHistoryVM.openHistorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeInviteOpenTVCell *cell = [HomeInviteOpenTVCell setupHomeInviteOpenTVCell:tableView];
    
    cell.openHistoryEntity = self.openHistoryVM.openHistorys[indexPath.row];
    
    return cell;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"失效";
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"失效" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
//            [self.openHistoryVM.openHistorys removeObjectAtIndex:indexPath.row];
//        
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        OpenHistoryEntity *entity = self.openHistoryVM.openHistorys[indexPath.row];
        
        self.invalidCodeVM.invalidCodeRequest.deviceGroupId = entity.deviceGroupId;
        
        self.invalidCodeVM.invalidCodeRequest.inviteCode = entity.inviteCode;
        
        self.invalidCodeVM.invalidCodeRequest.requestNeedActive = YES;
        
    }];
    
    return @[deleteRoWAction];
}

- (void)setupVM
{
    self.openHistoryVM = [OpenHistoryVM SceneModel];
    
    self.openHistoryVM.openHistoryRequest.requestNeedActive = YES;
    
    self.invalidCodeVM = [InvalidCodeVM SceneModel];
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.openHistoryVM, openHistorys) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        
        [self.mj_header endRefreshing];
        
        if (x.count / 10 < self.openHistoryVM.openHistoryRequest.pageIndex.integerValue + 1) {
            [self.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.mj_footer endRefreshing];
        }
        
        [self reloadData];
    }];
    
    [[RACObserve(self.invalidCodeVM.invalidCodeRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.openHistoryVM.openHistoryRequest.pageIndex = @"0";
        self.openHistoryVM.openHistoryRequest.requestNeedActive = YES;
    }];
}

- (void)mjRefreshOpenDoorMessageRecord
{
    @weakify(self);
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        self.openHistoryVM.openHistoryRequest.pageIndex = @"0";
        self.openHistoryVM.openHistoryRequest.requestNeedActive = YES;
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        self.openHistoryVM.openHistoryRequest.pageIndex = [NSString stringWithFormat:@"%ld", (long)self.openHistoryVM.openHistoryRequest.pageIndex.integerValue + 1];
        self.openHistoryVM.openHistoryRequest.requestNeedActive = YES;
        
    }];
}

@end
