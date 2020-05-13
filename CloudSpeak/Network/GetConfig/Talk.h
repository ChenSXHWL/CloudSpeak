//
//  Talk.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface Talk : EntityConfig

@property (copy, nonatomic) NSString *unit;

@property (copy, nonatomic) NSString *timeout;

@property (copy, nonatomic) NSString *auto_answer;

@property (copy, nonatomic) NSString *family;

@property (copy, nonatomic) NSString *server;

@property (copy, nonatomic) NSString *building;

@property (copy, nonatomic) NSString *mode;

@property (copy, nonatomic) NSString *sync;

@property (copy, nonatomic) NSString *floor;

@property (copy, nonatomic) NSString *passwd;

@property (copy, nonatomic) NSString *auto_msg;

@property (copy, nonatomic) NSString *dcode;

@end
