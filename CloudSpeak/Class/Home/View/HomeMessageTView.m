//
//  HomeMessageTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeMessageTView.h"
#import "HomeMessageTVCell.h"
#import "HomeMessageTVSHeadView.h"
#import "OpenRecordVM.h"

@interface HomeMessageTView ()

@property (strong, nonatomic) OpenRecordVM *openRecordVM;

@end

@implementation HomeMessageTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH * 2 / 7;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupVM];
        
        [self setupRAC];
        
        [self mjRefreshOpenDoorMessageRecord];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.openRecordVM.openRecords.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.openRecordVM.openRecords[section];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeMessageTVCell *cell = [HomeMessageTVCell setupHomeMessageTVCell:tableView];
    
    cell.openRecordEntity = self.openRecordVM.openRecords[indexPath.section][indexPath.row];
    
    if (self.openRecordVM.openRecords.count) {
        
        cell.openDoorTypeLists = (NSArray *)self.openRecordVM.openRecordRequest.output[@"openDoorTypeList"];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SCREEN_WIDTH / 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.openRecordVM.openRecords.count) {
        
        HomeMessageTVSHeadView *homeMessageTVSHeadView = [HomeMessageTVSHeadView new];
        
        homeMessageTVSHeadView.openRecordEntity = self.openRecordVM.openRecords[section][0];
        
        if (section == 0) {
            
            homeMessageTVSHeadView.isShowLine = NO;
            
        } else {
            
            homeMessageTVSHeadView.isShowLine = YES;
            
        }
        
        return homeMessageTVSHeadView;
        
    }
    
    return nil;
    
}

- (void)setupVM
{
    self.openRecordVM = [OpenRecordVM SceneModel];
    
    self.openRecordVM.openRecordRequest.requestNeedActive = YES;
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.openRecordVM, openRecords) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        
        [self.mj_header endRefreshing];
        
        NSDictionary *dict = self.openRecordVM.openRecordRequest.output[@"openRecord"];
        
        if (!dict.count) {
            [self.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.mj_footer endRefreshing];
        }
        
        [self reloadData];
        
    }];
}

- (void)mjRefreshOpenDoorMessageRecord
{
    @weakify(self);
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        self.openRecordVM.openRecordRequest.pageIndex = @"0";
        self.openRecordVM.openRecordRequest.requestNeedActive = YES;
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        
        self.openRecordVM.openRecordRequest.pageIndex = [NSString stringWithFormat:@"%ld", (long)self.openRecordVM.openRecordRequest.pageIndex.integerValue + 1];
        self.openRecordVM.openRecordRequest.requestNeedActive = YES;
        
    }];
}

@end
