//
//  SetDoorView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetDoorViewBlock)(NSString *outString, NSString *inString);

@interface SetDoorView : UIView

+ (instancetype)setupSetDoorView:(NSString *)title;

@property (strong, nonatomic) SetDoorViewBlock setDoorViewBlock;

@end
