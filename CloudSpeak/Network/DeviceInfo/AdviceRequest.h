//
//  AdviceRequest.h
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/28.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "RequestConfig.h"

@interface AdviceRequest : RequestConfig

@property (copy, nonatomic) NSString *imgUrl;//令牌

@property (copy, nonatomic) NSString *content;//反馈建议内容

@end
