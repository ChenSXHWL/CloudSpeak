//
//  AYAddPhone.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/6/23.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYAddPhone.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AYAlertViewController.h"

#define IS_iOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f
#define IS_iOS6 [[UIDevice currentDevice].systemVersion floatValue] >= 6.0f

@interface AYAddPhone ()

@property (assign, nonatomic) int tip;

@property (strong, nonatomic) NSMutableDictionary *infoDictionary;

@end

@implementation AYAddPhone

+ (instancetype)setupAYAddPhone:(NSArray *)phone
{
    return [[self alloc] initWithPhones:phone];
}

- (instancetype)initWithPhones:(NSArray *)phone {
    if (self = [super init]) {
        
        _infoDictionary = [NSMutableDictionary dictionary];
        
        [_infoDictionary setObject:@"门禁呼叫" forKey:@"name"];
        [_infoDictionary setObject:@"" forKey:@"email"];
        
        [self gotoAddContacts:phone];
        
     }
     return self;
}

/**
 添加联系人
 */
- (void)gotoAddContacts:(NSArray *)phones{
    
    //添加到通讯录,判断通讯录是否存在
    if ([self isExistContactPerson:phones]) {//存在，返回
        return;
    }else{//不存在  添加
        
        if (_tip == 1) return;
        
        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController Title:@"添加到通讯录" message:@"门禁呼叫" cancelStr:@"取消" confirmStr:@"确定" styleText:0 isSecret:YES value:nil alert:^(UIAlertController *action) {
            [self creatNewRecord:phones];
        }];
    }
}

- (BOOL)isExistContactPerson:(NSArray *)phoneNums{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    
    BOOL __block isExist = NO;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if (IS_iOS6) {
        //创建通讯簿的引用，第一个参数暂时写NULL，官方文档就是这么说的，后续会有用，第二个参数是error参数
        CFErrorRef error = NULL;
        addBook=ABAddressBookCreateWithOptions(NULL, &error);
        //创建一个初始信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip=1;
                
            }else{
                //获取所有联系人的数组
                CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
                //获取联系人总数
                CFIndex number = ABAddressBookGetPersonCount(addBook);
                //进行遍历
                for (NSInteger i=0; i<number; i++) {
                    //获取联系人对象的引用
                    ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
                    //获取当前联系人名字
                    NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
                    
                    if ([firstName isEqualToString:[_infoDictionary objectForKey:@"name"]]) {
                        
                        //获取当前联系人的电话 数组
                        NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
                        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
                        for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
                            [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
                            
                            if (![phoneArr[0] isEqualToString:phoneNums[0]]) {
                                
                                [self editRecord:(int)ABRecordGetRecordID(people) phones:phoneNums];
                                
                            }
                            
                        }
                        
                        isExist = YES;
                        
                    }
                    
                    //                    //获取当前联系人姓氏
                    //                    NSString*lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
                    
                    //获取当前联系人中间名
                    //                    NSString*middleName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNameProperty));
                    //                    //获取当前联系人的名字前缀
                    //                    NSString*prefix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonPrefixProperty));
                    //                    //获取当前联系人的名字后缀
                    //                    NSString*suffix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonSuffixProperty));
                    //                    //获取当前联系人的昵称
                    //                    NSString*nickName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNicknameProperty));
                    //                    //获取当前联系人的名字拼音
                    //                    NSString*firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
                    //                    //获取当前联系人的姓氏拼音
                    //                    NSString*lastNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonLastNamePhoneticProperty));
                    //                    //获取当前联系人的中间名拼音
                    //                    NSString*middleNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNamePhoneticProperty));
                    //                    //获取当前联系人的公司
                    //                    NSString*organization=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonOrganizationProperty));
                    //                    //获取当前联系人的职位
                    //                    NSString*job=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonJobTitleProperty));
                    //                    //获取当前联系人的部门
                    //                    NSString*department=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonDepartmentProperty));
                    //                    //获取当前联系人的生日
                    //                    NSString*birthday=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonBirthdayProperty));
                    //                    NSMutableArray * emailArr = [[NSMutableArray alloc]init];
                    //                    //获取当前联系人的邮箱 注意是数组
                    //                    ABMultiValueRef emails= ABRecordCopyValue(people, kABPersonEmailProperty);
                    //                    for (NSInteger j=0; j<ABMultiValueGetCount(emails); j++) {
                    //                        [emailArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(emails, j))];
                    //                    }
                    //                    //获取当前联系人的备注
                    //                    NSString*notes=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNoteProperty));
                    //                    //获取当前联系人的电话 数组
                    //                    NSMutableArray * phoneArr = [[NSMutableArray alloc]init];
                    //                    ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
                    //                    for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
                    //                        [phoneArr addObject:(__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j))];
                    //                    }
                    //                    //获取创建当前联系人的时间 注意是NSDate
                    //                    NSDate*creatTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonCreationDateProperty));
                    //                    //获取最近修改当前联系人的时间
                    //                    NSDate*alterTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonModificationDateProperty));
                    //                    //获取地址
                    //                    ABMultiValueRef address = ABRecordCopyValue(people, kABPersonAddressProperty);
                    //                    for (int j=0; j<ABMultiValueGetCount(address); j++) {
                    //                        //地址类型
                    //                        NSString * type = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(address, j));
                    //                        NSDictionary * temDic = (__bridge NSDictionary *)(ABMultiValueCopyValueAtIndex(address, j));
                    //                        //地址字符串，可以按需求格式化
                    //                        NSString * adress = [NSString stringWithFormat:@"国家:%@\n省:%@\n市:%@\n街道:%@\n邮编:%@",[temDic valueForKey:(NSString*)kABPersonAddressCountryKey],[temDic valueForKey:(NSString*)kABPersonAddressStateKey],[temDic valueForKey:(NSString*)kABPersonAddressCityKey],[temDic valueForKey:(NSString*)kABPersonAddressStreetKey],[temDic valueForKey:(NSString*)kABPersonAddressZIPKey]];
                    //                    }
                    //                    //获取当前联系人头像图片
                    //                    NSData*userImage=(__bridge NSData*)(ABPersonCopyImageData(people));
                    //                    //获取当前联系人纪念日
                    //                    NSMutableArray * dateArr = [[NSMutableArray alloc]init];
                    //                    ABMultiValueRef dates= ABRecordCopyValue(people, kABPersonDateProperty);
                    //                    for (NSInteger j=0; j<ABMultiValueGetCount(dates); j++) {
                    //                        //获取纪念日日期
                    //                        NSDate * data =(__bridge NSDate*)(ABMultiValueCopyValueAtIndex(dates, j));
                    //                        //获取纪念日名称
                    //                        NSString * str =(__bridge NSString*)(ABMultiValueCopyLabelAtIndex(dates, j));
                    //                        NSDictionary * temDic = [NSDictionary dictionaryWithObject:data forKey:str];
                    //                        [dateArr addObject:temDic];
                    //                    }
                }
                
                
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        
        //IOS6之前
        addBook =ABAddressBookCreate();
        
        //获取所有联系人的数组
        CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
        //获取联系人总数
        CFIndex number = ABAddressBookGetPersonCount(addBook);
        //进行遍历
        for (NSInteger i=0; i<number; i++) {
            //获取联系人对象的引用
            ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
            //获取当前联系人名字
            NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            
            if ([firstName isEqualToString:[_infoDictionary objectForKey:@"name"]]) {
                isExist = YES;
            }
        }
    }
    
//    if (tip) {
//            
//        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController message:@"请您设置允许APP访问您的通讯录" confirmStr:@"确定" alert:^(UIAlertController *action) {
//            
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Prefs:root=WIFI"]];
//            
//        }];
//
//    }
    
    self.tip = tip;
    
    return isExist;
}

