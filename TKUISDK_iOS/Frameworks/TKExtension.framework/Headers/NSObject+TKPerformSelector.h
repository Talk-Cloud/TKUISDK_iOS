//
//  NSObject+TKPerformSelector.h
//  EduClass
//
//  Created by 刘金丰 on 2020/5/22.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TKPerformSelector)

/// 执行选择器
/// @param selector 选择器
/// @param parameters 函数参数
/// @param error 错误信息, 50010: selector 参数不能为空, 50011: 没有实现选择器对应的方法
- (id)performSelector:(SEL)selector parameters:(NSArray * _Nullable)parameters error:(NSError * _Nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
