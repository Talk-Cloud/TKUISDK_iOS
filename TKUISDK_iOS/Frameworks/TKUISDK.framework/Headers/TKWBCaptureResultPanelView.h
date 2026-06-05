//
//  TKWBCaptureResultPanelView.h
//  TKUISDK
//
//  Copyright © talkcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 课件区截屏结果预览：关闭不保存；下载写入相册；添加小白板由外部实现。
@interface TKWBCaptureResultPanelView : UIView

@property (nonatomic, strong) UIImage *image;
/// 未上课等为 NO 时「添加到小白板」置灰且不可点
@property (nonatomic, assign) BOOL addToMiniWhiteBoardEnabled;

@property (nonatomic, copy, nullable) void (^onClose)(void);
@property (nonatomic, copy, nullable) void (^onDownload)(UIImage *image);
@property (nonatomic, copy, nullable) void (^onAddToMiniWhiteBoard)(UIImage *image);

+ (instancetype)showInView:(UIView *)hostView
                     image:(UIImage *)image
addToMiniWhiteBoardEnabled:(BOOL)addToMiniWhiteBoardEnabled;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
