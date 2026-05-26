//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+TKMJRefresh.h
//  TKMJRefresh
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新、 左滑刷新的功能

#import <UIKit/UIKit.h>
#if __has_include(<TKMJRefresh/TKMJRefreshConst.h>)
#import <TKMJRefresh/TKMJRefreshConst.h>
#else
#import <TKExtension/TKMJRefreshConst.h>

#endif

@class TKMJRefreshHeader, TKMJRefreshFooter, TKMJRefreshTrailer;

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (TKMJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic, nullable) TKMJRefreshHeader *mj_header;
@property (strong, nonatomic, nullable) TKMJRefreshHeader *header TKMJRefreshDeprecated("使用mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic, nullable) TKMJRefreshFooter *mj_footer;
@property (strong, nonatomic, nullable) TKMJRefreshFooter *footer TKMJRefreshDeprecated("使用mj_footer");

/** 左滑刷新控件 */
@property (strong, nonatomic, nullable) TKMJRefreshTrailer *mj_trailer;

#pragma mark - other
- (NSInteger)mj_totalDataCount;

@end

NS_ASSUME_NONNULL_END
