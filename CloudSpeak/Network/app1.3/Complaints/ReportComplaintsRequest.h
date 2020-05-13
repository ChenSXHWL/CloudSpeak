//
//  ReportComplaintsRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface ReportComplaintsRequest : RequestConfig

@property (strong, nonatomic)NSString * communityId;

@property (strong, nonatomic)NSString * appUserId;

@property (strong, nonatomic)NSString * buildingId;//楼栋id

@property (strong, nonatomic)NSString * unitId;//单元i

@property (strong, nonatomic)NSString * roomId;//房间id

@property (strong, nonatomic)NSString * complainType;//投诉类型

@property (strong, nonatomic)NSString * content;//投诉内容

@property (strong, nonatomic)NSString * imgUrlList;//图片地址，多图逗号隔开
@end
