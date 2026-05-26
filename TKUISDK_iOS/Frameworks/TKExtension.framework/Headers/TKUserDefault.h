//
//  TKUserDefault.h
//  TKUISDK
//
//  Created by EDY on 2022/10/10.
//  Copyright © 2022 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKUserDefault : NSObject

/**
 *  存储数据到userdefault
 *
 *  @param anObject 数据
 *  @param aKey     标识
 */
+ (void)setValue:(id)anObject forKey:(NSString *)aKey;
/**
 *  从userdefault获取数据
 *
 *  @param aKey 标识
 *
 *  @return 数据
 */
+ (id __nullable)getValueForKey:(NSString *)aKey;



/// 删除
/// @param aKey 标识
+ (void)removeObjectForKey:(NSString *)aKey;


@end

NS_ASSUME_NONNULL_END
