//
//  YYCacheManager.m
//  DinpayPurse
//
//  Created by wq on 17/3/22.
//  Copyright © 2017年 WQ. All rights reserved.
//

#import "YYCache.h"
#import "YYCacheManager.h"
@implementation YYCacheManager
static NSString *const NetworkResponseCache = @"wxm.NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}

+ (void)saveHttpCache:(id)httpCache forKey:(NSString *)key {
    [_dataCache setObject:httpCache forKey:key withBlock:nil];
}

+ (id)getHttpCacheForKey:(NSString *)key {
    return [_dataCache objectForKey:key];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

@end
