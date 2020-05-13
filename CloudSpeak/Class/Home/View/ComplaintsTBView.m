//
//  ComplaintsTBView.m
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsTBView.h"
#import "ComplaintsTBViewCell.h"
#import "AdvertTableViewCell.h"
#import "HistoryComplaintsEntity.h"
@interface ComplaintsTBView ()


@end

@implementation ComplaintsTBView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self) {
        
        
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
    ComplaintsTBViewCell *cell = [ComplaintsTBViewCell setupComplaintsTBViewCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.complainTypeList = self.complainTypeList;
    cell.complainStatusList = self.complainStatusList;
    HistoryComplaintsEntity *model = self.dataArray[indexPath.row];
    cell.historyComplaintsEntity = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryComplaintsEntity *model =  self.dataArray[indexPath.row];
    
    if ([_advertTableViewDelegate respondsToSelector:@selector(complaintsTBView:selectRowAtLoc:)]) {
        [_advertTableViewDelegate complaintsTBView:self selectRowAtLoc:(int)indexPath.row];
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryComplaintsEntity *model = self.dataArray[indexPath.row];
    NSArray *image = [model.imgUrlList componentsSeparatedByString:@","];
    
    int a = 177+16;
    if (model.content.length<20) {
        a = a;
    }else if (model.content.length<40) {
        a = a+14;
    }else if (model.content.length<60){
        a = a+31;
    }else if (model.content.length<80){
        a = a+48;
    }else if (model.content.length<100){
        a = a+65;
    }else if (model.content.length<120){
        a = a+82;
    }else if (model.content.length<140){
        a = a+99;
    }else if (model.content.length<160){
        a = a+116;
    }else if (model.content.length<180){
        a = a+133;
    }else{
        a = a+151;
    }
    NSMutableArray *aaa = [image mutableCopy];
    for (int i =0; i<aaa.count; i++) {
        NSString *url = aaa[i];
        if (url.length>6) {
            
        }else{
            [aaa removeObject:url];
        }
    }
    image = [aaa copy];
    if (image.count==0) {
        return  a-66;
    }else{
        return  a;
    }
    
    
}
- (void)setupVM
{
}

- (void)setupRAC
{
}

@end

