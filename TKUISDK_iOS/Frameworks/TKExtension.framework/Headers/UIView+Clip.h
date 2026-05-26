//
//  UIView+Clip.h
//  BasicFrame
//
//  Created by Jessica on 2018/12/10.
//  Copyright © 2018 Jessica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Clip)
/**
 四个角切圆角

 @param radius 圆角大小
 */
-(void)clipToBoundsRadius:(CGFloat)radius;


/**
 指定角切圆

 @param radius 圆角大小
 @param corners 指定的角
 */
-(void)clipToBoundsRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;


@end
