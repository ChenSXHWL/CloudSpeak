//
//  AdvertTableView.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"
@class AdvertTableView;

@protocol AdvertTableViewDelegate <NSObject>

- (void)advertTableView:(AdvertTableView *)advertTableView selectRowAtLoc:(int)loc;

@end

@interface AdvertTableView : AYCustomTView

@property (strong, nonatomic) NSArray *dataArray;

@property (weak, nonatomic) id <AdvertTableViewDelegate> advertTableViewDelegate;

@end
