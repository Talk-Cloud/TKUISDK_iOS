

//
//  TKLivePlayeriOS.h
//  TKLivePlayer
//
//  Created by tyy on 2023/4/24.
//

/**
 * Copyright (c) 2021 talkcloud. All rights reserved.
 * Module:   TKLivePlayer
 * Function: 云直播播放器
 * <H2>功能
 * 云直播播放器。
 * 主要负责从指定的直播流地址拉取音视频数据，并进行解码和本地渲染播放。
 * <H2>介绍
 * 播放器包含如下能力：
 * - 支持 RTMP、HTTP-FLV、HLS、WebRTC 协议。
 */

#import <Foundation/Foundation.h>
#import <TKLivePlayer/TKLivePlayerObserver.h>

typedef UIView TKView;
NS_ASSUME_NONNULL_BEGIN

@protocol TKLivePlayer <NSObject>

/////////////////////////////////////////////////////////////////////////////////
//
//                    播放器相关接口
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 设置播放器回调
 *
 * 通过设置回调，可以监听 TKLivePlayer 播放器的一些回调事件，
 * 包括播放器状态、播放音量回调、音视频首帧回调、统计数据、警告和错误信息等。
 * @param delegate 播放器的回调目标对象，更多信息请查看 {@link TKLivePlayerObserver}
 */
- (void)setObserver:(id<TKLivePlayerObserver>)delegate;

/**
 * 设置播放器的视频渲染 View，该控件负责显示视频内容
 *
 * @param view 播放器渲染 View。
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK：成功。
 */
- (TKLiveCode)setRenderView:(TKView *)view;

/**
 * 设置播放器画面的旋转角度
 *
 * @param rotation 旋转角度 {@link TKLiveRotation}。
 *         - TKLiveRotation0【默认值】: 0度, 不旋转。
 *         - TKLiveRotation90:  顺时针旋转90度。
 *         - TKLiveRotation180: 顺时针旋转180度。
 *         - TKLiveRotation270: 顺时针旋转270度。
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)setRenderRotation:(TKLiveRotation)rotation;

/**
 * 设置画面的填充模式
 *
 * @param mode 画面填充模式 {@link TKLiveFillMode}。
 *         - TKLiveFillModeFill 【默认值】: 图像铺满屏幕，不留黑边，如果图像宽高比不同于屏幕宽高比，部分画面内容会被裁剪掉。
 *         - TKLiveFillModeFit: 图像适应屏幕，保持画面完整，但如果图像宽高比不同于屏幕宽高比，会有黑边的存在。
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)setRenderFillMode:(TKLiveFillMode)mode;

/**
 * 开始播放音视频流
 *
 * @param url 音视频流的播放地址，支持 RTMP，HTTP-FLV，HLS,  TKRTC。
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 操作成功，开始连接并播放。
 *         - TKLivePlayer_ERROR_INVALID_PARAMETER：操作失败，url 不合法。
 *         - TKLivePlayer_ERROR_REFUSED：RTC 不支持同一设备上同时推拉同一个 StreamId。
 *         - TKLivePlayer_ERROR_INVALID_LICENSE：licence 不合法，播放失败。
 */
- (TKLiveCode)startPlay:(NSString *)url type:(TKLivePlayerType)playtype;

/**
 * 停止播放音视频流
 *
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)stopPlay;

/**
 * 播放器是否正在播放中
 *
 * @return 是否正在播放。
 *         - 1: 正在播放中。
 *         - 0: 已经停止播放。
 */
- (int)isPlaying;

/**
 * 暂停播放器的音频流
 *
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)muteAudio:(BOOL)mute;

/**
 * 暂停播放器的视频流
 *
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)muteVideo:(BOOL)mute;

/**
 * 设置播放器音量
 *
 * @param volume 音量大小，取值范围0 - 1。【默认值】: 1。
 * @return 返回值 {@link TKLiveCode}。
 *         - TKLivePlayer_OK: 成功。
 */
- (TKLiveCode)setPlayoutVolume:(CGFloat)volume;


/**
 * 截取播放过程中的视频画面。
 *
 * @return 返回值 {@link TKLiveCode}
 *         - TKLivePlayer_OK: 成功
 *         - TKPLAYER_ERROR_REFUSED: 播放器处于停止状态，不允许调用截图操作
 */
- (TKLiveCode)snapshot;

@end


@interface TKLivePlayer : NSObject<TKLivePlayer>

- (instancetype)init NS_UNAVAILABLE;

/**
 * 获取播放器ID
 *
 * 
 * 故此 ID 在一次业务会话中需要唯一，每个用户均不相同。
 * @return 返回值 playerId。
 */
- (NSString *)getPlayerID;

- (void)switchProtocolAndReStartPlay;
@end


NS_ASSUME_NONNULL_END
