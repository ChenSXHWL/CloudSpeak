//
//  EnviroumentChange.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/9/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EnviroumentChange;

@protocol CSEnviroumentChangeDelegate <NSObject>

- (void)enviroumentChange:(EnviroumentChange *)enviroumentChange selectSipServiceWithLoc:(int)loc;

- (void)enviroumentChange:(EnviroumentChange *)enviroumentChange selectUrlServiceWithLoc:(int)loc;

@end

@interface EnviroumentChange : UIView

+ (instancetype)setupEnviroumentChange;

@property (weak, nonatomic) id <CSEnviroumentChangeDelegate> delegate;

@property (copy, nonatomic) NSString *url;

@end
