//
//  TKMJRefreshTrailer.h
//  TKMJRefresh
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#if __has_include(<TKMJRefresh/TKMJRefreshComponent.h>)
#import <TKMJRefresh/TKMJRefreshComponent.h>
#else
#import <TKExtension/TKMJRefreshComponent.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TKMJRefreshTrailer : TKMJRefreshComponent

/** 创建trailer*/
+ (instancetype)trailerWithRefreshingBlock:(TKMJRefreshComponentAction)refreshingBlock;
/** 创建trailer */
+ (instancetype)trailerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 忽略多少scrollView的contentInset的right */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetRight;


@end

NS_ASSUME_NONNULL_END
