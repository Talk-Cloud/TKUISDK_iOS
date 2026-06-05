//
//  TKWBCoursewareCaptureHandler.h
//  TKUISDK
//
//  Copyright © talkcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TKBaseViewController;

NS_ASSUME_NONNULL_BEGIN

/// 课件区截屏结果：预览弹窗、保存相册动效、添加小白板（逻辑从 TKBaseViewController 抽离）
@interface TKWBCoursewareCaptureHandler : NSObject

@property (nonatomic, weak) TKBaseViewController *hostViewController;

/// 展示截屏预览（`TKWhiteBoardDidTakeScreenShot` 回调里调用）
- (void)presentPanelForImage:(UIImage *)image;

/// 退出教室时清理弹窗与保存动效视图
- (void)cleanupWhenExitClassroom;

@end

NS_ASSUME_NONNULL_END
