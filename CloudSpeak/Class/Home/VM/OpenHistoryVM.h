//
//  OpenHistoryVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "OpenHistoryRequest.h"
#import "OpenHistoryEntity.h"

@interface OpenHistoryVM : SceneModelConfig

@property (strong, nonatomic) OpenHistoryRequest *openHistoryRequest;

@property (strong, nonatomic) NSMutableArray *openHistorys;

@end