//创建新的联系人
- (void)creatNewRecord:(NSArray *)phones
{
    CFErrorRef error = NULL;
    
    //创建一个通讯录操作对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    //创建一条新的联系人纪录
    ABRecordRef newRecord = ABPersonCreate();
    
    //为新联系人记录添加属性值
    ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)[_infoDictionary objectForKey:@"name"], &error);
    
    //创建一个多值属性(电话)
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    for (int i = 0; i < phones.count; i ++) {
        
        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phones[i], kABPersonPhoneMobileLabel, NULL);
        
    }
    
    ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
    
    //添加email
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)([_infoDictionary objectForKey:@"email"]), kABWorkLabel, NULL);
    ABRecordSetValue(newRecord, kABPersonEmailProperty, multiEmail, &error);
    
    
    //添加记录到通讯录操作对象
    ABAddressBookAddRecord(addressBook, newRecord, &error);
    
    //保存通讯录操作对象
    ABAddressBookSave(addressBook, &error);
    
    //通过此接口访问系统通讯录
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            //显示提示
            if (IS_iOS8) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                }];
                [alertVc addAction:alertAction];
            }else{
                
                UIAlertView *tipView = [[UIAlertView alloc] initWithTitle:nil message:@"添加成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [tipView show];
                //非ARC
                //                [tipView release];
            }
        }
    });
    
    CFRelease(multiEmail);
    CFRelease(multi);
    CFRelease(newRecord);
    CFRelease(addressBook);
}

- (void) editRecord:(int)recordID phones:(NSArray *)phones
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(addressBook, recordID);
    
    //设置电话号码
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    for (int i = 0; i < phones.count; i ++) {
        
        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phones[i], kABPersonPhoneMobileLabel, NULL);
        
    }
    
    //添加电话号码到数据库
    ABRecordSetValue(record, kABPersonPhoneProperty, multi, &error);
    CFRelease(multi);
    
    //保存到数据库
    ABAddressBookSave(addressBook, &error);
    CFRelease(addressBook);
    
}

@end
