//
//  ComplaintsHeadView.h
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComplaintsHeadView;

@protocol ComplaintsHeadViewDelegate <NSObject>

- (void)complaintsHeadView:(ComplaintsHeadView *)complaintsHeadView selectRowAtLoc:(int)loc;

@end
@interface ComplaintsHeadView : UIView

@property (strong, nonatomic)UIView *headView;

@property (weak, nonatomic) id <ComplaintsHeadViewDelegate> complaintsHeadViewDelegate;


-(void)upHeadView;
-(void)downHeadView;

@end
