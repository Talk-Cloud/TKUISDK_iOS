//
//  NSString+TKStringSize.h
//  DISPApp
//
//  Created by ganchaobo on 2017/8/16.
//  Copyright © 2017年 dashuf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TKStringSize)

- (CGFloat) widthWithFont : (UIFont *)font height:(CGFloat) height;

/*
* 计算高度方法1
*
*/
- (CGFloat) heightWithFont : (UIFont *)font width:(CGFloat) width;
/*
 * 计算高度方法2
 *
 */
-(CGFloat) calheightWithFont:(UIFont *)font width:(CGFloat)width;

@end
