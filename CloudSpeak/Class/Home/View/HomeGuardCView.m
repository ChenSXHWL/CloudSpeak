//
//  HomeGuardCView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeGuardCView.h"
#import "HomeGuardCVCell.h"
#import "CallOpenVM.h"

@interface HomeGuardCView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) CallOpenVM *callOpenVM;

@end

@implementation HomeGuardCView

/**
 *  创建AYPhotoCollectionView对象
 */
+ (instancetype)setupHomeGuardCView
{
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    HomeGuardCView *homeGuardCView = [[self alloc]initWithFrame:CGRectNull collectionViewLayout:layout];
    
    return homeGuardCView;
}

/**
 *  初始化实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        //UICollectionView的数据源代理方法
        self.dataSource = self;
        
        self.delegate = self;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.scrollEnabled = YES;
        
        [self setupVM];
        
        [self setupRAC];
        
    }
    
    return self;
}

#pragma mark  UICollectionViewDataSource（数据元代理）

-(NSInteger)numberOfSectionsInCollectionView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.callOpenVM.getMyKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeGuardCVCell *cell = [HomeGuardCVCell setupHomeGuardCVCell:collectionView indexPath:indexPath];
    
    cell.getMyKeyEntity = self.callOpenVM.getMyKeys[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GetMyKeyEntity *getMyKeyEntity = self.callOpenVM.getMyKeys[indexPath.row];
    
    if ([getMyKeyEntity.onlineStatus isEqualToString:@"0"]) return [AYProgressHud progressHudShowShortTimeMessage:@"该设备不在线"];
    
    self.guardBlock(self.callOpenVM.getMyKeys[indexPath.row]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.7, [UIScreen mainScreen].bounds.size.width / 3.7);
    
}

- (void)setupVM
{
    self.callOpenVM = [CallOpenVM SceneModel];
    
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.callOpenVM, getMyKeys) filter:^BOOL(id value) {
        return value != nil;
    }] subscribeNext:^(id x) {
        @strongify(self);
        
        [self reloadData];
    }];
}

@end
