//
//  YYCacheManager.h
//  DinpayPurse
//
//  Created by wq on 17/3/22.
//  Copyright © 2017年 WQ. All rights reserved.
//
/** 替代NSUserDefaults存储公共信息 */
/** 替代NSUserDefaults存储公共信息 */
/** 替代NSUserDefaults存储公共信息 */
#import <Foundation/Foundation.h>

@interface YYCacheManager : NSObject

/** 存储字典数组 */
+ (void)saveHttpCache:(id)httpCache forKey:(NSString *)key;

/** 获取 */
+ (id)getHttpCacheForKey:(NSString *)key;

/** 删除所有的 */
+ (void)removeAllHttpCache;

@end
