//
//  TKPlaybackTimeView.h
//  TKUIDEMO
//
//  Created by edy on 2025/7/31.
//  Copyright © 2025 李合意. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define sAllTime NSLocalizedString(@"Playback.allTime", nil)

@interface TKPlaybackTimeView : UIView

@property (nonatomic, copy) void(^selectedTimeBlock)(NSString *selectTime);


/// 显示选择时间弹框
/// - Parameters:
///   - containerView: 父视图
///   - targetView: 基于展示的试图
///   - currentTime: 当前时间
+ (TKPlaybackTimeView *)showPopViewAddedTo:(UIView *)containerView pointingAtView:(UIView *)targetView currentTime:(NSString *)currentTime;

@end

NS_ASSUME_NONNULL_END
