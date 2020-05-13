//
//  ManageDetailTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/29.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageDetailTView.h"
#import "AYAlertViewController.h"
#import "GetConfigVM.h"
#import "GetSetConfigVM.h"
#import "AYCustomAlertView.h"
#import "SetDoorView.h"
#import "UploadConfigVM.h"
#import "GDMapView.h"
#import "AYAnalysisXMLData.h"


@interface ManageDetailTView ()

@property (strong, nonatomic) GetConfigVM *getConfigVM;

@property (strong, nonatomic) UploadConfigVM *uploadConfigVM;

@property (strong, nonatomic) GetSetConfigVM *getSetConfigVM;
@property (strong, nonatomic) NSArray *Titles;
@property (strong, nonatomic) NSArray *OtherTitles;

@property (strong, nonatomic) NSMutableArray *values;

@property (strong, nonatomic) UILabel *deviceNumLabel;
@property (strong, nonatomic) UILabel *uidNumLabel;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) DeviceInfoEntity *entity;

@end

@implementation ManageDetailTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        [self setupUI];
        
        [self setupVM];
        
        [self setupRAC];
        
        [self getCommunity];
        
    }
    return self;
}

- (void)setupUI
{
//
//#define Titles
//
//#define OtherTitles

    self.Titles = @[@"小区",@"区域",@"楼栋",@"单元",@"编号",@"名称",@"卡头",@"GPS",@"设备配置",@"软件版本",@"重启设备",@"配置权限组",@"同步数据",@"备份数据",@"删除设备"];
    self.OtherTitles =@[@"小区",@"区域",@"编号",@"名称",@"卡头",@"GPS",@"设备配置",@"软件版本",@"重启设备",@"配置权限组",@"同步数据",@"备份数据",@"删除设备"];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.tableHeaderView = [self setupHeadView];
    
    self.tableFooterView = [self footViewConfirmButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        return 15;
    } else {
        return 13;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

            
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
//        UILabel *valueLabel = [UILabel new];
//        valueLabel.textAlignment = NSTextAlignmentRight;
//        valueLabel.numberOfLines = 0;
//        valueLabel.tag = indexPath.row + 70;
//        [cell.contentView addSubview:valueLabel];
//        
//        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.right.equalTo(cell.contentView);
//            make.left.equalTo(cell.contentView.mas_left).offset(100);
//        }];

        
    }
    
    cell.textLabel.textColor = TextMainBlackColor;
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        
        cell.textLabel.text = self.Titles[indexPath.row];
        
    } else {
        
        cell.textLabel.text = self.OtherTitles[indexPath.row];
        
    }
    
