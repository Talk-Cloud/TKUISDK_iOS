//
//  TKEduClassManager.h
//  TKUISDK
//
//  Created by talkcloud on 2019/9/24.
//  Copyright © 2019 talkcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKEduRoomDelegate.h"
@class TKCheckDeviceVC;
NS_ASSUME_NONNULL_BEGIN

/// joinRoomWithParamDic / joinPlaybackRoomWithParamDic：进房流程进行中，请勿重复调用
FOUNDATION_EXPORT NSInteger const TKJoinRoomResultBusy;

@interface TKEduClassManager : NSObject

/// 是否在刷新教室
@property (nonatomic,assign) BOOL isRefreshClassRoom;

/// 是否允许网络状态上传 默认为NO
@property (nonatomic, assign, readonly) BOOL upload;

/// checkRoom成功后 房间属性
 @property (nonatomic, strong)NSDictionary *roomJson;

/// 外部连接打开
@property (nonatomic, assign) BOOL  isUrlOpen;


+ (instancetype)shareInstance;

/**
 进入房间的函数

 @param paramDic NSDictionary类型，键值需要传递serial（NSString * 课堂号）、
 userrole(NSNumber * 学生 2,老师 0,旁听生 6, 巡课 4 ,家长 27
 nickname（NSString * 用户昵称）、
 userid(NSString * 用户ID，选填)、
 password(NSString * 密码 有则传)、
 language(NSString *语言，选填)
 userids(NSArray *[用户ID,用户ID], 家长身份选填绑定自己的学生)
 @param controller 当前页面的控制器，通常与下边delegate相同
 @param delegate 遵循TKEduEnterClassRoomDelegate代理，供给用户进行处理
 @param isFromWeb 是否是从网址链接进入进入
 @return 0 成功发起进房；-1 参数/权限等失败；-2 进房流程进行中（TKJoinRoomResultBusy）
 */
- (int)joinRoomWithParamDic:(NSDictionary*)paramDic ViewController:(UIViewController*)controller Delegate:(id<TKEduRoomDelegate>)delegate isFromWeb:(BOOL)isFromWeb;

/**
 进入回放房间的函数
 @param paramDic NSDictionary类型， 键值需要传递serial（NSString * 课堂号）、
 recordtitle(NSString * 根据后台返回的回放标题)、
 userid(NSString * 用户ID，选填 传入后只播放除老师外该id的音视频)、
 reportUserID(NSString * 用户ID，选填 如需打点上报为必选参数)、
 userids(NSArray *[用户ID,用户ID], 选填 传入后只播放除老师外该id的音视频)
 pauseOnAppBackground(NSString * 0 || 1, 选填 传入控制是否需要回放进入后台停播)
 @param controller 当前页面的控制器，通常与下边delegate相同
 @param delegate 遵循TKEduEnterClassRoomDelegate代理，供给用户进行处理
 @param isFromWeb 是否是从网址链接进入进入
 @return 0 成功发起进房；-1 失败；-2 进房流程进行中（TKJoinRoomResultBusy）
 */
- (int)joinPlaybackRoomWithParamDic:(NSDictionary *)paramDic ViewController:(UIViewController*)controller Delegate:(id<TKEduRoomDelegate>)delegate isFromWeb:(BOOL)isFromWeb;


/**
 进入MP4回放的函数  ( 只传playUrl 仅播放 不上报打点日志,  如需打点上报 serial ,userId,recordTitle,playUrl,startTime 为必选参数)
 @param  configDic NSDictionary 类型
 serial  (NSString* 课堂号)
 userId  (NSString*  用户ID)
 recordTitle (NSString* 视频标题)
 playUrl (NSString* 播放路径, 必选)
 startTime ( long long 开始播放时间（毫秒）)
 playType (颜色模式  NSInteger 0 浅色 1深色) //非必选默认0
 pauseOnAppBackground (NSNumber* 0.不暂停  1暂停) //非必选默认0
 @param vc 控制器用于弹出播放页面
 */
- (void)joinMp4PlayBackWithConfigDic:(NSDictionary *)configDic vc:(UIViewController *)vc;

/// 从网页链接进入房间(直播\回放)
/// @param url urlPath
- (void)joinRoomWithUrl:(NSString*)url;

/// AppDelegate  applicationDidBecomeActive 请调用此方法
- (void)applicationDidBecomeActive;

/// 是否显示课程结束后的web页面, 默认根据后台配置的地址 是否显示.
/// @param isShow 是否显示
- (void)showEndClassWebPage:(BOOL)isShow;

/// 更新语音识别的令牌
- (void)refreshVoiceSign;

/// 课程结束后的web页面, 默认显示后台配置地址.
/// @param url 地址, 默认拼接 教室号和教室名称
- (void)endClassUrl:(NSString *)url;

/// 设备检测
/// @param domain  企业域名
/// @param userid  用户id
/// @param checkCallback 摄像头是正常使用 麦克风是否开启 系统音量 延迟数据(ms) 上传速率(kbps) 下载速率(kbps)
-(void)showDeviceStatusCheckDomain:(NSString *)domain  userid:(NSString *)userid callBack:(void (^_Nullable)(BOOL, BOOL, NSInteger, NSInteger, NSInteger, NSInteger))checkCallback;

/// 是否允许网络状态上传
/// @param upload 默认为no
-(void)allowUploadCheckResult:(BOOL)upload;

/// 进程将被杀死
- (void)applicationWillTerminate;

/// 离开房间
- (void)leaveRoom;

@end


NS_ASSUME_NONNULL_END
