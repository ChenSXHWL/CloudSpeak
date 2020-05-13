//
//  AdvertTableView.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AdvertTableView.h"
#import "AdvertTableViewCell.h"
#import "PropertyNnoticeListEntity.h"
@interface AdvertTableView ()


@end

@implementation AdvertTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self) {
        
        self.rowHeight =194;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self setupVM];
        
        [self setupRAC];
        
        
    }
    return self;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvertTableViewCell *cell = [AdvertTableViewCell setupAdvertTableViewCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PropertyNnoticeListEntity *model = self.dataArray[indexPath.row];
    cell.propertyNnoticeListEntity = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_advertTableViewDelegate respondsToSelector:@selector(advertTableView:selectRowAtLoc:)]) {
        [_advertTableViewDelegate advertTableView:self selectRowAtLoc:(int)indexPath.row];
    }
    
    
    
}
- (void)setupVM
{
}

- (void)setupRAC
{
}

@end
