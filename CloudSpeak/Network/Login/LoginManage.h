//
//  LoginManage.h
//  ProQ
//
//  Created by pengchunlian on 15/1/8.
//  Copyright (c) 2015年 com.flygps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManage : NSObject
//判断是否已经登陆
@property(nonatomic)BOOL isLogin;
@property(nonatomic,strong,readonly)id loginEntity;
/**
 *  //不删除banding的账号信息。比如是否已经阅读。
 */


//建设单例
+ (instancetype )sharedInstance;
#pragma mark 登陆

;
//是否是第一次登陆
+(BOOL)yesOrNoFirstLaunching;

#pragma mark 账号信息保存


/**
 *  基本保存方法，只保存账号和用户信息，用于后台登录。
 *
 *  @param account     账号信息
 *  @param loginEntity 用户信息
 */
+(void)saveMyAccount:(NSString *)account andEntity:(id)loginEntity;


+(void)saveAccount:(NSString *)account;
+(void)saveEntity:(id)loginEntity;
+(NSString *)getAccount;
//清空信息。
+(void)deleteAccountInfomation;

//退出登陆
+(void)loginOut;

+ (void)goMain;


@end
