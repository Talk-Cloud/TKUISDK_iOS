//
//  TKMJRefreshNormalHeader.h
//  TKMJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include(<TKMJRefresh/TKMJRefreshStateHeader.h>)
#import <TKMJRefresh/TKMJRefreshStateHeader.h>
#else
#import <TKExtension/TKMJRefreshStateHeader.h>

#endif

NS_ASSUME_NONNULL_BEGIN

@interface TKMJRefreshNormalHeader : TKMJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
@property (weak, nonatomic, readonly) UIActivityIndicatorView *loadingView;


/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle TKMJRefreshDeprecated("first deprecated in 3.2.2 - Use `loadingView` property");
@end

NS_ASSUME_NONNULL_END