//    UILabel *valueLabel = (UILabel *)[cell.contentView viewWithTag:70 + indexPath.row];
    if (indexPath.row+1>self.values.count) {
        cell.detailTextLabel.text = @"";
    }else{
        cell.detailTextLabel.text = self.values[indexPath.row];
    }
    
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.detailTextLabel.textColor = TextDeepGaryColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.indexPath = indexPath;
    
    if (!self.uploadConfigVM.deviceInfoRequest.output) return;
    
    @weakify(self);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        
        if (indexPath.row == 0) {
            
            if (![self.getConfigVM.getConfigRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;
            
            NSMutableArray *communityNames = [NSMutableArray array];
            
            for (NSDictionary *communityList in [LoginEntity shareManager].communityList) {
                
                [communityNames addObject:communityList[@"communityName"]];
                
            }
            
            [AYAlertViewController actionSheetViewController:[[URLNavigation navigation] currentViewController] Title:nil message:nil actionStrings:communityNames actionSheet:^(int index) {
                @strongify(self);
                
                [self changeData:communityNames[index] indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.communityCode = [LoginEntity shareManager].communityList[index][@"communityCode"];
                
                self.entity.communityName = [LoginEntity shareManager].communityList[index][@"communityName"];
                
                self.uploadConfigVM.uploadConfigRequest.communityId = [LoginEntity shareManager].communityList[index][@"communityId"];
                
                [self.values replaceObjectAtIndex:self.indexPath.row + 1 withObject:@""];
                [self.values replaceObjectAtIndex:self.indexPath.row + 2 withObject:@""];
                [self.values replaceObjectAtIndex:self.indexPath.row + 3 withObject:@""];
                self.uploadConfigVM.uploadConfigRequest.zoneId = nil;
                self.uploadConfigVM.uploadConfigRequest.buildingId = @"0";
                self.uploadConfigVM.uploadConfigRequest.unitId = @"0";
                
                [self reloadData];
                
                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/gid" content:[LoginEntity shareManager].communityList[index][@"communityCode"]];
                
                
            }];
            
        } else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3) {
            
            [self selectCommunity:indexPath];
            
        } else if (indexPath.row == 4) {
            
            //编号
            [AYAlertViewController alertViewControllerEquipmentSetting1:[[URLNavigation navigation] currentViewController] Title:nil message:cell.textLabel.text cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:NO value:cell.detailTextLabel.text alert:^(UIAlertController *action) {
                
                [self changeData:[action.textFields[0] text] indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.deviceCode = [action.textFields[0] text];
                self.entity.deviceCode = [action.textFields[0] text];

                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/panel/index" content:self.uploadConfigVM.uploadConfigRequest.deviceCode];
            }];
            
        } else if (indexPath.row == 5) {
            //名称
            [AYAlertViewController alertViewController:[[URLNavigation navigation] currentViewController] Title:nil message:cell.textLabel.text cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:NO value:cell.detailTextLabel.text alert:^(UIAlertController *action) {
                
                NSString *equipmentName = [action.textFields[0] text];
                
                if (equipmentName.length > 8) return [AYProgressHud progressHudShowShortTimeMessage:@"设备名称最长8个字符"];
                
                [self changeData:equipmentName indexPath:indexPath];
                
                self.entity.deviceName = [action.textFields[0] text];

                self.uploadConfigVM.uploadConfigRequest.deviceName = [action.textFields[0] text];
                
            }];
        } else if (indexPath.row == 6) {
            //卡头
            SetDoorView *setDoorView = [SetDoorView setupSetDoorView:cell.textLabel.text];
            [[UIApplication sharedApplication].keyWindow addSubview:setDoorView];
            
            setDoorView.setDoorViewBlock = ^(NSString *outString, NSString *inString) {
                @strongify(self);
                [self changeData:[NSString stringWithFormat:@"主卡/%@, 副卡/%@",outString, inString] indexPath:indexPath];
                self.uploadConfigVM.uploadConfigRequest.enterFlag = outString;
                self.uploadConfigVM.uploadConfigRequest.outFlag = inString;
            };
        } else if (indexPath.row == 7) {
            //地图
            
            GDMapView *mapView = [GDMapView new];
            [[UIApplication sharedApplication].keyWindow addSubview:mapView];
            
            [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo([UIApplication sharedApplication].keyWindow);
                
            }];
            
            mapView.mapViewBlock = ^(NSString *address, NSString *point) {
                @strongify(self);
                
                [self changeData:address indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.gpsAddress = address;
                self.entity.gpsAddress  = address;

                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/gps" content:point];
                
            };
            
        } else if (indexPath.row == 8) {
            //配置设备
            self.configBlock(self.getConfigVM.getConfigEntity, self.uploadConfigVM.uploadConfigRequest.configStr, self.getSetConfigVM.getSettingConfigRequest.output);
            
            
        } else if (indexPath.row == 10) {
            
            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否重启设备?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                
                self.uploadConfigVM.reBootRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 11) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            //配置权限组
            self.pushDevIdBlock(self.deviceId);
            
        }else if (indexPath.row == 12) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否同步数据?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.synchronousDevRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;
                self.uploadConfigVM.synchronousDevRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 13) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否备份数据?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.backupDevConfigRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;
                
                self.uploadConfigVM.backupDevConfigRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 14) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否删除设备?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.delDevRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;
                
                self.uploadConfigVM.delDevRequest.requestNeedActive = YES;
                
            }];
            
        } else {
            
            return;
        }
        
    } else {
        
        if (indexPath.row == 0) {
            
            if (![self.getConfigVM.getConfigRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;
            
            NSMutableArray *communityNames = [NSMutableArray array];
            
            for (NSDictionary *communityList in [LoginEntity shareManager].communityList) {
                
                [communityNames addObject:communityList[@"communityName"]];
                
            }
            
            [AYAlertViewController actionSheetViewController:[[URLNavigation navigation] currentViewController] Title:nil message:nil actionStrings:communityNames actionSheet:^(int index) {
                @strongify(self);
                
                [self changeData:communityNames[index] indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.communityCode = [LoginEntity shareManager].communityList[index][@"communityCode"];
                
                self.entity.communityName =  [LoginEntity shareManager].communityList[index][@"communityName"];
                
                self.uploadConfigVM.uploadConfigRequest.communityId = [LoginEntity shareManager].communityList[index][@"communityId"];
                
                [self.values replaceObjectAtIndex:self.indexPath.row + 1 withObject:@""];
                [self.values replaceObjectAtIndex:self.indexPath.row + 2 withObject:@""];
                [self.values replaceObjectAtIndex:self.indexPath.row + 3 withObject:@""];
                self.uploadConfigVM.uploadConfigRequest.zoneId = nil;
                self.uploadConfigVM.uploadConfigRequest.buildingId = @"0";
                self.uploadConfigVM.uploadConfigRequest.unitId = @"0";
                
                [self reloadData];
                
                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/gid" content:[LoginEntity shareManager].communityList[index][@"communityCode"]];
                
            }];
            
            
        } else if (indexPath.row == 1) {
            
            NSString *string = self.values[indexPath.row - 1];
            
            if (!string.length) return [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"请先选择%@", self.Titles[indexPath.row - 1]]];
                
            self.getConfigVM.communityInfoRequest.communityId = self.uploadConfigVM.uploadConfigRequest.communityId;
            self.getConfigVM.communityInfoRequest.zoneId = nil;
            self.getConfigVM.communityInfoRequest.buildingId = nil;
            self.getConfigVM.communityInfoRequest.unitId = nil;
            
            self.getConfigVM.communityInfoRequest.requestNeedActive = YES;
            
        } else if (indexPath.row == 2) {
            //编号
            [AYAlertViewController alertViewController:[[URLNavigation navigation] currentViewController] Title:nil message:cell.textLabel.text cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:NO value:cell.detailTextLabel.text alert:^(UIAlertController *action) {
                
                [self changeData:[action.textFields[0] text] indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.deviceCode = [action.textFields[0] text];
                self.entity.deviceCode = [action.textFields[0] text];

                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/panel/index" content:self.uploadConfigVM.uploadConfigRequest.deviceCode];
                
            }];
            
        } else if (indexPath.row == 3) {
            //名称
            [AYAlertViewController alertViewControllerEquipmentSetting1:[[URLNavigation navigation] currentViewController] Title:nil message:cell.textLabel.text cancelStr:@"取消" confirmStr:@"确定" styleText:1 isSecret:NO value:cell.detailTextLabel.text alert:^(UIAlertController *action) {
                
                NSString *equipmentName = [action.textFields[0] text];
                
                if (equipmentName.length > 8) return [AYProgressHud progressHudShowShortTimeMessage:@"设备名称最长8个字符"];
                
                [self changeData:equipmentName indexPath:indexPath];
                
                self.entity.deviceName = [action.textFields[0] text];

                self.uploadConfigVM.uploadConfigRequest.deviceName = [action.textFields[0] text];
                
            }];
        } else if (indexPath.row == 4) {
            //卡头
            SetDoorView *setDoorView = [SetDoorView setupSetDoorView:cell.textLabel.text];
            [[UIApplication sharedApplication].keyWindow addSubview:setDoorView];
            
            setDoorView.setDoorViewBlock = ^(NSString *outString, NSString *inString) {
                @strongify(self);
                [self changeData:[NSString stringWithFormat:@"主卡/%@, 副卡/%@",outString, inString] indexPath:indexPath];
                self.uploadConfigVM.uploadConfigRequest.enterFlag = outString;
                self.uploadConfigVM.uploadConfigRequest.outFlag = inString;
            };
        } else if (indexPath.row == 5) {
            //地图
            
            GDMapView *mapView = [GDMapView new];
            [[UIApplication sharedApplication].keyWindow addSubview:mapView];
            
            [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.equalTo([UIApplication sharedApplication].keyWindow);
                
            }];
            
            mapView.mapViewBlock = ^(NSString *address, NSString *point) {
                @strongify(self);
                
                [self changeData:address indexPath:indexPath];
                
                self.uploadConfigVM.uploadConfigRequest.gpsAddress = address;
                self.entity.gpsAddress  = address;
                self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/gps" content:point];
                
            };
            
        } else if (indexPath.row == 6) {
            
            //配置设备
            self.configBlock(self.getConfigVM.getConfigEntity, self.uploadConfigVM.uploadConfigRequest.configStr, self.getSetConfigVM.getSettingConfigRequest.output);
            
            
        } else if (indexPath.row == 8) {
            
            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否重启设备?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                
                self.uploadConfigVM.reBootRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 9) {
            //配置权限组
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            self.pushDevIdBlock(self.deviceId);
            
        }else if (indexPath.row == 10) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否同步数据?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.synchronousDevRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;
                self.uploadConfigVM.synchronousDevRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 11) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否备份数据?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.backupDevConfigRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;

                self.uploadConfigVM.backupDevConfigRequest.requestNeedActive = YES;
                
            }];
            
        }else if (indexPath.row == 12) {
            if ([self.uploadConfigVM.deviceInfoRequest.communityCode isEqualToString:@"A1234567891011121314151617181920"]) return;

            [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:nil message:@"是否删除设备?" cancelStr:@"取消" confirmStr:@"确认" styleText:0 isSecret:0 value:0 alert:^(UIAlertController *action) {
                @strongify(self);
                self.uploadConfigVM.delDevRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;

                self.uploadConfigVM.delDevRequest.requestNeedActive = YES;
                
            }];
            
        } else {
            
            return;
        }
        
    }
    
}

