//
//  TKLivePlayerFactory.h
//  TKLivePlayer
//
//  Created by tyy on 2023/5/29.
//

#import <Foundation/Foundation.h>
#import <TKLivePlayer/TKLiveDef.h>
NS_ASSUME_NONNULL_BEGIN

@class TKLivePlayer;
@class TKVodPlayer;
@protocol TKLivePlayerObserver;
@protocol TKVodPlayerDelegate;
@interface TKLivePlayerManager : NSObject

+ (instancetype)shareInstance;
+ (void)destroy;
- (instancetype)init NS_UNAVAILABLE;
- (int)setLogLevel:(TKLiveLogLevel)level debugToConsole:(BOOL)debug;

/**
 *  创建 直播播放器
 *  @param uniqueID 业务侧自身维护的用户/设备id，根据此 ID 进行问题索引和排查，
 *  @param delegate   注册代理回调对象
 *  @return 返回值 TKLivePlayer 播放器实例对象
 */
- (TKLivePlayer *)createLivePlayerWithUniqueID:(NSString *)uniqueID delegate:(id<TKLivePlayerObserver>)delegate;
- (void)destroyLivePlayer:(TKLivePlayer *)livePlayer;

/**
 *  创建 点播播放器
 *  @param uniqueID 业务侧自身维护的用户/设备id，根据此 ID 进行问题索引和排查，
 *  @param delegate   注册代理回调对象
 *  @return 返回值 TKVodPlayer 播放器实例对象
 */
- (TKVodPlayer *)createVodPlayerWithUniqueID:(NSString *)uniqueID delegate:(id<TKVodPlayerDelegate>)delegate;
- (void)destroyVodPlayer:(TKVodPlayer *)vodPlayer;

/**
 * 获取sdk版本
 * @return 返回值 版本号。
 */
- (NSString *)getSDKVersion;

@end

NS_ASSUME_NONNULL_END
