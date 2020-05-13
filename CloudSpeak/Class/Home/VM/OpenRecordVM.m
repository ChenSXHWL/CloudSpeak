//
//  OpenRecordVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenRecordVM.h"

@interface OpenRecordVM () <ActionDelegate>

@end

@implementation OpenRecordVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.openRecordRequest = [OpenRecordRequest Request];
    
    self.openRecordRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
    
    @weakify(self);
    self.openRecordRequest.requestInActiveBlock = ^ {
        @strongify(self);
        
        [self SEND_IQ_ACTION:self.openRecordRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.openRecordRequest showInView:nil detailString:@""];
        
    };
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        NSDictionary *dict = msg.output[@"openRecord"];
        
        NSMutableArray *keys = [NSMutableArray array];
        
        NSMutableArray *values = [NSMutableArray array];
        
        for (NSString *time in dict.allKeys) {
            
            [keys addObject:time];
            
        }
        
        NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            return [obj2 compare:obj1 options:NSNumericSearch];
        }];
        
        
        for (NSString *appendString in sortedArray) {
            
            [values addObject:[OpenRecordEntity arrayOfModelsFromDictionaries:[dict objectForKey:appendString] error:nil]];
            
        }
        
        if (self.openRecordRequest.pageIndex.integerValue == 0) {
            
            self.openRecords = values;
            
        } else {
            
            NSMutableArray *hahahas = [NSMutableArray array];
            
            OpenRecordEntity *entityOne = self.openRecords[self.openRecords.count - 1][0];
            
            OpenRecordEntity *entityTwo;
            
            if (values.count) {
                
                entityTwo = values[0][0];
                
            }
            
            if ([entityOne.openDay isEqualToString:entityTwo.openDay]) {
                
                [hahahas addObjectsFromArray:self.openRecords[self.openRecords.count - 1]];
                
                if (values) {
                    
                    [hahahas addObjectsFromArray:values[0]];
                    
                    [values removeObjectAtIndex:0];
                    
                }
                
                [self.openRecords removeLastObject];
                
                [self.openRecords addObject:hahahas];
                
                if (values.count) {
                    
                    [self.openRecords addObjectsFromArray:values];
                    
                }
                
                self.openRecords = self.openRecords;
                
                
            } else {
                
                [self.openRecords addObjectsFromArray:values];
                
                self.openRecords = self.openRecords;
            
            }
            
            
        }
        
    }
    
    
}

@end
