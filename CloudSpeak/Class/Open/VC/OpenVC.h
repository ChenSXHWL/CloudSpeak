//
//  OpenVC.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/8.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "NavigationBarColorVC.h"

typedef void(^RemoveDictInfoBlock)(void);

@interface OpenVC : NavigationBarColorVC

@property (copy, nonatomic) NSString *callId;

@property (copy, nonatomic) NSString *buildingCode;
@property (copy, nonatomic) NSString *unitCode;
@property (copy, nonatomic) NSString *roomNum;

@property (copy, nonatomic) NSString *imageUrl;

@end
