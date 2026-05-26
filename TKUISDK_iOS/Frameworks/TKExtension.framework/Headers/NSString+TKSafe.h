//
//  NSString+TKSafe.h
//  TKExtension
//
//  Created by edy on 2026/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TKSafe)

/// 判断是不是“可用字符串”
/// - Parameter value: 值
+(BOOL)isValidString:(NSString *)value;


/// url编码
/// - Parameter url: 值
+(NSString *)uRLDecode_TKsafe:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
