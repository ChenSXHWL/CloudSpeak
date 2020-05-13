//
//  MeTVHeadView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeTVHeadView.h"

@interface MeTVHeadView ()

@property (strong, nonatomic) UIImageView *headImageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *phoneLabel;

@end

@implementation MeTVHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *headImageView = [UIImageView new];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.clipsToBounds = YES;
        headImageView.layer.cornerRadius = SCREEN_WIDTH / 8 - 10;
        [self addSubview:headImageView];
        headImageView.image = [UIImage imageNamed:@"me_head"];
        self.headImageView = headImageView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = TextMainBlackColor;
        titleLabel.text = @"";
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *phoneLabel = [UILabel new];
        phoneLabel.textColor = TextDeepGaryColor;
        phoneLabel.text = @"";
        [self addSubview:phoneLabel];
        self.phoneLabel = phoneLabel;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left).offset(16);
        make.width.equalTo(self.headImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(16);
        make.top.equalTo(self.headImageView.mas_top).offset(8);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
}

- (void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity
{
    _userInfoEntity = userInfoEntity;
    
    self.titleLabel.text = userInfoEntity.nickName.length ? userInfoEntity.nickName : @"";
    
    self.phoneLabel.text = userInfoEntity.loginName.length ? userInfoEntity.loginName : @"";
    
    [self.headImageView imageShwoActivityIndicatorWithUrlString:[NSString stringWithFormat:@"%@%@", userInfoEntity.domain, userInfoEntity.imgUrl] placeHolder:@"me_head"];
    
}

@end
