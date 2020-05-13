//
//  AYCustomTView.h
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/15.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuperViewCompletionBlock)(void);

@interface AYCustomTView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SuperViewCompletionBlock block;

@end
