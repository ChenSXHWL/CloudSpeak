//
//  ComplaintsVM.h
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "ReportComplaintsRequest.h"
#import "HistoryComplaintsRequest.h"
#import "HistoryComplaintsEntity.h"
@interface ComplaintsVM : SceneModelConfig

@property (strong, nonatomic)ReportComplaintsRequest *reportComplaintsRequest;

@property (strong, nonatomic)HistoryComplaintsRequest *historyComplaintsRequest;

@property (strong, nonatomic) NSArray *complaintList;

@property (strong, nonatomic) NSString *report;

@end