- (void)selectCommunity:(NSIndexPath *)indexPath
{
    NSString *string = self.values[indexPath.row - 1];
    
    if (!string.length) return [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"请先选择%@", self.Titles[indexPath.row - 1]]];
    
    if (indexPath.row == 1) {
        
        self.getConfigVM.communityInfoRequest.communityId = self.uploadConfigVM.uploadConfigRequest.communityId;
        self.getConfigVM.communityInfoRequest.zoneId = nil;
        self.getConfigVM.communityInfoRequest.buildingId = nil;
        self.getConfigVM.communityInfoRequest.unitId = nil;
        
    } else if (indexPath.row == 2) {
        
        self.getConfigVM.communityInfoRequest.communityId = self.uploadConfigVM.uploadConfigRequest.communityId;
        self.getConfigVM.communityInfoRequest.zoneId = self.uploadConfigVM.uploadConfigRequest.zoneId;
        self.getConfigVM.communityInfoRequest.buildingId = nil;
        self.getConfigVM.communityInfoRequest.unitId = nil;
        
    } else {
        
        self.getConfigVM.communityInfoRequest.communityId = self.uploadConfigVM.uploadConfigRequest.communityId;
        self.getConfigVM.communityInfoRequest.zoneId = self.uploadConfigVM.uploadConfigRequest.zoneId;
        self.getConfigVM.communityInfoRequest.buildingId = self.uploadConfigVM.uploadConfigRequest.buildingId;
        self.getConfigVM.communityInfoRequest.unitId = nil;
        
    }
    
    self.getConfigVM.communityInfoRequest.requestNeedActive = YES;
    
}

