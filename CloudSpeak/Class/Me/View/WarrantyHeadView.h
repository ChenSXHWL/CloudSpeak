//
//  WarrantyHeadView.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SxButton.h"

@class WarrantyHeadView;

@protocol WarrantyHeadViewDelegate <NSObject>

- (void)warrantyHeadView:(WarrantyHeadView *)warrantyHeadView selectRowAtLoc:(int)loc selctSection:(int)section;

@end

@interface WarrantyHeadView : UIView

@property (weak, nonatomic) id <WarrantyHeadViewDelegate> warrantyHeadViewDelegate;

@property (strong, nonatomic)UILabel *rightTextB;

@property (strong, nonatomic)UITextField *textFieldC;
@property (strong, nonatomic)UITextField *textFieldD;

@property (strong, nonatomic)UILabel *leftTextB;

@property (strong, nonatomic)SxButton *manageButtonA;
@property (strong, nonatomic)SxButton *manageButtonB;
@property (strong, nonatomic)SxButton *manageButtonC;

@property (strong, nonatomic)NSString *stings;

@property (strong, nonatomic)UIImageView *rightImageD;
@property (strong, nonatomic)UILabel *labelA;

@property (strong, nonatomic)UIView *viewD;
@property (strong, nonatomic)UIView *viewE;
@property (strong, nonatomic)UILabel *rightTextE;
@property (strong, nonatomic)UILabel *rightTextE2;

@end
