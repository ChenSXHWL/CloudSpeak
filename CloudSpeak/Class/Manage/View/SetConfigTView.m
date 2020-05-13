//
//  SetConfigTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SetConfigTView.h"
#import "AYAnalysisXMLData.h"
#import "AYAlertViewController.h"

@interface SetConfigTView ()

@property (strong, nonatomic) NSMutableArray *titleArray;

@property (strong, nonatomic) NSMutableArray *valuesArray;

@property (strong, nonatomic) NSMutableArray *totalArray;

@property (strong, nonatomic) NSMutableArray *leftBarArray;

@property (copy, nonatomic) NSString *beChangeXMLString;

@property (strong, nonatomic) NSIndexPath *callIndexPath;

@property (strong, nonatomic) NSIndexPath *systemIndexPath;

@property (assign, nonatomic) BOOL isSelectMode;

@end

@implementation SetConfigTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 6;
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.titleArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *titleArray = self.titleArray[section];
    
    return titleArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UISlider *callSlider = [UISlider new];
        [callSlider addTarget:self action:@selector(callSliderSound:) forControlEvents:UIControlEventValueChanged];
        callSlider.minimumValue = 0;
        callSlider.maximumValue = 9;
        callSlider.hidden = YES;
        callSlider.tag = 35;
        [cell.contentView addSubview:callSlider];
        
        [callSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-32);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(150);
        }];
        
        UISlider *systemSlider = [UISlider new];
        [systemSlider addTarget:self action:@selector(systemSliderSound:) forControlEvents:UIControlEventValueChanged];
        systemSlider.minimumValue = 0;
        systemSlider.maximumValue = 9;
        systemSlider.hidden = YES;
        systemSlider.tag = 36;
        [cell.contentView addSubview:systemSlider];
        
        [systemSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-32);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(150);
        }];
        
    }
    
    UISlider *callSlider = (UISlider *)[cell.contentView viewWithTag:35];
    UISlider *systemSlider = (UISlider *)[cell.contentView viewWithTag:36];
    
    NSString *value = self.valuesArray[indexPath.section][indexPath.row];
    
    NSDictionary *section = self.totalArray[indexPath.section][indexPath.row];
    
    if ([section[@"tag"][@"tag"] isEqualToString:@"通话音量"]) {
        callSlider.maximumValue = 9;
        self.callIndexPath = indexPath;
        callSlider.value = value.floatValue;
        callSlider.hidden = NO;
        systemSlider.hidden = YES;
    } else if ([section[@"tag"][@"tag"] isEqualToString:@"系统音量"]) {
        systemSlider.maximumValue = 9;
        self.systemIndexPath = indexPath;
        systemSlider.value = value.floatValue;
        callSlider.hidden = YES;
        systemSlider.hidden = NO;
    } else {
        callSlider.hidden = YES;
        systemSlider.hidden = YES;
    }
    
    
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = value;
    
    return cell;
}

- (void)callSliderSound:(UISlider *)slider
{
    
    NSDictionary *section = self.totalArray[self.callIndexPath.section][self.callIndexPath.row];
    [self changeDataSelect:self.callIndexPath value:[NSString stringWithFormat:@"%d",(int)slider.value]];
    self.beChangeXMLString = [AYAnalysisXMLData xmlString:self.beChangeXMLString locString:section[@"uri"][@"uri"] content:[NSString stringWithFormat:@"%d",(int)slider.value]];
    
}