- (void)getCommunity
{
    @weakify(self);
    [[RACObserve(self.getConfigVM.communityInfoRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        CommunityInfoEntity *entity = [[CommunityInfoEntity alloc] initWithDictionary:self.getConfigVM.communityInfoRequest.output error:nil];
        
        NSMutableArray *communityInfos = [NSMutableArray array];
        
        if (self.indexPath.row == 1) {
            
            for (CommunityInfoZoneEntity *zones in entity.zoneList) {
                [communityInfos addObject:zones.zoneName];
            }
            
        } else if (self.indexPath.row == 2) {
            
            for (CommunityInfoBuildingEntity *buildings in entity.buildingList) {
                [communityInfos addObject:buildings.buildingName];
                
            }
            
        } else {
            
            for (CommunityInfoUnitEntity *units in entity.unitList) {
                [communityInfos addObject:units.unitName];
            }
            
        }
        
        [AYAlertViewController actionSheetViewController:[[URLNavigation navigation] currentViewController] Title:nil message:nil actionStrings:communityInfos actionSheet:^(int index) {
            @strongify(self);
            
            [self changeData:communityInfos[index] indexPath:self.indexPath];
            
            if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
                
                if (self.indexPath.row == 1) {
                    self.uploadConfigVM.uploadConfigRequest.zoneId = [self.getConfigVM.communityInfoEntity.zoneList[index] zoneId];
                    self.entity.zoneName = [self.getConfigVM.communityInfoEntity.zoneList[index] zoneName];
                    self.entity.buildingName = @"";
                    self.entity.unitName = @"";

                    [self.values replaceObjectAtIndex:self.indexPath.row + 1 withObject:@""];
                    [self.values replaceObjectAtIndex:self.indexPath.row + 2 withObject:@""];
                    self.uploadConfigVM.uploadConfigRequest.buildingId = nil;
                    self.uploadConfigVM.uploadConfigRequest.unitId = @"0";
                    
                    
                } else if (self.indexPath.row == 2) {
                    
                    self.uploadConfigVM.uploadConfigRequest.buildingId = [self.getConfigVM.communityInfoEntity.buildingList[index] buildingId];
                    self.uploadConfigVM.uploadConfigRequest.buildingCode = [self.getConfigVM.communityInfoEntity.buildingList[index] buildingCode];
                    self.entity.buildingName = [self.getConfigVM.communityInfoEntity.buildingList[index] buildingName];
                    self.entity.unitName = @"";

                    self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/talk/building" content:self.uploadConfigVM.uploadConfigRequest.buildingCode];
                    
                    [self.values replaceObjectAtIndex:self.indexPath.row + 1 withObject:@""];
                    
                    self.uploadConfigVM.uploadConfigRequest.unitId = @"0";
                    
                    
                } else {
                    
                    self.uploadConfigVM.uploadConfigRequest.unitId = [self.getConfigVM.communityInfoEntity.unitList[index] unitId];
                    
                    self.uploadConfigVM.uploadConfigRequest.unitCode = [self.getConfigVM.communityInfoEntity.unitList[index] unitCode];
                    self.entity.unitName = [self.getConfigVM.communityInfoEntity.unitList[index] unitName];

                    self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/talk/unit" content:self.uploadConfigVM.uploadConfigRequest.unitCode];
                    
                }
                
            } else {
                
                self.uploadConfigVM.uploadConfigRequest.zoneId = [self.getConfigVM.communityInfoEntity.zoneList[index] zoneId];
                self.entity.zoneName = [self.getConfigVM.communityInfoEntity.zoneList[index] zoneName];

                self.uploadConfigVM.uploadConfigRequest.buildingId = @"0";
                self.uploadConfigVM.uploadConfigRequest.unitId = @"0";
                
                
                
            }
            
            [self reloadData];
        }];
        
    }];
}

