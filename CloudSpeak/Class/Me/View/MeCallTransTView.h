//
//  MeCallTransTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"

typedef void(^CallTransCompletionBlock)(void);

@interface MeCallTransTView : AYCustomTView

@property (strong, nonatomic) CallTransCompletionBlock callTransBlock;

- (void)saveTransPhone;

@end
