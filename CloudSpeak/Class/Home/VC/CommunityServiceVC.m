//
//  CommunityServiceVC.m
//  CloudSpeak
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "CommunityServiceVC.h"
#import "HomeElevatorListCell.h"
#import "HomeAnnouncementVC.h"
#import "WarrantyVC.h"
#import "ComplaintsVC.h"
#import "CommuntityServiceVM.h"
#import "ComplaintsPhoneVC.h"
@interface CommunityServiceVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic)NSArray *titleArray;
@property (strong, nonatomic)NSArray *iconArray;
@property (strong, nonatomic)CommuntityServiceVM *communtityServiceVM;

@end

@implementation CommunityServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区服务";
    
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
    self.iconArray = @[@"community_announcement",@"communtity_repair",@"community_complaints",@"communttity_pay",@"community_phone"];
    self.titleArray = @[@"社区公告",@"物业报修",@"投诉建议",@"物业缴费",@"社区电话"];
    
    self.communtityServiceVM = [CommuntityServiceVM SceneModel];
    self.communtityServiceVM.obtainComplaintsTypeRequest.requestNeedActive = YES;
    self.communtityServiceVM.repairTypeListRequest.requestNeedActive = YES;
}

#pragma mark  UICollectionViewDataSource（数据元代理）

-(NSInteger)numberOfSectionsInCollectionView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeElevatorListCell *cell = [HomeElevatorListCell setupHomeElevatorListCell:collectionView indexPath:indexPath];
    cell.guardImageView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.guardlabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    if(indexPath.row==0){
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        HomeAnnouncementVC *vc = [HomeAnnouncementVC new];
        vc.dataArray = self.dataArray;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        
        if (self.communtityServiceVM.repairTypeList.count<1) {
            return [AYProgressHud progressHudShowShortTimeMessage:@"该小区无报修功能"];
        }
        
        WarrantyVC *warrantyVC = [WarrantyVC new];
        
        warrantyVC.dataArray = self.dataArray;
        warrantyVC.repairStatusList = self.communtityServiceVM.repairStatusList;
        warrantyVC.repairTypeList = self.communtityServiceVM.repairTypeList;
        [self.navigationController pushViewController:warrantyVC animated:YES];

    }else if (indexPath.row==2){
        
        if (self.communtityServiceVM.complainTypeList.count<1) {
            return [AYProgressHud progressHudShowShortTimeMessage:@"该小区无投诉功能"];
        }
        
        ComplaintsVC *complaintsVC = [ComplaintsVC new];
        
        complaintsVC.complainStatusList = self.communtityServiceVM.complainStatusList;
        complaintsVC.complainTypeList = self.communtityServiceVM.complainTypeList;

        [self.navigationController pushViewController:complaintsVC animated:YES];
    }else if (indexPath.row==3){
        [AYProgressHud progressHudShowShortTimeMessage:@"该功能暂未开放"];

    }else{
        ComplaintsPhoneVC *complaintsVC = [ComplaintsPhoneVC new];

        [self.navigationController pushViewController:complaintsVC animated:YES];
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
