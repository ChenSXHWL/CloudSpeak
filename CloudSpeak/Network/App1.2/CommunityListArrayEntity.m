//
//  CommunityListArrayEntity.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CommunityListArrayEntity.h"
@implementation CommunityListArrayEntity

-(void)setHouseholdList:(NSArray *)householdList{
    
    _householdList = (NSArray *)[HouseList arrayOfModelsFromDictionaries:householdList error:nil];
    
}
@end
