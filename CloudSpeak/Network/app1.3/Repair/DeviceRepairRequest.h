//
//  DeviceRepairRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface DeviceRepairRequest : RequestConfig

@property (copy, nonatomic) NSString *communityId;//小区

@property (copy, nonatomic) NSString *appUserId;//app用户id

@property (copy, nonatomic) NSString *deviceId;//设备id

@property (copy, nonatomic) NSString *reportProblem;//报修原因

@property (copy, nonatomic) NSString *reportImgUrl;//多图url，逗号隔开

@property (copy, nonatomic) NSString *startVisitDate;//上门开始时间

@property (copy, nonatomic) NSString *endVisitDate;//上门结束时间

@property (copy, nonatomic) NSString *location;//故障地址

@property (copy, nonatomic) NSString *repairType;//报修类型：1:设备报障；2:室内维修；3:维修报障;4:电梯报障;5:公共维修;6:安保服务;7:清洁绿化;8:卫生保洁;9:服务咨询;10:其他;

@property (copy, nonatomic) NSString *roomId;//房间id

@property (copy, nonatomic) NSString *unitId;//单元ID

@property (copy, nonatomic) NSString *buildingId;//楼栋ID

@end

