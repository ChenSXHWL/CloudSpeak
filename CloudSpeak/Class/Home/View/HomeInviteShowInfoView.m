//
//  HomeInviteShowInfoView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteShowInfoView.h"
#import "HomeInviteShareButton.h"

//UM
#import <UMSocialCore/UMSocialCore.h>
@interface HomeInviteShowInfoView ()

@property (strong, nonatomic) UIView *inviteWhiteBackgroundView;

@property (strong, nonatomic) UIImageView *closeImageView;

@property (strong, nonatomic) UIView *singleView;

@property (strong, nonatomic) HomeInviteShareButton *qqButton;

@property (strong, nonatomic) HomeInviteShareButton *wxButton;

@property (strong, nonatomic) HomeInviteShareButton *dxButton;

@property (strong, nonatomic) HomeInviteShareButton *fzButton;

@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UILabel *codeLabel;


@property (strong, nonatomic) UILabel *doorLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation HomeInviteShowInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
        [self layoutCloseView];
        
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = RGBA(100, 100, 100, .5);
    
    UIView *inviteWhiteBackgroundView = [[UIView alloc] init];
    inviteWhiteBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:inviteWhiteBackgroundView];
    self.inviteWhiteBackgroundView = inviteWhiteBackgroundView;
    
    UIView *singleView = [UIView new];
    singleView.backgroundColor = TextShallowGaryColor;
    [self.inviteWhiteBackgroundView addSubview:singleView];
    self.singleView = singleView;
    
    HomeInviteShareButton *qqButton = [HomeInviteShareButton setupHomeInviteShareButtonWithImageString:@"visitor_qq" title:@"QQ"];
    [self.inviteWhiteBackgroundView addSubview:qqButton];
    qqButton.tag = 101;
    [qqButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    self.qqButton = qqButton;
    HomeInviteShareButton *wxButton = [HomeInviteShareButton setupHomeInviteShareButtonWithImageString:@"visitor_wechat" title:@"微信"];
    wxButton.tag = 102;
    [self.inviteWhiteBackgroundView addSubview:wxButton];
    [wxButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    self.wxButton = wxButton;

    HomeInviteShareButton *dxButton = [HomeInviteShareButton setupHomeInviteShareButtonWithImageString:@"visitor_sms" title:@"短信"];
    dxButton.tag = 103;
    [self.inviteWhiteBackgroundView addSubview:dxButton];
    [dxButton addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];

    self.dxButton = dxButton;
    
    HomeInviteShareButton *fzButton = [HomeInviteShareButton setupHomeInviteShareButtonWithImageString:@"visitor_copy" title:@"复制"];
    [self.inviteWhiteBackgroundView addSubview:fzButton];
    [fzButton addTarget:self action:@selector(copyCode) forControlEvents:UIControlEventTouchUpInside];
    self.fzButton = fzButton;
    
    UIView *titleView = [UIView new];
    titleView.backgroundColor = [UIColor clearColor];
    [self.inviteWhiteBackgroundView addSubview:titleView];
    self.titleView = titleView;
    
    UILabel *codeLabel = [UILabel new];
    codeLabel.text = @"0000";
    codeLabel.font = [UIFont systemFontOfSize:60];
    codeLabel.textColor = TextBlueColor;
    [self.titleView addSubview:codeLabel];
    self.codeLabel = codeLabel;
    
    UILabel *doorLabel = [UILabel new];
    doorLabel.text = @"A区 B栋-大门";
    doorLabel.font = [UIFont systemFontOfSize:17];
    doorLabel.textColor = DoorGaryColor;
    [self.titleView addSubview:doorLabel];
    self.doorLabel = doorLabel;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.text = @"有效期至2017-03-03 02:12:05";
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = TextDeepGaryColor;
    [self.titleView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIImageView *closeImageView = [UIImageView new];
    closeImageView.userInteractionEnabled = YES;
    closeImageView.image = [UIImage imageNamed:@"visitor_delete"];
    closeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.inviteWhiteBackgroundView addSubview:closeImageView];
    self.closeImageView = closeImageView;
    
}

- (void)layoutCloseView
{
    @weakify(self);
    [self.closeImageView whenTapped:^{
        @strongify(self);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo([UIApplication sharedApplication].keyWindow);
                make.top.equalTo([UIApplication sharedApplication].keyWindow.mas_bottom);
                make.height.mas_equalTo(SCREEN_HEIGHT);
            }];
            
            [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
            
        }];
        
    }];
}