- (void)systemSliderSound:(UISlider *)slider
{
    NSDictionary *section = self.totalArray[self.systemIndexPath.section][self.systemIndexPath.row];
    
    [self changeDataSelect:self.systemIndexPath value:[NSString stringWithFormat:@"%d",(int)slider.value]];
    
    self.beChangeXMLString = [AYAnalysisXMLData xmlString:self.beChangeXMLString locString:section[@"uri"][@"uri"] content:[NSString stringWithFormat:@"%d",(int)slider.value]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *section = [NSDictionary dictionary];
    
    if (indexPath.section == 0) {
        NSMutableArray *array = [NSMutableArray array];
       NSMutableArray *arrcoun = self.totalArray[indexPath.section];
        for (int i = 0; i < [arrcoun count]; i ++) {
            
            if (i == 0 || i == 2 || i == 8) {
                
                [array addObject:self.totalArray[indexPath.section][i]];
                
            }
            
        }
        
        section = array[indexPath.row];
        
    } else {
        
        section = self.totalArray[indexPath.section][indexPath.row];
        
    }
    
    if (section[@"attrs"][@"read-only"]) return;
    
    if (section[@"options"]) {
        
        NSArray *selects = [AYAnalysisXMLData analysisSelectLoc:section];
        
        @weakify(self);
        [AYAlertViewController actionSheetViewController:[[URLNavigation navigation] currentViewController] Title:nil message:nil actionStrings:selects actionSheet:^(int index) {
            @strongify(self);
            NSString *similary = @"";
            if ([selects[0] isEqualToString:@"低"]) {
                if (index == 0) {
                    similary = @"60";
                } else if (index == 1) {
                    similary = @"75";
                } else {
                    similary = @"80";
                }
                
            } else {
                
                similary = [NSString stringWithFormat:@"%d", index];
                
            }

            [self changeDataSelect:indexPath value:selects[index]];

            self.beChangeXMLString = [AYAnalysisXMLData xmlString:self.beChangeXMLString locString:section[@"uri"][@"uri"] content:similary];
            
            if (![cell.detailTextLabel.text isEqualToString:selects[index]]) {
                
                self.isSelectMode = YES;
                
            } else {
                
                self.isSelectMode = NO;
                
            }

        }];
        
    } else {
        
        if ([section[@"tag"][@"tag"] isEqualToString:@"通话音量"] || [section[@"tag"][@"tag"] isEqualToString:@"系统音量"]) return;
        
        int keyboardType;
        NSInteger textLength;
        
        if ([section[@"attrs"][@"text-type"] isEqualToString:@"number"]) {
            keyboardType = 0;
            textLength = [(NSString *)section[@"attrs"][@"text-limit"] integerValue];
        } else if ([section[@"attrs"][@"text-type"] isEqualToString:@"string"]) {
            keyboardType = 1;
            textLength = MAXFLOAT;
        } else {
            keyboardType = 2;
            textLength = MAXFLOAT;
        }
        
        @weakify(self);
        [AYAlertViewController alertViewControllerNormal:[[URLNavigation navigation] currentViewController] Title:nil message:cell.textLabel.text cancelStr:@"取消" confirmStr:@"确定" style:keyboardType value:cell.detailTextLabel.text length:textLength alert:^(UIAlertController *action) {
            @strongify(self);
            NSString *textString = [action.textFields[0] text];
            
            [self changeDataSelect:indexPath value:textString];
            
            self.beChangeXMLString = [AYAnalysisXMLData xmlString:self.beChangeXMLString locString:section[@"uri"][@"uri"] content:textString];
        }];
        
    }
    
}

- (void)changeDataSelect:(NSIndexPath *)indexPath value:(NSString *)value
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < self.valuesArray.count; i ++) {
        
        if (i == indexPath.section) {
                        
            NSMutableArray *valueArray = [NSMutableArray arrayWithArray:self.valuesArray[i]];
                
            [valueArray replaceObjectAtIndex:indexPath.row withObject:value];
            
            [array addObject:valueArray];
            
        } else {
            
            [array addObject:self.valuesArray[i]];
        }
        
    }
    
    self.valuesArray = array;
    
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self setupHeadView:section];
}

- (UIView *)setupHeadView:(NSInteger)section
{
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 0, 0, 45);
    headView.backgroundColor = RGB(230, 230, 230);
    
    UILabel *deviceLabel = [UILabel new];
    deviceLabel.font = [UIFont systemFontOfSize:15];
    deviceLabel.text = self.leftBarArray[section];
    deviceLabel.textColor = TextMainBlackColor;
    [headView addSubview:deviceLabel];
    
    [deviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(headView.mas_left).offset(16);
    }];
    
    return headView;
    
}

- (void)setSysXML:(NSString *)sysXML
{
    _sysXML = sysXML;
    
    self.beChangeXMLString = sysXML;
}

- (void)saveXMLInfo
{
    if ([_setConfigDelegate respondsToSelector:@selector(sendXMLString:isSelectMode:)]) {
        [_setConfigDelegate sendXMLString:self.beChangeXMLString isSelectMode:self.isSelectMode];
    }
}

- (void)setGetDiviceInfo:(NSDictionary *)getDiviceInfo
{
    _getDiviceInfo = getDiviceInfo;
    
    NSMutableArray *array = [AYAnalysisXMLData arrayOfXMLArrayFromXMLDict:getDiviceInfo sysXML:self.beChangeXMLString];
    
    self.titleArray = [NSMutableArray arrayWithArray:array[0]];
    
    self.valuesArray = [NSMutableArray arrayWithArray:array[1]];
    
    self.totalArray = [NSMutableArray arrayWithArray:array[2]];
    
    self.leftBarArray = [NSMutableArray arrayWithArray:array[3]];
    
    [self reloadData];
    
}

@end
