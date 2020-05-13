//
//  HomeElevatorListCell.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeElevatorListCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *guardlabel;

@property (strong, nonatomic) UIImageView *guardImageView;

+ (instancetype)setupHomeElevatorListCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
