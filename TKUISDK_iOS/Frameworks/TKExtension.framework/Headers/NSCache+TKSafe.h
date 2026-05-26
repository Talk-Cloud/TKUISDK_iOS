//
//  NSCache+TKSafe.h
//  TKExtension
//
//  Created by zjt on 2025/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCache (TKSafe)
/// 安全设置键值对，防止 key 或 value 为 nil
/// @param anObject 值
/// @param aKey 键
- (void)setObject_TKSafe:(id)anObject forKey:(id<NSCopying>)aKey;
@end

NS_ASSUME_NONNULL_END
