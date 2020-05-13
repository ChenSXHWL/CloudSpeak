//
//  AdvertHeadView.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertHeadView;

@protocol AdvertHeadViewDelegate <NSObject>

- (void)advertHeadView:(AdvertHeadView *)advertHeadView selectRowAtLoc:(int)loc;

@end
@interface AdvertHeadView : UIView

@property (strong, nonatomic)UIView *headView;

@property (weak, nonatomic) id <AdvertHeadViewDelegate> advertHeadViewDelegate;


-(void)upHeadView;
-(void)downHeadView;
@end
