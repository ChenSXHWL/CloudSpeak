//
//  GDMapView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GDMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface GDMapView () <MAMapViewDelegate, AMapSearchDelegate>

@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic) UIView *verView;

@property (strong, nonatomic) UIView *horView;

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) UIView *centerView;

@property (strong, nonatomic) UILabel *addressLabel;

@property (strong, nonatomic) UIImageView *addressImageView;

@property (strong, nonatomic) MAMapView *mapView;

@property (strong, nonatomic) AMapSearchAPI *searchAPI;

@property (copy, nonatomic) NSString *addressString;

@property (copy, nonatomic) NSString *pointString;

@property (assign, nonatomic) BOOL isUpdate;

@end

@implementation GDMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupMapView
{
    
}

- (void)setupUI
{
    
    self.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    UIView *alertView = [UIView new];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 20;
    [self addSubview:alertView];
    self.alertView = alertView;
    [self exChangeOut:alertView dur:0.6];
    
    UIView *verView = [UIView new];
    verView.backgroundColor = RGB(200, 200, 200);
    [alertView addSubview:verView];
    self.verView = verView;
    
    UIView *horView = [UIView new];
    horView.backgroundColor = RGB(200, 200, 200);
    [alertView addSubview:horView];
    self.horView = horView;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:TextMainBlackColor forState:UIControlStateNormal];
    [self.alertView addSubview:cancelButton];
    self.cancelButton = cancelButton;
    [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:RGB(0, 98, 255) forState:UIControlStateNormal];
    [self.alertView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    [confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *centerView = [UIView new];
    [self.alertView addSubview:centerView];
    self.centerView = centerView;
    
    UIImageView *addressImageView = [UIImageView new];
    addressImageView.image = [UIImage imageNamed:@"message_point"];
    [centerView addSubview:addressImageView];
    self.addressImageView = addressImageView;
    
    UILabel *addressLabel = [UILabel new];
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.text = @"位置获取中...";
    [centerView addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] init];
    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    self.mapView.delegate = self;
    [centerView addSubview:self.mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    
    _mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:17 animated:YES];
    
    AMapSearchAPI *searchAPI = [[AMapSearchAPI alloc] init];
    searchAPI.delegate = self;
    self.searchAPI = searchAPI;
    
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    
    r.locationDotBgColor = [UIColor clearColor];
    
    r.locationDotFillColor = [UIColor clearColor];
    
    [self.mapView updateUserLocationRepresentation:r];
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    
    if (self.isUpdate) return;
    
    self.isUpdate = YES;
    
    mapView.centerCoordinate = userLocation.location.coordinate;
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.lockedToScreen = YES;
    pointAnnotation.lockedScreenPoint = mapView.center;
    [_mapView addAnnotation:pointAnnotation];
    
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    if (mapView.userLocation.location) {
        
        AMapReGeocodeSearchRequest *request = [AMapReGeocodeSearchRequest new];
        request.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
        
        [_searchAPI AMapReGoecodeSearch:request];
    }
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    self.addressLabel.text = response.regeocode.formattedAddress;
    
    NSString *latitude = [NSString stringWithFormat:@"%f", request.location.latitude];
    
    NSString *longitude = [NSString stringWithFormat:@"%f", request.location.longitude];
    
    self.addressString = [NSString stringWithFormat:@"%@\n(%@, %@)", response.regeocode.formattedAddress, latitude, longitude];
    
    self.pointString = [NSString stringWithFormat:@"%@, %@", latitude, longitude];
    
//    //定位标注点要现实点标题信息
//    _mapView.userLocation.title = str;
//    //子标题
//    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}

//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorRed;
//        return annotationView;
//    }
//    return nil;
//}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    // 自定义定位精度对应的MACircleView
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleView = [[MACircleRenderer alloc] initWithCircle:(MACircle *)overlay];
        
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor clearColor];
        accuracyCircleView.fillColor    = [UIColor clearColor];
        
        return accuracyCircleView;
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(32);
        make.right.equalTo(self.mas_right).offset(-32);
        make.height.equalTo(self.alertView.mas_width).multipliedBy(1.3);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.verView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.alertView);
        make.bottom.equalTo(self.alertView.mas_bottom).offset(-50);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.horView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verView.mas_bottom);
        make.bottom.equalTo(self.alertView.mas_bottom);
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(self.alertView.mas_centerX);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.alertView);
        make.top.equalTo(self.verView.mas_bottom);
        make.right.equalTo(self.horView.mas_left);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.alertView);
        make.top.equalTo(self.verView.mas_bottom);
        make.left.equalTo(self.horView.mas_right);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.alertView);
        make.bottom.equalTo(self.verView.mas_top);
    }];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.centerView.mas_right).offset(-16);
        make.bottom.equalTo(self.centerView.mas_bottom).offset(-16);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView.mas_left).offset(16);
        make.right.equalTo(self.addressImageView.mas_left);
        make.bottom.equalTo(self.verView.mas_bottom).offset(-16);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.centerView);
        make.bottom.equalTo(self.addressImageView.mas_top).offset(-16);
    }];
    
}

- (void)clickCancelButton
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickConfirmButton
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    self.mapViewBlock(self.addressString, self.pointString);
    
}

-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

@end
