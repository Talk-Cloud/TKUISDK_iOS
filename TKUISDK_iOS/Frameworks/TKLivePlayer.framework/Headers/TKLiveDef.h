/**
 * Copyright (c) 2021 talkcloud. All rights reserved.
 * Module:   TKPlayerDef
 * Function: 云直播服务(LVB)关键类型定义
 */
#import <TKLivePlayer/TKLiveCode.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TKLivePlayerType) {
    /// 直播    支持Webrtc、Rtmp、Flv、Hls
    TKLivePlayerType_Live = 0,
    /// 时移直播    只支持HLS
    TKLivePlayerType_TimeShift = 1,
    /// 点播直播    只支持 FLV、HLS
    TKLivePlayerType_Vod = 2,
};


#
#pragma mark - TKVodPlayer Event 点播事件
#
typedef NS_ENUM(NSInteger, TKVodEventID){
    TKVod_Evt_Open_File_Succ          =  1001,     ///< 播放事件: 成功打开播放文件
    TKVod_Evt_Get_PlayInfo_Succ       =  1001,     ///< 播放事件: 成功获取到点播文件的信息
    TKVod_Evt_Play_Prepared           =  1002,     ///< 播放事件: 视频加载完毕
    
    TKVod_Evt_Play_Begin              =  1003,     ///< 播放事件: 播放已经开始
    TKVod_Evt_Play_Pause              =  1004,     ///< 播放事件: 播放已经暂停
    TKVod_Evt_Play_Progress           =  1005,     ///< 播放事件: 播放进度更新
    TKVod_Evt_Play_End                =  1006,     ///< 播放事件: 播放已经结束
    
    TKVod_Evt_Rcv_First_Video_Frame   =  1007,     ///< 播放事件: 成功接受到第一个视频帧
    TKVod_Evt_Rcv_First_Audio_Frame   =  1008,     ///< 播放事件: 成功接受到第一个音频帧
    TKVod_Evt_Play_Loading            =  1009,     ///< 播放事件: 数据缓冲中
    TKVod_Evt_Loading_End             =  10010,     ///< 播放事件: 视频缓冲结束
    TKVod_Evt_Change_Resolution       =  1011,     ///< 播放事件: 视频分辨率发生变化

    TKVod_Evt_Err_Net_Disconnect      = -1101,     ///< 直播错误: 网络连接断开（已经经过三次重试并且未能重连成功）
    TKVod_Evt_Err_File_Not_Found      = -1102,     ///< 点播错误: 播放文件不存在
    TKVod_Evt_Err_Hls_Key             = -1103,     ///< 点播错误: HLS 解码 KEY 获取失败

};

#
#pragma mark - TKLiveLogLevel 日志等级
#
typedef NS_ENUM(NSUInteger, TKLiveLogLevel){
    /// No logs
    TKLiveLogLevelOff = 0,
    /// Error logs only
    TKLiveLogLevelError = (1 << 0),
    /// Error and warning logs
    TKLiveLogLevelWarning = (TKLiveLogLevelError | 1 << 1),
    /// Error, warning and info logs
    TKLiveLogLevelInfo = (TKLiveLogLevelWarning | 1 << 2),
    /// Error, warning, info and debug logs
    TKLiveLogLevelDebug = (TKLiveLogLevelInfo | 1 << 3),
    /// Error, warning, info, debug and verbose logs
    TKLiveLogLevelVerbose = (TKLiveLogLevelDebug | 1 << 4),
    /// All logs (1...11111)
    TKLiveLogLevelAll = NSUIntegerMax
};


/**
 * 视频画面填充模式
 */
typedef NS_ENUM(NSInteger, TKLiveFillMode) {
    /// 图像长边填满屏幕，短边区域会被填充黑色，画面的内容完整。
    TKLiveFillModeFit,
    
    /// 图像铺满屏幕，超出显示视窗的视频部分将被裁剪，画面显示可能不完整。
    TKLiveFillModeFill,
};

/**
 * 视频画面顺时针旋转角度
 */
typedef NS_ENUM(NSInteger, TKLiveRotation) {

    /// 不旋转。
    TKLiveRotation0 = 0,

    /// 顺时针旋转90度。
    TKLiveRotation90 = 90,

    /// 顺时针旋转180度。
    TKLiveRotation180 = 180,

    /// 顺时针旋转270度。
    TKLiveRotation270 = 270,

};

/// @name 音视频状态有关的枚举值的定义
/// @{

/**
 * @brief 音视频状态
 */
typedef NS_ENUM(NSInteger, TKLivePlayerStatus) {

    /// 播放停止
    TKLivePlayerStatusStopped,

    /// 正在播放
    TKLivePlayerStatusPlaying,

    /// 正在缓冲(首次加载不会抛出 Loading 事件)
    TKLivePlayerStatusLoading,

};

/**
 * @brief 音视频状态对应的原因
 */
