//
//  TKVodPlayer.h
//  TKLivePlayer
//
//  Created by 涂远友 on 2024/12/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TKLivePlayer/TKLiveDef.h>

NS_ASSUME_NONNULL_BEGIN


@class TKVodPlayer;
@protocol TKVodPlayerDelegate <NSObject>
@optional
 
- (void)onPlayEvent:(TKVodPlayer *)vodPlayer event:(TKVodEventID)EvtID withParam:(NSDictionary*)param;
 
- (void)onNetStatus:(TKVodPlayer *)vodPlayer withParam:(NSDictionary*)param;

@end

@interface TKVodPlayer : NSObject

/**
 * 是否循环播放
 */
@property (nonatomic, assign) BOOL loop;
 

/* setupContainView 创建Video渲染View,该控件承载着视频内容的展示。
 * @param view 父view
 * @param idx Widget在父view上的层级位置
 */
 
- (void)setupVideoWidget:(UIView *)view;

/**
 * 移除Video渲染View
 */
- (void)removeVideoWidget;

/**
 * 设置播放开始时间
 * 在startPlay前设置，修改开始播放的起始位置， 秒
 */
- (void)setStartTime:(CGFloat)startTime;

/**
 * startPlay 启动从指定URL播放
 *
 * @param url 完整的URL(如果播放的是本地视频文件，这里传本地视频文件的完整路径)
 * @return 0 = OK
 */
- (int)startPlay:(NSString *)url;

/**
 * 停止播放音视频流
 * @return 0 = OK
 */
- (int)stopPlay;

/**
 * 是否正在播放
 */
- (bool)isPlaying;

/**
 * 暂停播放
 */
- (void)pause;

/**
 * 继续播放
 */
- (void)resume;

/**
 * 播放跳转到音视频流某个时间
 * @param time 流时间，单位为秒
 * @return 0 = OK
 */
- (int)seek:(float)time;

/**
 * 获取当前播放时间，单位为秒
 */
- (float)currentPlaybackTime;

/**
 * 获取视频总时长，单位为秒
 */
- (float)duration;

/**
 * 可播放时长，单位为秒
 */
- (float)playableDuration;

/**
 * 视频宽度
 */
- (int)width;

/**
 * 视频高度
 */
- (int)height;

/**
 * 设置画面的方向
 * @param rotation 方向
 * @see TKVideoRotation
 */
- (void)setRenderRotation:(TKLiveRotation)rotation;

/**
 * 设置画面的裁剪模式
 * @param renderMode 裁剪
 * @see TKLiveFillMode
 */
- (void)setRenderMode:(TKLiveFillMode)renderMode;


/**
 * 设置静音
 */
- (void)setMute:(BOOL)bEnable;

/**
 * 设置音量大小
 * @param volume 音量大小。范围：0 ~ 100。
 */
- (void)setAudioPlayoutVolume:(int)volume;

/**
 * 设置播放速率
 * @param rate 正常速度为1.0；只支持范围是0.5- 2.0
 */
- (void)setRate:(float)rate;

/**
 * 设置画面镜像
 */
- (void)setMirror:(BOOL)isMirror;


@end

NS_ASSUME_NONNULL_END
