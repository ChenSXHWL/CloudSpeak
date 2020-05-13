//
//  CallForwardingVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "CallForwardingRequest.h"

@interface CallForwardingVM : SceneModelConfig

@property (strong, nonatomic) CallForwardingRequest *callForwardingRequest;

@end
