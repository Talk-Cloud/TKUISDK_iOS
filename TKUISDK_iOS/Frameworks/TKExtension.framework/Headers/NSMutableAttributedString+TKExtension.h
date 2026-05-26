//
//  NSMutableAttributedString+TKExtension.h
//  XView
//
//  Created by liujinfeng on 2018/6/4.
//  Copyright © 2018年 Cilan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (TKExtension)
- (void)setFont:(UIFont *)font;
- (void)setFont:(UIFont *)font range:(NSRange)range;
- (void)setColor:(UIColor *)color;
- (void)setColor:(UIColor *)color range:(NSRange)range;
- (void)setLineSpacing:(CGFloat)lineSpacing;

@end
