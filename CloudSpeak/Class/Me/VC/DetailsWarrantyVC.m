//
//  DetailsWarrantyVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DetailsWarrantyVC.h"
#import "AYBrowseImage.h"
@interface DetailsWarrantyVC ()

@property (strong, nonatomic)NSArray *imageArray;

@end

@implementation DetailsWarrantyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报修详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;//scroll自动下移64像素解决方法

    [self buildUI];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64 )];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (self.repairHistoryEntity.reportProblem.length)/12 *20+SCREEN_HEIGHT-184);  //非常重要
    scrollView.contentOffset =  CGPointMake(0, 0);
        scrollView.backgroundColor = [UIColor whiteColor];
    //显示水平方向的滚动条(默认YES)
    scrollView.showsHorizontalScrollIndicator = NO;
    //显示垂直方向的滚动条(默认YES)
    scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:scrollView];

    
    UIView *backView = [UIView new];
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  (self.repairHistoryEntity.reportProblem.length)/12 *20+SCREEN_HEIGHT-184);
    backView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:backView];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(scrollView.mas_top).offset(0);
//        make.left.right.bottom.equalTo(scrollView);
//        make.height.mas_equalTo((self.repairHistoryEntity.reportProblem.length)/12 *40+SCREEN_HEIGHT-84);
//    }];
    
    UILabel *reportTypebeLabel = [UILabel new];
    reportTypebeLabel.text = @"报修类型:";
    reportTypebeLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:reportTypebeLabel];
    [reportTypebeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(16);
        make.top.equalTo(backView.mas_top).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *reportType = [UILabel new];
    reportType.textAlignment = NSTextAlignmentLeft;
    reportType.numberOfLines = 0;
    [backView addSubview:reportType];
    [reportType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reportTypebeLabel.mas_right).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH-112);
        make.top.equalTo(reportTypebeLabel.mas_top);
    }];
    
    for (int i = 0 ; i<self.repairTypeList.count; i++) {
        if ([self.repairHistoryEntity.repairType isEqualToString:self.repairTypeList[i][@"storeValue"]]) {
            reportType.text = self.repairTypeList[i][@"displayValue"];
        }
    }
    
    
    UILabel *createtimeTimeLabel = [UILabel new];
    createtimeTimeLabel.text = @"上报时间:";
    createtimeTimeLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:createtimeTimeLabel];
    [createtimeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(16);
        make.top.equalTo(reportTypebeLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *createtimeTime = [UILabel new];
    createtimeTime.text = self.repairHistoryEntity.createtime;
    createtimeTime.textAlignment = NSTextAlignmentLeft;
    createtimeTime.numberOfLines = 0;
    [backView addSubview:createtimeTime];
    [createtimeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(createtimeTimeLabel.mas_right).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH-112);
        make.top.equalTo(createtimeTimeLabel.mas_top);
    }];
    
    UILabel *stateLabel = [UILabel new];
    stateLabel.text = @"处理状态:";
    stateLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(16);
        make.top.equalTo(createtimeTimeLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *state = [UILabel new];
    if (self.repairHistoryEntity.repairStatus.intValue==1) {
        state.text = @"未处理";
    }else{
        state.text = @"已处理";
    }
    state.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:state];
    [state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLabel.mas_right).offset(6);
        make.centerY.equalTo(stateLabel);
    }];
    
    UILabel *processingTimeLabel = [UILabel new];
    processingTimeLabel.text = @"处理时间:";
    processingTimeLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:processingTimeLabel];
    [processingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(stateLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *processingTime = [UILabel new];
    processingTime.text = self.repairHistoryEntity.modifytime;
    processingTime.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:processingTime];
    [processingTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(processingTimeLabel.mas_right).offset(6);
        make.centerY.equalTo(processingTimeLabel);
    }];
    
    UILabel *addressLabel = [UILabel new];
    addressLabel.text = @"故障地址:";
    addressLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(processingTimeLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *address = [UILabel new];
    address.text = self.repairHistoryEntity.location;
    address.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLabel.mas_right).offset(6);
        make.centerY.equalTo(addressLabel);
    }];
    
    UILabel *equipmentLabel = [UILabel new];
    equipmentLabel.text = @"设备ID:";
    equipmentLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:equipmentLabel];
    [equipmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(16);
        make.top.equalTo(addressLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *equipment = [UILabel new];
    equipment.text = self.repairHistoryEntity.deviceNum;
    equipment.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:equipment];
    [equipment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(equipmentLabel.mas_right).offset(6);
        make.centerY.equalTo(equipmentLabel);
    }];
    
    UILabel *describeLabel = [UILabel new];
    describeLabel.text = @"描述:";
    describeLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(16);
        make.top.equalTo(equipmentLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(74);
    }];
    
    UILabel *describe = [UILabel new];
    describe.text = self.repairHistoryEntity.reportProblem;
    describe.textAlignment = NSTextAlignmentLeft;
    describe.numberOfLines = 0;
    [backView addSubview:describe];
    [describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(describeLabel.mas_right).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH-112);
        make.top.equalTo(describeLabel.mas_top);
    }];
    
    
    
    UIView *line = [UIView new];
    line.backgroundColor = LineEdgeGaryColor;
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(backView);
        make.height.mas_equalTo(1);
        make.top.equalTo(describe.mas_bottom).offset(16);
    }];
    
    UILabel *photoLabel = [UILabel new];
    photoLabel.text = @"照片:";
    [backView addSubview:photoLabel];
    [photoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(16);
        make.top.equalTo(line.mas_bottom).offset(16);
    }];
    
    
    
    
    self.imageArray = [self.repairHistoryEntity.reportImgUrl componentsSeparatedByString:@","];
    NSMutableArray *ary = [self.imageArray mutableCopy];
    for (int i = 0; i<ary.count; i++) {
        NSString *url = ary[i];
        if (!(url.length>10)) {
            [ary removeObject:url];
        }
    }
    self.imageArray = [ary copy];
    if (_imageArray.count==0) {
        photoLabel.text = @"照片:无";
    }
    for (int i= 0; i<_imageArray.count; i++) {
        
        UIImageView *photoA = [UIImageView new];
        [photoA imageShwoActivityIndicatorWithUrlString:_imageArray[i] placeHolder:@""];
        [backView addSubview:photoA];
        [photoA mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left).offset(16+(SCREEN_WIDTH-64)/3*i);
            make.top.equalTo(photoLabel.mas_bottom).offset(16);
            make.height.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        }];
        UIButton *imageTouch = [UIButton buttonWithType:UIButtonTypeCustom];
        imageTouch.tag = 100+i;
        [imageTouch addTarget:self action:@selector(iamgeTcouUp:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:imageTouch];
        [imageTouch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView.mas_left).offset(16+(SCREEN_WIDTH-64)/3*i);
            make.top.equalTo(photoLabel.mas_bottom).offset(16);
            make.height.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        }];
    }
}
-(void)iamgeTcouUp:(UIButton *)sender{
    
    [AYBrowseImage browseNetworkImageWithImages:[NSMutableArray arrayWithArray:_imageArray] currentIndex:(int)sender.tag-100];
    
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
