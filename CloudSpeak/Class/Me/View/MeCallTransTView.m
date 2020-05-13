//
//  MeCallTransTView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeCallTransTView.h"
#import "CallForwardingVM.h"

@interface MeCallTransTView ()

@property (strong, nonatomic) UITextField *callFailTextField;

@property (strong, nonatomic) CallForwardingVM *callForwardingVM;

@end

@implementation MeCallTransTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    
    if (self) {
        
        self.scrollEnabled = NO;
        
        [self setupVM];
        
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        UITextField *textfield = [UITextField new];
        
        textfield.placeholder = @[@"请输入手机号",@"请输入手机号"][indexPath.section];
        
        textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [cell.contentView addSubview:textfield];
        
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(16);
            make.right.equalTo(cell.contentView.mas_right).offset(-16);
            make.top.bottom.equalTo(cell.contentView);
        }];
        if ([LoginEntity shareManager].sipMobile.length>0) {
            textfield.text = [LoginEntity shareManager].sipMobile;
        }
        self.callFailTextField = textfield;

        
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(16, 12, SCREEN_WIDTH-32, 12)];
    title.text = @"当来电呼叫失败时，设备可转移手机号";
    title.textColor = TextMainBlackColor;
    title.font = [UIFont systemFontOfSize:12];
    [headView addSubview:title];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

- (void)saveTransPhone
{
    self.callForwardingVM.callForwardingRequest.sipMobile = self.callFailTextField.text;
    
    self.callForwardingVM.callForwardingRequest.requestNeedActive = YES;
}

- (void)setupVM
{
    self.callForwardingVM = [CallForwardingVM SceneModel];
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.callForwardingVM.callForwardingRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        [LoginEntity shareManager].sipMobile = self.callForwardingVM.callForwardingRequest.sipMobile;
        
        
        self.callTransBlock();
        
    }];
}

@end
