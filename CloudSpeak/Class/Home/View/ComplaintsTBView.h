//
//  ComplaintsTBView.h
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"

@class ComplaintsTBView;

@protocol ComplaintsTBViewDelegate <NSObject>

- (void)complaintsTBView:(ComplaintsTBView *)complaintsTBView selectRowAtLoc:(int)loc;

@end

@interface ComplaintsTBView : AYCustomTView

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSArray *complainTypeList;
@property (strong, nonatomic) NSArray *complainStatusList;

@property (weak, nonatomic) id <ComplaintsTBViewDelegate> advertTableViewDelegate;

@end