typedef NS_ENUM(NSInteger, TKLiveStatusChangeReason) {

    /// 内部原因
    TKLiveStatusChangeReasonInternal,

    /// 开始网络缓冲
    TKLiveStatusChangeReasonBufferingBegin,

    /// 结束网络缓冲
    TKLiveStatusChangeReasonBufferingEnd,

    /// 本地启动播放
    TKLiveStatusChangeReasonLocalStarted,

    /// 本地停止播放
    TKLiveStatusChangeReasonLocalStopped,

    /// 远端可播放
    TKLiveStatusChangeReasonRemoteStarted,

    /// 远端流停止或中断
    TKLiveStatusChangeReasonRemoteStopped,

    /// 远端流离线
    TKLiveStatusChangeReasonRemoteOffline,

};


/**
 * 播放器的统计数据
 */
@interface TKLivePlayerStatistics : NSObject

/// 【字段含义】当前 App 的 CPU 使用率（％）。
@property(nonatomic, assign) NSUInteger appCpu;

/// 【字段含义】当前系统的 CPU 使用率（％）。
@property(nonatomic, assign) NSUInteger systemCpu;

/// 【字段含义】视频宽度。
@property(nonatomic, assign) NSUInteger width;

/// 【字段含义】视频高度。
@property(nonatomic, assign) NSUInteger height;

/// 【字段含义】帧率（fps）。
@property(nonatomic, assign) NSUInteger fps;

/// 【字段含义】视频码率（bps）。
@property(nonatomic, assign) NSUInteger videoBitrate;

/// 【字段含义】音频码率（bps）。
@property(nonatomic, assign) NSUInteger audioBitrate;

/// 【字段含义】网络音频丢包率（％），注：仅支持前缀为 [tkrtc://] 或 [webrtc://] 的播放地址。
@property(nonatomic, assign) NSUInteger audioPacketLoss;

/// 【字段含义】网络视频丢包率（％），注：仅支持前缀为 [tkrtc://] 或 [webrtc://] 的播放地址。
@property(nonatomic, assign) NSUInteger videoPacketLoss;

/// 【字段含义】播放延迟（ms）。
@property(nonatomic, assign) NSUInteger jitterBufferDelay;

/// 【字段含义】音频播放的累计卡顿时长（ms）。
/// 该时长为区间（2s）内的卡顿时长。
@property(nonatomic, assign) NSUInteger audioTotalBlockTime;

/// 【字段含义】音频播放卡顿率，单位（％）。
/// 音频播放卡顿率（audioBlockRate） = 音频播放的累计卡顿时长（audioTotalBlockTime） / 音频播放的区间时长（2000ms）。
@property(nonatomic, assign) NSUInteger audioBlockRate;

/// 【字段含义】视频播放的累计卡顿时长（ms）。
/// 该时长为区间（2s）内的卡顿时长。
@property(nonatomic, assign) NSUInteger videoTotalBlockTime;

/// 【字段含义】视频播放卡顿率，单位（％）。
/// 视频播放卡顿率（videoBlockRate） = 视频播放的累计卡顿时长（videoTotalBlockTime） / 视频播放的区间时长（2000ms）。
@property(nonatomic, assign) NSUInteger videoBlockRate;

/// 【字段含义】从 SDK 到云端的往返延时（ms），注：仅支持前缀为 [tkrtc://] 或 [webrtc://] 的播放地址。
@property(nonatomic, assign) NSUInteger rtt;

@end



/////////////////////////////////////////////////////////////////////////////////
//
//          公共配置组件
//
/////////////////////////////////////////////////////////////////////////////////
/**
 * Log配置
 */
@interface TKPlayerLogConfig : NSObject

/// 【字段含义】设置 Log 级别。
/// 【推荐取值】默认值：TKPlayerLogLevelAll。
@property(nonatomic, assign) TKLiveLogLevel logLevel;

/// 【字段含义】是否通过 TKPlayerPremierObserver 接收要打印的 Log 信息。
/// 【特殊说明】如果您希望自己实现 Log 写入，可以打开此开关，Log 信息会通过 TKPlayerPremierObserver#onLog 回调给您。
/// 【推荐取值】默认值：NO。
@property(nonatomic, assign) BOOL enableObserver;

/// 【字段含义】是否允许 SDK 在编辑器（XCoder、Android Studio、Visual Studio 等）的控制台上打印 Log。
/// 【推荐取值】默认值：NO。
@property(nonatomic, assign) BOOL enableConsole;

/// 【字段含义】是否启用本地 Log 文件。
/// 【特殊说明】如非特殊需要，请不要关闭本地 Log 文件，否则腾讯云技术团队将无法在出现问题时进行跟踪和定位。
/// 【推荐取值】默认值：YES。
@property(nonatomic, assign) BOOL enableLogFile;

/// 【字段含义】设置本地 Log 的存储目录，默认 Log 存储位置：
///  iOS & Mac: sandbox Documents/log。
@property(nonatomic, copy, nullable) NSString *logPath;

@end
