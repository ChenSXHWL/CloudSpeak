//
//  DeviceTestTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceTestTView.h"
#import "DeviceTestTVHeadView.h"
#import "GetTestRoomNumVM.h"
#import "AYAnalysisXMLData.h"

#define TestTitle @[@"对讲通话",@"一键开门",@"一键监视",@"电梯控制"]

@interface DeviceTestTView ()

@property (strong, nonatomic) GetTestRoomNumVM *getTestRoomNumVM;

@property (strong, nonatomic) DeviceTestTVHeadView *deviceTestTVHeadView;

@property (strong, nonatomic) NSMutableArray *values;

@end

@implementation DeviceTestTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.rowHeight = SCREEN_WIDTH / 6;
        
        self.scrollEnabled = NO;
        
        self.values = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
        
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        DeviceTestTVHeadView *deviceTestTVHeadView = [DeviceTestTVHeadView new];
        
        deviceTestTVHeadView.frame = CGRectMake(0, 0, 0, SCREEN_WIDTH / 2);
        
        self.tableHeaderView = deviceTestTVHeadView;
        
        self.deviceTestTVHeadView = deviceTestTVHeadView;
        
        self.getTestRoomNumVM = [GetTestRoomNumVM SceneModel];
        
        [self setupRAC];
        
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.textColor = TextMainBlackColor;
    
    cell.textLabel.text = TestTitle[indexPath.row];
    
    cell.detailTextLabel.text = self.values[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSArray *sips = [self.sipContent componentsSeparatedByString:@","];
    
//    if (!sips.le) return;
    
    if (indexPath.row == 0) return;
    
    if (indexPath.row == 1) {
        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipContent unLockXML:[AYAnalysisXMLData appendXML]];
//        [[AYCloudSpeakApi cloudSpeakApi] unLock];
    } else if(indexPath.row ==2){
        self.deviceTestVCBlock(self.sipContent);
    }else{
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.getTestRoomNumVM.getTestRoomNumRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        NSString *roomNum = (NSString *)self.getTestRoomNumVM.getTestRoomNumRequest.output[@"roomNum"];
        
        self.deviceTestTVHeadView.roomNum = roomNum;
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        NSDictionary *dict = x.userInfo;
        
        NSString *unLock = dict[@"event_url"];
        
        NSString *resultCode = dict[@"resultCode"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([unLock isEqualToString:@"/talk/unlock"]) {
                
                if (resultCode.intValue == 200) {
                    
                    self.values = [NSMutableArray arrayWithArray:@[self.talkTime.length ? self.talkTime : @"", @"成功", @""]];
                    
                } else {
                    
                    self.values = [NSMutableArray arrayWithArray:@[self.talkTime.length ? self.talkTime : @"", @"失败", @""]];

                }
                
                [self reloadData];
                
            }
            
            
        });
        
    }];
    
}

- (void)setSipContent:(NSString *)sipContent
{
    _sipContent = sipContent;
    
}

- (void)setTalkTime:(NSString *)talkTime
{
    _talkTime = talkTime;
    
    self.values = [NSMutableArray arrayWithArray:@[talkTime, @"",@""]];
    
    [self reloadData];
}

@end
