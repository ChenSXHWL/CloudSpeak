//
//  LoginManage.m
//  ProQ
//
//  Created by pengchunlian on 15/1/8.
//  Copyright (c) 2015年 com.flygps. All rights reserved.
//

#import "LoginManage.h"
#import "BaseNavigationController.h"
#import "BXTabBarController.h"
#import "LoginVC.h"
#import "GuideVC.h"

@interface LoginManage()
@property(nonatomic,strong)id loginEntity; //用作修改用。

@end

@implementation LoginManage

//建立单例
+ (instancetype )sharedInstance{
    static dispatch_once_t onceToken;
    static LoginManage *_singleton = nil;
    dispatch_once(&onceToken,^{
        _singleton = [[super allocWithZone:NULL] init];
        _singleton.loginEntity = [LoginManage getAccountInfo];
    });
    return _singleton;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

-(void)setLoginEntity:(LoginEntity *)loginEntity
{
    _loginEntity = loginEntity;
    if (_loginEntity) {
        self.isLogin = YES;
    }else {
        self.isLogin = NO;
    }
}


#pragma mark 其他
//是否是第一次登陆
static NSString *const isFirstLaunching = @"LoginLogic_isFirstLaunching";
+(BOOL)yesOrNoFirstLaunching
{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    /*设置引导页*/
    
    [defaults registerDefaults:@{isFirstLaunching:@YES }];
    BOOL yesOrNoFirstLaunching =[defaults boolForKey:isFirstLaunching];
    if (yesOrNoFirstLaunching) {
        [defaults setBool:NO forKey:isFirstLaunching];
    }
    return yesOrNoFirstLaunching;
}


#pragma mark 选择是否需要保存数据

//存账号和密码的信息
static NSString *const SaveAccountInfo = @"LoginManage_SaveAccountInfo";
static NSString *const SaveAccount = @"LoginManage_SaveAccount";


//------------------------


+(void)saveMyAccount:(NSString *)account andEntity:(id)loginEntity
{
    [self saveAccount:account];
    [self saveEntity:loginEntity];
}

+(void)saveAccount:(NSString *)account
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:account forKey:SaveAccount];
}

+(void)saveEntity:(id)loginEntity
{
    [LoginManage sharedInstance].loginEntity = loginEntity;
    [self saveAccountInfo];
}



+(void)saveAccountInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject  = [NSKeyedArchiver archivedDataWithRootObject:[LoginManage sharedInstance].loginEntity];//将所有信息存入;
    [defaults setObject:myEncodedObject forKey:SaveAccountInfo];
}

+(id)getAccountInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:SaveAccountInfo];
    if([myEncodedObject isKindOfClass:[NSNull class]] && myEncodedObject.length) return nil;
    return [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    
}

+(NSString *)getAccount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:SaveAccount];
    
}
#pragma mark 资料的删除和修改
+(void)deleteAccountInfomation
{
    [LoginEntity shareManager].password = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:SaveAccountInfo];
    [defaults removeObjectForKey:@"communityName"];
    [defaults removeObjectForKey:@"keyName"];

}

#pragma mark 退出

+(void)loginOut
{
    //清空密码。
    [LoginManage deleteAccountInfomation];
    
    [[AYCloudSpeakApi cloudSpeakApi] unRegisterUser];
}

// 登录
+ (void)goMain{
    
    
    if ([LoginManage sharedInstance].isLogin) {
        
        BXTabBarController *tabVC = [[BXTabBarController alloc] init];
        
        [URLNavigation setRootViewController:tabVC];
        
        [Action actionConfigScheme:[LoginEntity shareManager].scheme host:[LoginEntity shareManager].url client:@"" codeKey:@"isSuccess" rightCode:1 msgKey:@"msg"];
        
    }else {
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[GuideVC new]];
        
        [URLNavigation setRootViewController:nav];
        
        [Action actionConfigScheme:@"http" host:ISHome_Host client:@"" codeKey:@"isSuccess" rightCode:1 msgKey:@"msg"];
        
    }
}



@end
