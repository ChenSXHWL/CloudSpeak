//
//  SetConfigTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"
#import "GetConfigEntity.h"

@protocol CSSetConfigTViewDelegate <NSObject>

- (void)sendXMLString:(NSString *)xmlString isSelectMode:(BOOL)mode;

@end

@interface SetConfigTView : AYCustomTView

@property (strong, nonatomic) GetConfigEntity *getConfigEntity;

@property (copy, nonatomic) NSString *sysXML;

@property (copy, nonatomic) NSDictionary *getDiviceInfo;

@property (weak, nonatomic) id <CSSetConfigTViewDelegate> setConfigDelegate;

- (void)saveXMLInfo;

@end
