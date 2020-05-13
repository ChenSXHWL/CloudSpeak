//
//  HomeGuardCVCell.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMyKeyEntity.h"

@interface HomeGuardCVCell : UICollectionViewCell

+ (instancetype)setupHomeGuardCVCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) GetMyKeyEntity *getMyKeyEntity;

@end
