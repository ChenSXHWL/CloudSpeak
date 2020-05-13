//
//  Lan.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface Lan : EntityConfig

@property (copy, nonatomic) NSString *dhcp;

@property (copy, nonatomic) NSString *mask;

@property (copy, nonatomic) NSString *dns;

@property (copy, nonatomic) NSString *ip;

@property (copy, nonatomic) NSString *gateway;

@end
