//
//  HomeMoreTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeMoreTView.h"

@interface HomeMoreTView ()

@property (strong, nonatomic) NSArray *array;

@end

@implementation HomeMoreTView

+ (instancetype)setupHomeMoreTView:(NSArray *)array
{
    HomeMoreTView *homeMoreTView = [[self alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    homeMoreTView.array = array;
    
    return homeMoreTView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.hidden = YES;
        
        self.scrollEnabled = NO;
        
        self.rowHeight = SCREEN_WIDTH / 6;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *communityList = [LoginEntity shareManager].communityList[indexPath.row];
    UILabel *textlab = [UILabel new];
    [cell.contentView addSubview:textlab];
    textlab.text = communityList[@"communityName"];
    textlab.textAlignment = NSTextAlignmentLeft;
    textlab.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3+20, SCREEN_WIDTH / 6);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *communityList = [LoginEntity shareManager].communityList[indexPath.row];
    
    [LoginEntity shareManager].page = @(indexPath.row);
    
    self.homeMoreTViewBlock(communityList);
}

@end