- (void)layoutOpenView
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.inviteWhiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.4);
    }];

    [self.singleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inviteWhiteBackgroundView.mas_left).offset(24);
        make.right.equalTo(self.inviteWhiteBackgroundView.mas_right).offset(-24);
        make.height.mas_equalTo(0.3);
        make.centerY.equalTo(self.inviteWhiteBackgroundView.mas_centerY).offset(30);
    }];

    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.top.equalTo(self.singleView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
    }];
    
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.top.equalTo(self.singleView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.qqButton.mas_right);
    }];
    
    [self.dxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.top.equalTo(self.singleView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.wxButton.mas_right);
    }];
    
    [self.fzButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.25);
        make.top.equalTo(self.singleView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.dxButton.mas_right);
    }];

    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.inviteWhiteBackgroundView);
        make.bottom.equalTo(self.singleView.mas_top);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.titleView);
    }];

    [self.doorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeLabel.mas_top).offset(-10);
        make.centerX.equalTo(self.codeLabel.mas_centerX);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.codeLabel.mas_centerX);
    }];
    
    [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top).offset(16);
        make.right.equalTo(self.titleView.mas_right).offset(-16);
        make.width.height.mas_equalTo(20);
    }];
}

- (void)sendCode:(UIButton *)sender
{
    
    NSString *string = self.codeLabel.text;

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"    %@    ", string];
    UMSocialPlatformType Type = UMSocialPlatformType_QQ;
    switch (sender.tag) {
        case 101:
            Type = UMSocialPlatformType_QQ;
            break;
        case 102:
            Type = UMSocialPlatformType_WechatSession;
            break;
        case 103:
            Type = UMSocialPlatformType_Sms;
            break;
            
            
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:Type messageObject:messageObject currentViewController:[URLNavigation navigation].currentViewController completion:^(id data, NSError *error) {
        if (error) {
            NSString *result;

            switch (error.code) {
                case UMSocialPlatformErrorType_Unknow:
                    result = @"未知错误";
                    break;
                case UMSocialPlatformErrorType_NotSupport:
                    result = @"不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持";
                    break;
                case UMSocialPlatformErrorType_AuthorizeFailed:
                    result = @"授权失败";
                    break;
                case UMSocialPlatformErrorType_ShareFailed:
                    result = @"分享失败";
                    break;
                case UMSocialPlatformErrorType_RequestForUserProfileFailed:
                    result = @"请求用户信息失败";
                    break;
                case UMSocialPlatformErrorType_ShareDataNil:
                    result = @"分享内容为空";
                    break;
                case UMSocialPlatformErrorType_ShareDataTypeIllegal:
                    result = @"分享内容不支持";
                    break;
                case UMSocialPlatformErrorType_CheckUrlSchemaFail:
                    result = @"schemaurl fail";
                    break;
                case UMSocialPlatformErrorType_NotInstall:
                    result = @"应用未安装";
                    break;
                case UMSocialPlatformErrorType_Cancel:
                    result = @"您已取消分享";
                    break;
                case UMSocialPlatformErrorType_NotNetWork:
                    result = @"网络异常";
                    break;
                case UMSocialPlatformErrorType_SourceError:
                    result = @"第三方错误";
                    break;
                case UMSocialPlatformErrorType_ProtocolNotOverride:
                    result = @"对应的  UMSocialPlatformProvider的方法没有实现";
                    break;
                default:
                    break;
            }
            [AYProgressHud progressHudShowShortTimeMessage:result];

        }else{
            [AYProgressHud progressHudShowShortTimeMessage:@"分享成功"];
        }
    }];

}

- (void)copyCode
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.codeLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [AYProgressHud progressHudShowShortTimeMessage:@"复制失败"];
    } else {
        [AYProgressHud progressHudShowShortTimeMessage:@"已复制"];
    }
}

- (void)setInviteCodeEntity:(InviteCodeEntity *)inviteCodeEntity
{
    _inviteCodeEntity = inviteCodeEntity;
    
    self.codeLabel.text = inviteCodeEntity.inviteCode;
    if (inviteCodeEntity.endDate==nil) {
        self.timeLabel.text = @"高级模式";
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"有效期至%@",inviteCodeEntity.endDate];
    }
}

- (void)setInviteCodeString:(NSString *)inviteCodeString
{
    _inviteCodeString = inviteCodeString;
    
    self.doorLabel.text = inviteCodeString;
}

@end
