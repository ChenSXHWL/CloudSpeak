//
//  ConfigDevGroupVM.h
//  CloudSpeak
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "ObtainDevGroupRequest.h"
#import "EditorDevGroupRequest.h"
#import "ObtainDevGroupEntity.h"
@interface ConfigDevGroupVM : SceneModelConfig
@property (strong, nonatomic)ObtainDevGroupRequest *obtainDevGroupRequest;

@property (strong, nonatomic)EditorDevGroupRequest *editorDevGroupRequest;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSString *isEditor;

@end
