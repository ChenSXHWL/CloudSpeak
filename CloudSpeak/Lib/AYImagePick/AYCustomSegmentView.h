//
//  AYCustomSegmentView.h
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/15.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ISCustomSegmentViewSelectionStyle) {
    ISCustomSegmentViewSelectionStyleNone      = 0,
    ISCustomSegmentViewSelectionStyleSending       = 1,
    ISCustomSegmentViewSelectionStyleCompletion        = 2,
};

@class AYCustomSegmentView;

@protocol ISCustomSegmentViewDelegate <NSObject>

- (void)customSegmentView:(AYCustomSegmentView *)customSegmentView selectionStyle:(ISCustomSegmentViewSelectionStyle)style;

@end

@interface AYCustomSegmentView : UIView

+ (instancetype)setupCustomSegmentViewWithFrame:(CGRect)frame names:(NSArray *)names;

@property (weak, nonatomic) id <ISCustomSegmentViewDelegate> segmentViewDelegate;

- (void)changeButtonTitleColorFromTag:(int)tag;

@end
