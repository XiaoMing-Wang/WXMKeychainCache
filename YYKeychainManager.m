//
//  YYKeychainManager.m
//  Multi-project-coordination
//
//  Created by wq on 2020/4/20.
//  Copyright © 2020 wxm. All rights reserved.
//
#import "YYKeychain.h"
#import "YYKeychainManager.h"

#define PHONESINE @"YYKeychainPHONESINE"
@implementation YYKeychainManager
static NSString *const kServiceName = @"com.triumen.trmchain";
static NSString *const kAccountName = @"AuthorizationAccount";

/** 存储授权登录的账号 nil为未授权  */
+ (void)saveAuthorizationAccount:(NSString *)accountID
                     accessToken:(NSString *)accessToken
                    placeholders:(NSString *)placeholders {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PHONESINE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableDictionary *dictionary = @{}.mutableCopy;
    [dictionary setObject:accountID forKey:@"accountID"];
    [dictionary setObject:accessToken forKey:@"accessToken"];
    if (placeholders) [dictionary setObject:placeholders forKey:@"placeholders"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    NSString *dictionaryString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [YYKeychain setPassword:dictionaryString forService:kServiceName account:kAccountName];
}

+ (void)saveAuthorizationAccount:(NSString *)accountID accessToken:(NSString *)accessToken {
    [self saveAuthorizationAccount:accountID accessToken:accessToken placeholders:@""];
}

/* accountID */
+ (NSString *)authorizationAccountID {
    NSString *dictionaryString = [YYKeychain getPasswordForService:kServiceName account:kAccountName];
    NSDictionary *dictionary = [self jsonToDictionary:dictionaryString];
    NSString *accountID = [dictionary objectForKey:@"accountID"];
    return accountID ?: nil;
}

/* accessToken */
+ (NSString *)authorizationAccessToken {
    NSString *dictionaryString = [YYKeychain getPasswordForService:kServiceName account:kAccountName];
    NSDictionary *dictionary = [self jsonToDictionary:dictionaryString];
    NSString *accessToken = [dictionary objectForKey:@"accessToken"];
    return accessToken ?: nil;
}

/* placeholders */
+ (NSString *)authorizationPlaceholders {
    NSString *dictionaryString = [YYKeychain getPasswordForService:kServiceName account:kAccountName];
    NSDictionary *dictionary = [self jsonToDictionary:dictionaryString];
    NSString *placeholders = [dictionary objectForKey:@"placeholders"];
    return placeholders ?: nil;
}

/* 是否存在授权登录账号 */
+ (BOOL)isAuthorization {
    BOOL isFirstLoad = [[NSUserDefaults standardUserDefaults] boolForKey:PHONESINE];
    
    /** 代表第一次装app  */
    if (isFirstLoad == NO) {
        [self removeAuthorization];
        return NO;
    }
    
    return [YYKeychain getPasswordForService:kServiceName account:kAccountName].length > 0;
}

/* 删除授权ID */
+ (void)removeAuthorization {
    [YYKeychain setPassword:@"" forService:kServiceName account:kAccountName];
}

/** 字符串转化字典 */
+ (NSDictionary *)jsonToDictionary:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) return nil;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}

@end
