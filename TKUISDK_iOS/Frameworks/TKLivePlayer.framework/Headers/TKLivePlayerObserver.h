/**
 * Copyright (c) 2021 talkcloud. All rights reserved.
 * Module:   TKLivePlayerObserver
 * Function: 云直播的播放器回调通知
 * <H2>功能
 * 云直播的播放器回调通知。
 * <H2>介绍
 * 可以接收 {@link TKLivePlayer} 播放器的一些回调通知，包括播放器状态、播放音量回调、音视频首帧回调、统计数据、警告和错误信息等。
 */
#import <TKLivePlayer/TKLiveDef.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TKLivePlayer;

@protocol TKLivePlayerObserver <NSObject>

@optional

/////////////////////////////////////////////////////////////////////////////////
//
//     直播播放器事件回调
// 注⚠️：回调均非主线程
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 直播播放器错误通知，播放器出现错误时，会回调该通知
 *
 * @param player    回调该通知的播放器对象。
 * @param code      错误码 {@link TKLiveCode}。
 * @param msg       错误信息。
 * @param extraInfo 扩展信息。
 */
- (void)onError:(id<TKLivePlayer>)player code:(TKLiveCode)code message:(NSString *)msg extraInfo:(NSDictionary *)extraInfo;

/**
 * 直播播放器警告通知
 *
 * @param player    回调该通知的播放器对象。
 * @param code      警告码 {@link TKLiveCode}。
 * @param msg       警告信息。
 * @param extraInfo 扩展信息。
 */
- (void)onWarning:(id<TKLivePlayer>)player code:(TKLiveCode)code message:(NSString *)msg extraInfo:(NSDictionary *)extraInfo;

/**
 * 直播播放器分辨率变化通知
 *
 * @param player    回调该通知的播放器对象。
 * @param width     视频宽。
 * @param height    视频高。
 */
- (void)onVideoResolutionChanged:(id<TKLivePlayer>)player width:(NSInteger)width height:(NSInteger)height;

/**
 * 已经成功连接到服务器
 *
 * @param player    回调该通知的播放器对象。
 * @param extraInfo 扩展信息。
 */
- (void)onConnected:(id<TKLivePlayer>)player extraInfo:(NSDictionary *)extraInfo;

/**
 * 直播播放器视频状态变化通知
 *
 * @param player    回调该通知的播放器对象
 * @param status    状态码 {@link TKLivePlayerStatus TKLiveDef.h}
 * @param reason    状态对应的原因 {@link TKLiveStatusChangeReason TKLiveDef.h}
 * @param extraInfo 扩展信息
 */
- (void)onVideoPlayStatusUpdate:(id<TKLivePlayer>)player status:(TKLivePlayerStatus)status reason:(TKLiveStatusChangeReason)reason extraInfo:(NSDictionary *)extraInfo;

/**
 * 直播播放器音频状态变化通知
 *
 * @param player    回调该通知的播放器对象
 * @param status    状态码 {@link TKLivePlayerStatus TKLiveDef.h}
 * @param reason    状态对应的原因 {@link TKLiveStatusChangeReason TKLiveDef.h}
 * @param extraInfo 扩展信息
 */
- (void)onAudioPlayStatusUpdate:(id<TKLivePlayer>)player status:(TKLivePlayerStatus)status reason:(TKLiveStatusChangeReason)reason extraInfo:(NSDictionary *)extraInfo;

/**
 * 视频播放事件
 *
 * @param player    回调该通知的播放器对象。
 * @param firstPlay 第一次播放标志。
 * @param extraInfo 扩展信息。
 */
- (void)onVideoPlaying:(id<TKLivePlayer>)player firstPlay:(BOOL)firstPlay extraInfo:(NSDictionary *)extraInfo;

/**
 * 音频播放事件
 *
 * @param player    回调该通知的播放器对象。
 * @param firstPlay 第一次播放标志。
 * @param extraInfo 扩展信息。
 */
- (void)onAudioPlaying:(id<TKLivePlayer>)player firstPlay:(BOOL)firstPlay extraInfo:(NSDictionary *)extraInfo;

/**
 * 视频加载事件
 *
 * @param player    回调该通知的播放器对象。
 * @param extraInfo 扩展信息。
 */
- (void)onVideoLoading:(id<TKLivePlayer>)player extraInfo:(NSDictionary *)extraInfo;

/**
 * 音频加载事件
 *
 * @param player    回调该通知的播放器对象。
 * @param extraInfo 扩展信息。
 */
- (void)onAudioLoading:(id<TKLivePlayer>)player extraInfo:(NSDictionary *)extraInfo;

/**
 * 播放器音量大小回调
 *
 * @param player 回调该通知的播放器对象。
 * @param volume 音量大小。
 * @note  调用 {@link enableVolumeEvaluation} 开启播放音量大小提示之后，会收到这个回调通知。
 */
- (void)onPlayoutVolumeUpdate:(id<TKLivePlayer>)player volume:(NSInteger)volume;

/**
 * 直播播放器统计数据回调
 *
 * @param player     回调该通知的播放器对象。
 * @param statistics 播放器统计数据 {@link TKPlayerStatistics}。
 */
- (void)onStatisticsUpdate:(id<TKLivePlayer>)player statistics:(TKLivePlayerStatistics *)statistics;


/**
 * 截图回调
 *
 * @note  调用 [snapshot](@ref TKLivePlayer#snapshot) 截图之后，会收到这个回调通知
 * @param player 回调该通知的播放器对象
 * @param image  已截取的视频画面
 */
- (void)onSnapshotComplete:(id<TKLivePlayer>)player image:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
