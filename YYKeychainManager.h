//
//  YYKeychainManager.h
//  Multi-project-coordination
//
//  Created by wq on 2020/4/20.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYKeychainManager : NSObject

/** 存储授权登录的账号 */
+ (void)saveAuthorizationAccount:(NSString *)accountID accessToken:(NSString *)accessToken;
+ (void)saveAuthorizationAccount:(NSString *)accountID
                     accessToken:(nullable NSString *)accessToken
                    placeholders:(nullable NSString *)placeholders;

/* AccountID 和 AccessToken */
+ (NSString *)authorizationAccountID;
+ (NSString *)authorizationAccessToken;
+ (NSString *)authorizationPlaceholders;

/* 删除授权AccountID 和 AccessToken */
+ (void)removeAuthorization;

/* 是否存在授权登录账号 */
+ (BOOL)isAuthorization;

@end

NS_ASSUME_NONNULL_END
