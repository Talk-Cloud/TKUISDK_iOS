//
//  NSArray+TKSafe.h
//  TKExtension
//
//  Created by zjt on 2025/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (TKSafe)
/// 安全获取对象，防止越界
/// - Parameter index: index
- (id)objectAtIndex_TKSafe:(NSInteger)index;
@end

@interface NSMutableArray (TKSafe)
/// 安全添加对象，防止插入 nil 导致崩溃
/// - Parameter obj: obj
- (void)addObject_TKSafe:(id)obj;

/// 安全添加对象，防止插入 nil 导致崩溃
/// - Parameter obj: obj
- (void)setObject_TKSafe:(id)object atIndex:(NSUInteger)index;

/// 安全添加对象，防止插入 nil 导致崩溃
/// - Parameter obj: obj
/// - Parameter toArray: array
- (void)insertObject_TKSafe:(id)object atIndex:(NSUInteger)index toArray:(NSMutableArray *)array;

/// 安全添加对象，防止插入 nil 导致崩溃
/// - Parameter obj: obj
- (void)insertObject_TKSafe:(id)object atIndex:(NSUInteger)index;

/// 安全获取对象，防止越界
/// - Parameter index: index
- (id)objectAtIndex_TKSafe:(NSInteger)index;

/// 安全获取对象，防止越界
/// - Parameter index: index
/// - Parameter fromArray: array
- (void)removeObjectAtIndex_TKSafe:(NSUInteger)index fromArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
