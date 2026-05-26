//
//  TKUntilTool.h
//  TKExtension
//
//  Created by zjt on 2024/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKUntilTool : NSObject

/// 签名
/// - Parameters:
///   - ts: ts
///   - roomid: 房间号
///   - userName: 名称
+ (NSString*)headUtilTkSignTimeStamp:(NSString*)ts roomid:(NSString *)roomid userName:(NSString *)userName;

#pragma mark - SYS
/// 处理JoinRoomUrl
/// - Parameter string: URLstring
+ (NSString *)checkJoinRoomPathUrl:(NSString *)string;

///获取根控制器
+ (UIViewController *)appRootViewController;

/// 获取当前系统语言
+(NSString*)getAgreementLanguage;

/// 刘海屏
+ (BOOL)isiPhoneX;



#pragma mark - NSString
/// 编码
/// - Parameter string:string
+(NSString *)URLEncodedString:(NSString *)string;

/// 解码
/// - Parameter string:string
+(NSString *)URLDecodedString:(NSString *)string;

/// Url验证
/// - Parameter host: UrlString
+(BOOL)isDomain:(NSString *)host;

/// 字符串判空对象
/// - Parameter str: str
+ (BOOL)isEmpty:(NSString *)str;

/// 字符串判空@" "
/// - Parameter str: str
+  (BOOL)isBlankStr:(NSString *)str;

#pragma mark - Data
/// 获取当前时间戳
+ (NSTimeInterval)getNowTimeTimestamp;


@end

NS_ASSUME_NONNULL_END
