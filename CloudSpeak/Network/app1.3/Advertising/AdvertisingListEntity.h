//
//  AdvertisingListEntity.h
//  CloudSpeak
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface AdvertisingListEntity : EntityConfig

@property (strong, nonatomic)NSString * groupName;//广告分组名称

@property (strong, nonatomic)NSString * groupId;//广告分组ID

@property (strong, nonatomic)NSString * fileName;//广告文件名称

@property (strong, nonatomic)NSString * storeFileName;//广告文件url

@property (strong, nonatomic)NSString * domain;//七牛云域名

@property (strong, nonatomic)NSString * title;//广告名称

@property (strong, nonatomic)NSString * textAdvertisement;//广告文本

@property (strong, nonatomic)NSString * startDate;//广告开始日期

@property (strong, nonatomic)NSString * endDate;//广告结束日期

@property (strong, nonatomic)NSString * startTime;//广告开始时间

@property (strong, nonatomic)NSString * playTime;//循环播放时长:秒

@property (strong, nonatomic)NSString * priority;//优先级

@property (strong, nonatomic)NSString * loopTime;//循环播放次数

@property (strong, nonatomic)NSString * advertisementType;//设备组类型名称

@property (strong, nonatomic)NSString * id;//广告id

@end
