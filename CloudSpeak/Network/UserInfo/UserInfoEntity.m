//
//  UserInfoEntity.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UserInfoEntity.h"

@implementation UserInfoEntity

-(void)setCommunityList:(NSArray *)communityList
{
    
    _communityList = (NSArray *)[CommunityListArrayEntity arrayOfModelsFromDictionaries:communityList error:nil];
    
}

@end
