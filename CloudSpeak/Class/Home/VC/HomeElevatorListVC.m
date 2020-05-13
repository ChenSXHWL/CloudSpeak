//
//  HomeElevatorListVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeElevatorListVC.h"
#import "HomeElevatorListCell.h"
#import "HomeElevatorVC.h"
#import "HomeElevatorListVM.h"
#import "GroupUnitEntity.h"
@interface HomeElevatorListVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic)NSArray *dataArray;

@property (strong, nonatomic)HomeElevatorListVM *homeElevatorListVM;

@property (strong, nonatomic)UICollectionView *collectionView;


@end

@implementation HomeElevatorListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电梯控制";

    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.scrollEnabled = YES;

    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
-(void)buildVM{
    
    self.homeElevatorListVM = [HomeElevatorListVM SceneModel];
    
    [RACObserve(self.homeElevatorListVM, groupUnitKeys)subscribeNext:^(id x) {
        if (self.homeElevatorListVM.groupUnitKeys.count>0) {
            [self.collectionView reloadData];
        }
    }];
}
#pragma mark  UICollectionViewDataSource（数据元代理）

-(NSInteger)numberOfSectionsInCollectionView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return self.homeElevatorListVM.groupUnitKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeElevatorListCell *cell = [HomeElevatorListCell setupHomeElevatorListCell:collectionView indexPath:indexPath];
    
    GroupUnitEntity *model = self.homeElevatorListVM.groupUnitKeys[indexPath.row];
    
    cell.guardlabel.text = [NSString stringWithFormat:@"%@-%@",model.buildingName,model.unitName];
    
    return cell;
}

#pragma mark UICollectionViewDelegate代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupUnitEntity *model = self.homeElevatorListVM.groupUnitKeys[indexPath.row];
    
    NSArray *roomArray = [model.roomGroup componentsSeparatedByString:@","];

    if (model.sipAccount) {
        HomeElevatorVC *vc = [HomeElevatorVC new];
        vc.roomArray = roomArray;
        vc.groupUnitEntity = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [AYProgressHud progressHudShowShortTimeMessage:@"该楼无梯控"];
    }
   
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.7, [UIScreen mainScreen].bounds.size.width / 3.7);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
