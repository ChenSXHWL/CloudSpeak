//
//  ComplaintsTBViewCell.m
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsTBViewCell.h"
@interface ComplaintsTBViewCell ()

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *typeLabel;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *lineA;

@property (strong, nonatomic) UILabel *contentLabel;

@property (strong, nonatomic) UIView *lineB;

@property (strong, nonatomic) UIImageView *comImageA;

@property (strong, nonatomic) UIImageView *comImageB;

@property (strong, nonatomic) UIImageView *comImageC;

@property (strong, nonatomic) UILabel *isUseLabel;

@property (strong, nonatomic) NSMutableArray *complainTypeArray;

@property (strong, nonatomic) NSMutableArray *complainIntArray;

@property (strong, nonatomic) NSMutableArray *complainStateArray;

@property (strong, nonatomic) NSMutableArray *complainStateIntArray;

@end
@implementation ComplaintsTBViewCell

+ (instancetype)setupComplaintsTBViewCell:(UITableView *)tableView
{
    static NSString *ID = @"ComplaintsTBViewCell";
    
    ComplaintsTBViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[ComplaintsTBViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor= [UIColor clearColor];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 4;
    backView.layer.masksToBounds = YES;
    //阴影的颜色
    backView.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影的透明度
    backView.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    backView.layer.shadowRadius = 4.f;
    //阴影偏移量
    backView.layer.shadowOffset = CGSizeMake(4,4);
    [self.contentView addSubview:backView];
    self.backView = backView;
    
    UILabel *typeLabel = [UILabel new];
    typeLabel.text = @"紧急";
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.backgroundColor = [UIColor redColor];
    typeLabel.layer.cornerRadius = 10;
    typeLabel.layer.masksToBounds = YES;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:typeLabel];
    self.typeLabel = typeLabel;
    self.typeLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:88/255.0 blue:107/255.0 alpha:1];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"提交时间:2018-07-11 09:00:00";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = TextDeepGaryColor;
    [self.backView addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [self.backView addSubview:lineA];
    self.lineA = lineA;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"今天 仅一次aaa啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊嗷嗷嗷啊啊啊啊啊啊啊啊啊啊啊啊";
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    //    contentLabel.textAlignment =
    [self.backView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *comImageA = [UIImageView new];    
    [self.backView addSubview:comImageA];
    self.comImageA = comImageA;
    
    UIImageView *comImageB = [UIImageView new];
    [self.backView addSubview:comImageB];
    self.comImageB = comImageB;
    
    UIImageView *comImageC = [UIImageView new];
    [self.backView addSubview:comImageC];
    self.comImageC = comImageC;
    
    UIView *lineB = [UIView new];
    lineB.backgroundColor = LineEdgeGaryColor;
    [self.backView addSubview:lineB];
    self.lineB = lineB;
    
    UILabel *isUseLabel = [UILabel new];
    isUseLabel.text = @"未查阅";
    isUseLabel.font = [UIFont systemFontOfSize:15];
    isUseLabel.textColor = TextDeepGaryColor;
    [self.backView addSubview:isUseLabel];
    self.isUseLabel = isUseLabel;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.height.mas_equalTo(177);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(16);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(84);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel.mas_centerY);
        make.left.equalTo(self.typeLabel.mas_right).offset(16);
    }];
    
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineA.mas_bottom).offset(8);
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
    }];
    
    [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_bottom).offset(-35);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
    }];
    
    [self.comImageA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(62);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
    }];
    
    [self.comImageB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comImageA.mas_right).offset(16);
        make.bottom.equalTo(self.lineB.mas_bottom).offset(-8);
        make.height.mas_equalTo(62);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
    }];
    
    [self.comImageC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comImageB.mas_right).offset(16);
        make.bottom.equalTo(self.lineB.mas_bottom).offset(-8);
        make.height.mas_equalTo(62);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
    }];
    
    
    
    [self.isUseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.top.equalTo(self.lineB.mas_bottom).offset(10);
    }];
    
}
-(void)setComplainTypeList:(NSArray *)complainTypeList
{
    _complainTypeList = complainTypeList;
    NSMutableArray *complainTypeArray = [NSMutableArray new];
    NSMutableArray *complainIntArray = [NSMutableArray new];
    for (int i = 0; i<complainTypeList.count; i++) {
        [complainTypeArray addObject:complainTypeList[i][@"displayValue"]];
        [complainIntArray addObject:complainTypeList[i][@"storeValue"]];
    }
    _complainTypeArray = complainTypeArray;
    _complainIntArray = complainIntArray;
}
-(void)setComplainStatusList:(NSArray *)complainStatusList{
    _complainStatusList = complainStatusList;
    
    
    NSMutableArray *complainStateArray = [NSMutableArray new];
    NSMutableArray *complainStateIntArray = [NSMutableArray new];
    for (int i = 0; i<complainStatusList.count; i++) {
        [complainStateArray addObject:complainStatusList[i][@"displayValue"]];
        [complainStateIntArray addObject:complainStatusList[i][@"storeValue"]];
    }
    _complainStateArray = complainStateArray;
    _complainStateIntArray= complainStateIntArray;
}
-(void)setHistoryComplaintsEntity:(HistoryComplaintsEntity *)historyComplaintsEntity{
    _historyComplaintsEntity = historyComplaintsEntity;
    for (int i = 0; i<_complainIntArray.count; i++) {
        if (historyComplaintsEntity.complainType.intValue==[_complainIntArray[i] intValue]) {
            self.typeLabel.text = _complainTypeArray[i];
        }
    }
    for (int i = 0; i<_complainStateIntArray.count; i++) {
        if (historyComplaintsEntity.complainStatus.intValue==[_complainStateIntArray[i] intValue]) {
            self.isUseLabel.text = _complainStateArray[i];
        }
    }
    int a = 177;
    self.titleLabel.text = [NSString stringWithFormat:@"提交时间:%@",historyComplaintsEntity.createtime];
    if (historyComplaintsEntity.content.length<20) {
        a = a;
    }else if (historyComplaintsEntity.content.length<40) {
        a = a+14;
    }else if (historyComplaintsEntity.content.length<60){
        a = a+31;
    }else if (historyComplaintsEntity.content.length<80){
        a = a+48;
    }else if (historyComplaintsEntity.content.length<100){
        a = a+65;
    }else if (historyComplaintsEntity.content.length<120){
        a = a+82;
    }else if (historyComplaintsEntity.content.length<140){
        a = a+99;
    }else if (historyComplaintsEntity.content.length<160){
        a = a+116;
    }else if (historyComplaintsEntity.content.length<180){
        a = a+133;
    }else{
        a = a+151;
    }
   
    self.contentLabel.text = historyComplaintsEntity.content;
    
    NSArray *image = [historyComplaintsEntity.imgUrlList componentsSeparatedByString:@","];
    NSMutableArray *aaa = [image mutableCopy];
    for (int i =0; i<aaa.count; i++) {
        NSString *url = aaa[i];
        if (url.length>6) {
            
        }else{
            [aaa removeObject:url];
        }
    }
    image = [aaa copy];
    if (image.count==1) {
        self.comImageA.hidden = NO;
        [self.comImageA imageShwoActivityIndicatorWithUrlString:image[0] placeHolder:@"icon_me"];
    }else if (image.count == 2){
        self.comImageA.hidden = NO;
        self.comImageB.hidden = NO;

        [self.comImageA imageShwoActivityIndicatorWithUrlString:image[0] placeHolder:@""];
        [self.comImageB imageShwoActivityIndicatorWithUrlString:image[1] placeHolder:@""];

    }else if(image.count == 3){
        self.comImageA.hidden = NO;
        self.comImageB.hidden = NO;
        self.comImageC.hidden = NO;

        [self.comImageA imageShwoActivityIndicatorWithUrlString:image[0] placeHolder:@""];
        [self.comImageB imageShwoActivityIndicatorWithUrlString:image[1] placeHolder:@""];
        [self.comImageC imageShwoActivityIndicatorWithUrlString:image[2] placeHolder:@""];

    }else{
        
        self.comImageA.hidden = YES;
        self.comImageB.hidden = YES;
        self.comImageC.hidden = YES;
        a = a-66;
    }
    
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.height.mas_equalTo(a);
    }];
    
    [self.lineB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_bottom).offset(-35);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(SCREEN_WIDTH-64);
    }];
//
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
