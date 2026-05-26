//
//  UIButton+TKEdgeInsets.h
//  TKUISDK
//
//  Created by EDY on 2023/2/14.
//  Copyright © 2023 Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ImagePositionType) {
    ImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    ImagePositionTypeRight,  //图片在右，标题在左
    ImagePositionTypeTop,    //图片在上，标题在下
    ImagePositionTypeBottom  //图片在下，标题在上
};

typedef NS_ENUM(NSInteger, EdgeInsetsType) {
    EdgeInsetsTypeTitle,//标题
    EdgeInsetsTypeImage//图片
};

typedef NS_ENUM(NSInteger, MarginType) {
    MarginTypeTop         ,
    MarginTypeBottom      ,
    MarginTypeLeft        ,
    MarginTypeRight       ,
    MarginTypeTopLeft     ,
    MarginTypeTopRight    ,
    MarginTypeBottomLeft  ,
    MarginTypeBottomRight
};

@interface UIButton (TKEdgeInsets)

/// 自定义按钮点击范围
@property (nonatomic, assign) UIEdgeInsets clickSpanInsets;
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  注意：1.该方法需在设置图片和标题之后才调用;
 2.图片和标题改变后需再次调用以重新计算titleEdgeInsets和imageEdgeInsets
 *
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 */
- (void)setImagePositionWithType:(ImagePositionType)type spacing:(CGFloat)spacing;

/**
 *  按钮只设置了title or image，该方法可以改变它们的位置
 *
 *  @param edgeInsetsType description
 *  @param marginType     marginType description
 *  @param margin         margin description
 */
- (void)setEdgeInsetsWithType:(EdgeInsetsType)edgeInsetsType marginType:(MarginType)marginType margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
