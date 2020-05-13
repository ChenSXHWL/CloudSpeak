//
//  MeInfoTVFootView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeInfoTVFootView.h"
#import "AYAlertViewController.h"
#import "ALActionSheetView.h"

@interface MeInfoTVFootView ()

@property (strong, nonatomic) UILabel *houseLabel;

@property (strong, nonatomic) UIButton *indicatorButton;

@property (strong, nonatomic) UILabel *houseAddressLabel;

@property (strong, nonatomic) ALActionSheetView *sheet;

@end

@implementation MeInfoTVFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *houseLabel = [UILabel new];
        houseLabel.textColor = TextDeepGaryColor;
        houseLabel.text = @"小区";
        [self addSubview:houseLabel];
        self.houseLabel = houseLabel;
        
        UIButton *indicatorButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [indicatorButton setImage:[UIImage imageNamed:@"home_enter"] forState:UIControlStateNormal];
        indicatorButton.tintColor = TextMainBlackColor;
        [self addSubview:indicatorButton];
        self.indicatorButton = indicatorButton;
        
        UILabel *houseAddressLabel = [UILabel new];
        houseAddressLabel.textColor = TextMainBlackColor;
        houseAddressLabel.text = @"A区－2栋－B单元－1001";
        [self addSubview:houseAddressLabel];
        self.houseAddressLabel = houseAddressLabel;
        
        @weakify(self);
        [self whenTapped:^{
            @strongify(self);
            
            NSMutableArray *array = [NSMutableArray array];
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<self.userInfoEntity.communityList.count; i++) {
                CommunityListArrayEntity *model = self.userInfoEntity.communityList[i];
                [arr insertObjects:model.householdList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, model.householdList.count)]];
;//[arr addObject:model.householdList];
            }
            for (HouseList *list in arr) {
                
                if (list.communityName.length) {
                    
                    [array addObject:[NSString stringWithFormat:@"%@-%@-%@", list.buildingName, list.unitName, list.roomNum]];
                    
                } else {
                    
                    [array addObject:@""];
                }
                
            }
            
            @weakify(self);
            _sheet = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:array handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
                @strongify(self);
                
                if (buttonIndex < 0) return ;
                
                self.houseAddressLabel.text = array[buttonIndex];
                
            }];
            
            [_sheet show];
            
            
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.houseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.indicatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.houseAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.indicatorButton.mas_centerY);
        make.right.equalTo(self.indicatorButton.mas_left).offset(-8);
    }];
    
}

- (void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity
{
    _userInfoEntity = userInfoEntity;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<_userInfoEntity.communityList.count; i++) {
        CommunityListArrayEntity *model = _userInfoEntity.communityList[i];
        [arr insertObjects:model.householdList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, model.householdList.count)]];
;//[arr addObject:model.householdList];
    }
    if (arr) {
        
        HouseList *list = arr[0];
        
        self.userInteractionEnabled = YES;
        
        self.indicatorButton.hidden = NO;
        
        self.houseAddressLabel.text = [NSString stringWithFormat:@"%@-%@-%@", list.buildingName, list.unitName, list.roomNum];
        
    } else {
        
        self.userInteractionEnabled = NO;
        
        self.indicatorButton.hidden = YES;
        
        self.houseAddressLabel.text = @"";
        
    }
}

@end
