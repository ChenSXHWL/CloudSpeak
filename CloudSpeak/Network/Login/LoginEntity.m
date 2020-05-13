//
//  LoginEntity.m
//  weiding
//
//  Created by TYToO on 14-5-16.
//  Copyright (c) 2014年 com.flygps. All rights reserved.
//

#import "LoginEntity.h"

@implementation LoginEntity

+ (LoginEntity *)shareManager
{
    return [LoginManage sharedInstance].loginEntity;
}

//- (void)modelOfDictionary
//{
//    if (!_communityList) return;
//    
//    NSMutableArray *array =[_communityList mutableCopy];
//    NSString *communityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"communityName"];
//    for (int i = 0; i<array.count; i++) {
//        NSDictionary *dic = array[i];
//        if ([dic[@"communityName"] isEqualToString:communityName]) {
//            [array removeObject:dic];
//            [array insertObject:dic atIndex:0];
//        }
//    }
//    
//    
//    _communityList = (NSArray *)[CommunityList arrayOfModelsFromDictionaries:_communityList error:nil];
//    
//}


@end
