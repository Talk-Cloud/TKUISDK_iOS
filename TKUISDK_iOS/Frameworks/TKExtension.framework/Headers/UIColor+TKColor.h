//
//  UIColor+TKColor.h
//  TKExtension
//
//  Created by zjt on 2024/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TKColor)
/**
 *  字符串转色值
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha;
/**
 UIColor 转 6位十六进制字符串 #开头
 */
+ (NSString *) hexColorStringWithColor:(UIColor *)color;

UIColor * HexRGB(char *hex);
UIColor * HexRGBA(char *hex, float alpha);
@end

NS_ASSUME_NONNULL_END
