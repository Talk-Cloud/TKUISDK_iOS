//
//  TKMJRefreshBackGifFooter.h
//  TKMJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include(<TKMJRefresh/TKMJRefreshBackStateFooter.h>)
#import <TKMJRefresh/TKMJRefreshBackStateFooter.h>
#else
#import <TKExtension/TKMJRefreshBackStateFooter.h>

#endif

NS_ASSUME_NONNULL_BEGIN

@interface TKMJRefreshBackGifFooter : TKMJRefreshBackStateFooter
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (instancetype)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(TKMJRefreshState)state;
- (instancetype)setImages:(NSArray *)images forState:(TKMJRefreshState)state;
@end

NS_ASSUME_NONNULL_END
