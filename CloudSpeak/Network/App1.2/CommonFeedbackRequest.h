//
//  CommonFeedbackRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CommonFeedbackRequest : RequestConfig

@property (copy, nonatomic) NSString *content;//反馈内容

@property (copy, nonatomic) NSString *imgUrl;//反馈图片，多图逗号隔开

@end
