//
//  OpenRecordVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "OpenRecordRequest.h"
#import "OpenRecordEntity.h"

@interface OpenRecordVM : SceneModelConfig

@property (strong, nonatomic) OpenRecordRequest *openRecordRequest;

@property (strong, nonatomic) NSMutableArray *openRecords;

@end
