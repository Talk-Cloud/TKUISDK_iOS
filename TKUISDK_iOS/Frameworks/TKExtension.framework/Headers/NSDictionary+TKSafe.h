//
//  NSDictionary+TKSafe.h
//  TKExtension
//
//  Created by zjt on 2025/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (TKSafe)

- (id)objectForKey_TKSafe:(id)key;

@end


@interface NSMutableDictionary (TKSafe)
/// 安全设置键值对，防止 key 或 value 为 nil
/// @param anObject 值
/// @param aKey 键
- (void)setObject_TKSafe:(id)anObject forKey:(id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