- (void)changeData:(NSString *)string indexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < self.values.count; i ++) {
        
        if (indexPath.row == i) {
            
            [self.values replaceObjectAtIndex:i withObject:string.length ? string : @""];
            
        }
        
    }
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        
        if (indexPath.row >= 0 && indexPath.row < 4) return;
        
    } else {
        
        if (indexPath.row == 1 || indexPath.row == 0) return;
        
    }
    
    [self reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        
        if (indexPath.row == 7) return 100;
        
        if (indexPath.row == 9) return 80;
        
        
    } else {
        
        if (indexPath.row == 5) return 100;
        
        if (indexPath.row == 7) return 80;
        
        
    }
    
    return SCREEN_WIDTH / 6;
    
    
}

- (void)setupVM
{
    self.getConfigVM = [GetConfigVM SceneModel];
    
    self.uploadConfigVM = [UploadConfigVM SceneModel];
    
    self.getSetConfigVM = [GetSetConfigVM SceneModel];
    
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.getConfigVM.getConfigRequest, state) filter:^BOOL(id value) {
        return YES;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        if (x == RequestStateSending || x == nil) return ;
        
        if (x == RequestStateSuccess) {
            NSLog(@"xml===%@",(NSString *)self.getConfigVM.getConfigRequest.output[@"sys"]);
            self.uploadConfigVM.uploadConfigRequest.configStr = (NSString *)self.getConfigVM.getConfigRequest.output[@"sys"];
            
            //获取设备信息
            self.uploadConfigVM.deviceInfoRequest.deviceNum = self.getConfigVM.getConfigRequest.deviceNum;
            self.uploadConfigVM.deviceInfoRequest.timestamp = self.timestamp;
            self.uploadConfigVM.deviceInfoRequest.requestNeedActive = YES;
            

        } else {
            
            self.popBlock();
            
        }
        
        
    }];
    
    //获取到页面设备的一些配置信息
    [[RACObserve(self.uploadConfigVM.deviceInfoRequest, state) filter:^BOOL(id value) {
        return value==RequestStateSuccess||RequestStateFailed;
    }] subscribeNext:^(id x) {
        @strongify(self);
        if (self.uploadConfigVM.deviceInfoRequest.state == RequestStateSending||self.uploadConfigVM.deviceInfoRequest.state == nil) {
            return ;
        }
        NSNumber *num = (NSNumber *)self.uploadConfigVM.deviceInfoRequest.output[@"errorCode"];

        if ([num.stringValue isEqualToString:@"31"]||[num.stringValue isEqualToString:@"54"]) {
            
            self.popBlock();
            
            return ;
        }
        
        if (![self.uploadConfigVM.deviceInfoRequest.output[@"isSuccess"] isEqualToString:@"1"]) return;
        
       
        DeviceInfoEntity *entity = [[DeviceInfoEntity alloc] initWithDictionary:self.uploadConfigVM.deviceInfoRequest.output[@"deviceMap"] error:nil];
        self.deviceId = entity.deviceId;
        self.uploadConfigVM.synchronousDevRequest.communityCode = entity.communityCode;
        
        self.uploadConfigVM.backupDevConfigRequest.communityCode = entity.communityCode;
        
        self.uploadConfigVM.delDevRequest.communityCode = entity.communityCode;
        
//        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController message:[NSString stringWithFormat:@"buildingName=%@,communityCode==%@,deviceName==%@,unitName==%@,deviceCode==%@,communityName==%@,unitId==%@,zoneName==%@,buildingId==%@,zoneId==%@,communityId==%@,sipAccount==%@,buildingCode==%@,unitCode==%@,gpsAddress==%@,cloudSwitch==%@",entity.buildingName,entity.communityCode,entity.deviceName,entity.unitName,entity.deviceCode,entity.communityName,entity.unitId,entity.zoneName,entity.buildingId,entity.zoneId,entity.communityId,entity.sipAccount,entity.buildingCode,entity.unitCode,entity.gpsAddress,entity.cloudSwitch] confirmStr:@"aaa" alert:^(UIAlertController *action) {
//            
//        } ];
        self.sipAccount = entity.sipAccount;
        self.test(self.getConfigVM.getConfigRequest.communityCode ? entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"], entity.communityName.length ? entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"]);
        
        NSString *FW;
        
        if (self.getConfigVM.getConfigEntity.version.ui.length) {
            
            FW = [NSString stringWithFormat:@"FW:%@\nUI:%@", self.getConfigVM.getConfigEntity.version.fw, self.getConfigVM.getConfigEntity.version.ui];
            
        } else {
            
            FW = [NSString stringWithFormat:@"FW:%@", self.getConfigVM.getConfigEntity.version.fw];
            
        }
        
        if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
            if (entity.buildingName.length) {
                NSMutableString *str = [NSMutableString stringWithString:entity.buildingName];
                entity.buildingName = [str stringByReplacingOccurrencesOfString:@"栋" withString:@""];
                NSMutableString *strs = [NSMutableString stringWithString:entity.unitName];
                entity.unitName = [strs stringByReplacingOccurrencesOfString:@"单元" withString:@""];
            }
          
            
            self.values = [NSMutableArray arrayWithArray:@[entity.communityName.length ? entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"],entity.zoneName.length ? entity.zoneName : @"", entity.buildingName.length ?  [NSString stringWithFormat:@"%@(%@栋)",entity.buildingName,entity.buildingName] : @"", entity.unitName.length ? [NSString stringWithFormat:@"%@(%@单元)",entity.unitName,entity.unitName] : @"", entity.deviceCode.length ? entity.deviceCode : @"", entity.deviceName.length ? entity.deviceName : @"", @"主卡/入, 副卡/出", entity.gpsAddress.length ? entity.gpsAddress : @"", @"", FW, @"",]];
            
            self.uploadConfigVM.uploadConfigRequest.deviceType = @"M";
            
        } else {
            
            self.values = [NSMutableArray arrayWithArray:@[entity.communityName.length ? entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"],entity.zoneName.length ? entity.zoneName : @"", entity.deviceCode.length ? entity.deviceCode : @"", entity.deviceName.length ? entity.deviceName : @"", @"主卡/入, 副卡/出", entity.gpsAddress.length ? entity.gpsAddress : @"", @"", FW, @"",]];
            
            self.uploadConfigVM.uploadConfigRequest.deviceType = @"W";
            
        }
        if (entity.communityCode.length>0) {
            
        }else{
            self.entity.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
            self.entity.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
            self.entity.communityName = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"];

            self.uploadConfigVM.uploadConfigRequest.communityCode =  [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
            
            self.uploadConfigVM.uploadConfigRequest.communityId =[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
       
          
            
            
        }
        self.entity = entity;
        
        self.deviceName = entity.deviceName.length ? entity.deviceName : @"";
        
        self.getSetConfigVM.getSettingConfigRequest.requestNeedActive = YES;
        
        [self reloadData];
        
       
        
    }];
    
    [[RACObserve(self.uploadConfigVM.uploadConfigRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        [AYProgressHud progressHudShowShortTimeMessage:@"修改配置成功"];
        self.popBlock();
    }];
    
    [[RACObserve(self.getSetConfigVM.getSettingConfigRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        NSDictionary *dict = [AYAnalysisXMLData analysisXMLWithSetConfig:self.getSetConfigVM.getSettingConfigRequest.output[@"setting_sip"]];
        
        if (self.uploadConfigVM.uploadConfigRequest.communityCode.length) {
            
            self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:@"/sys/gid" content:self.uploadConfigVM.uploadConfigRequest.communityCode];
            
        }
        
        self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:dict[@"t2"][@"uri"][@"uri"] content:self.uploadConfigVM.deviceInfoEntity.sipAccount];
        
        if (self.uploadConfigVM.deviceInfoEntity.sipPassword.length) {
            
            self.uploadConfigVM.uploadConfigRequest.configStr = [AYAnalysisXMLData xmlString:self.uploadConfigVM.uploadConfigRequest.configStr locString:dict[@"t3"][@"uri"][@"uri"] content:self.uploadConfigVM.deviceInfoEntity.sipPassword];
            
        }
        
    }];
    
}

- (void)getSysXML:(NSString *)sysXML isSelectMode:(BOOL)mode
{
    self.uploadConfigVM.uploadConfigRequest.configStr = sysXML;
    
    if (!mode) return;
    
    NSDictionary *dict = [AYAnalysisXMLData analysisXMLWithSetConfig11:sysXML];
    
    self.getConfigVM.getConfigEntity = [[GetConfigEntity alloc] initWithDictionary:dict error:nil];
    
    NSString *FW;
    
    if (self.getConfigVM.getConfigEntity.version.ui.length) {
        
        FW = [NSString stringWithFormat:@"FW:%@\nUI:%@", self.getConfigVM.getConfigEntity.version.fw, self.getConfigVM.getConfigEntity.version.ui];
        
    } else {
        
        FW = [NSString stringWithFormat:@"FW:%@", self.getConfigVM.getConfigEntity.version.fw];
        
    }
    
    if ([self.getConfigVM.getConfigEntity.panel.mode isEqualToString:@"0"]) {
        
        if (self.entity.buildingName.length) {
            NSMutableString *str = [NSMutableString stringWithString:self.entity.buildingName];
            self.entity.buildingName = [str stringByReplacingOccurrencesOfString:@"栋" withString:@""];
        }
       
        if (self.entity.unitName.length) {
            NSMutableString *strs = [NSMutableString stringWithString:self.entity.unitName];
            self.entity.unitName = [strs stringByReplacingOccurrencesOfString:@"单元" withString:@""];
        }
        
        self.values = [NSMutableArray arrayWithArray:@[self.entity.communityName.length ? self.entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"],self.entity.zoneName.length ? self.entity.zoneName : @"", self.entity.buildingName.length ? [NSString stringWithFormat:@"%@(%@栋)",self.entity.buildingName,self.entity.buildingName] : @"", self.entity.unitName.length ? [NSString stringWithFormat:@"%@(%@单元)",self.entity.unitName,self.entity.unitName] : @"", self.entity.deviceCode.length ? self.entity.deviceCode : @"", self.self.entity.deviceName.length ? self.entity.deviceName : @"", @"主卡/入, 副卡/出", self.entity.gpsAddress.length ? self.entity.gpsAddress : @"", @"", FW, @""]];
        
        self.uploadConfigVM.uploadConfigRequest.deviceType = @"M";
        
    } else {
        
        
        self.values = [NSMutableArray arrayWithArray:@[self.entity.communityName.length ? self.entity.communityName : [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"],self.entity.zoneName.length ? self.entity.zoneName : @"", self.entity.deviceCode.length ? self.entity.deviceCode : @"", self.entity.deviceName.length ? self.entity.deviceName : @"", @"主卡/入, 副卡/出", self.entity.gpsAddress.length ? self.entity.gpsAddress : @"", @"", FW, @""]];
        
        self.uploadConfigVM.uploadConfigRequest.deviceType = @"W";
        
    }
    
    [self reloadData];
}

- (UIView *)setupHeadView
{
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 0, 0, 60);
    headView.backgroundColor = [UIColor clearColor];
    
    UILabel *GIDLabel = [UILabel new];
    GIDLabel.text = @"GID : ";
    GIDLabel.textColor = TextMainBlackColor;
    [headView addSubview:GIDLabel];
    
    UILabel *UIDLabel = [UILabel new];
    UIDLabel.text = @"UID : ";
    UIDLabel.textColor = TextMainBlackColor;
    [headView addSubview:UIDLabel];
    
    UILabel *deviceNumLabel = [UILabel new];
    deviceNumLabel.font = [UIFont systemFontOfSize:15];
    deviceNumLabel.textColor = TextMainBlackColor;
    [headView addSubview:deviceNumLabel];
    self.deviceNumLabel = deviceNumLabel;
    
    UILabel *uidNumLabel = [UILabel new];
    uidNumLabel.font = [UIFont systemFontOfSize:15];
    uidNumLabel.textColor = TextMainBlackColor;
    [headView addSubview:uidNumLabel];
    self.uidNumLabel = uidNumLabel;
    
    [GIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY).offset(-10);
        make.left.equalTo(headView.mas_left).offset(16);
    }];
    
    [UIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY).offset(10);
        make.left.equalTo(headView.mas_left).offset(16);
    }];
    
    [deviceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(GIDLabel.mas_centerY);
        make.left.equalTo(GIDLabel.mas_right).offset(0);
    }];
    
    [uidNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(UIDLabel.mas_centerY);
        make.left.equalTo(UIDLabel.mas_right).offset(0);
    }];
    
    return headView;
    
}

- (UIView *)footViewConfirmButton
{
    UIView *background = [UIView new];
    background.frame = CGRectMake(0, 0, 0, 120);
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.backgroundColor = [UIColor whiteColor];
    [confirmButton setTitle:@"应 用" forState:UIControlStateNormal];
    [confirmButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [background addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(confirmButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(background.mas_top);
        make.bottom.equalTo(background.mas_bottom).offset(-70);
        make.left.equalTo(background.mas_left).offset(0);
        make.right.equalTo(background.mas_right).offset(0);
    }];
    
    return background;
    
}

- (void)confirmButtonMethod
{
    for (int i = 0; i < self.values.count; i ++) {
        
        NSString *value = self.values[i];
        
        if (!value.length) {
            
            NSArray *titles = self.values.count == 11 ? self.Titles : self.OtherTitles;
            
            if ([titles[i] isEqualToString:@"设备配置"] || [titles[i] isEqualToString:@"重启设备"] || [titles[i] isEqualToString:@"GPS"]|| [titles[i] isEqualToString:@"配置权限组"]|| [titles[i] isEqualToString:@"同步数据"]|| [titles[i] isEqualToString:@"备份数据"]|| [titles[i] isEqualToString:@"删除设备"]) {
            } else {
                
                [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"%@不能为空", titles[i]]];
                
                return;
            }
            
            
        }
        
    }
    
    self.uploadConfigVM.uploadConfigRequest.requestNeedActive = YES;
    
    EZLog(@"community---%@",self.uploadConfigVM.uploadConfigRequest.communityCode);
    
}

- (void)setDeviceNum:(NSString *)deviceNum
{
    _deviceNum = deviceNum;
    
    NSArray *devices = [deviceNum componentsSeparatedByString:@","];
    
    if (devices.count != 4) return;
    //获取设备配置信息
    self.getConfigVM.getConfigRequest.deviceNum = devices[0];
    
    self.getConfigVM.getConfigRequest.communityCode = devices[1];
    
    self.getConfigVM.getConfigRequest.requestNeedActive = YES;
    
    //重启设备
    self.uploadConfigVM.reBootRequest.deviceNum = devices[0];
    
    //修改配置信息
    self.uploadConfigVM.uploadConfigRequest.deviceNum = devices[0];
    
    self.uploadConfigVM.uploadConfigRequest.sipAccount = [LoginEntity shareManager].sipAccount;
    
    self.uploadConfigVM.uploadConfigRequest.timeStamp = devices[3];
    
    self.uploadConfigVM.uploadConfigRequest.defCommunityCode = devices[1];
    
    self.uidNumLabel.text = devices[0];
    self.deviceNumLabel.text = devices[1];

    self.uploadConfigVM.uploadConfigRequest.communityId =  [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
    
    self.uploadConfigVM.deviceInfoRequest.communityCode = devices[1];
    
    self.getSetConfigVM.getSettingConfigRequest.deviceNum = devices[0];
    
    if ([devices[1] isEqualToString:@"A1234567891011121314151617181920"]) return;
    
    self.uploadConfigVM.uploadConfigRequest.communityCode = devices[1];
    
}

@end
