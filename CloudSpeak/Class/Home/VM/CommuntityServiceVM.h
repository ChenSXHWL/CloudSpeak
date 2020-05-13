//
//  CommuntityServiceVM.h
//  CloudSpeak
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "RepairTypeListRequest.h"
#import "ObtainComplaintsTypeRequest.h"

@interface CommuntityServiceVM : SceneModelConfig

@property (strong, nonatomic) ObtainComplaintsTypeRequest *obtainComplaintsTypeRequest;

@property (strong, nonatomic) NSArray *complainTypeList;

@property (strong, nonatomic) NSArray *complainStatusList;

@property (strong, nonatomic) RepairTypeListRequest *repairTypeListRequest;

@property (strong, nonatomic) NSArray *repairTypeList;

@property (strong, nonatomic) NSArray *repairStatusList;

@end
