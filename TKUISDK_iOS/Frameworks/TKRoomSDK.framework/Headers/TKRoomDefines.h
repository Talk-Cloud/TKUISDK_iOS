//
//  TKRoomDefines.h
//  TKRoomSDK
//
//  Created by MAC-MiNi on 2018/4/20.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "TKRoomCode.h"

#define TK_Deprecated(string) __attribute__((deprecated(string)))

#
#pragma mark - joinroom 相关定义
#
//******调用joinroom 接口进入房间，roomParams字典参数所需 Key值定义******//
//房间ID @required
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsRoomIDKey;
//密码key值 @required，如果该房间或者该用户角色没有密码，value：@""
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsPasswordKey;

//用户角色key值 @optional
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsUserRoleKey;
//用户ID的key值 @optional，如果不传用户ID，sdk会自动生成用户ID
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsUserIDKey;

#pragma mark  joinroom token方式
//如果使用token的方式join room，需要roomParams中添加以下参数

//token
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsToken;
//时间戳，token权限时间
FOUNDATION_EXTERN NSString * const TKJoinRoomParamsPrivilegeExpiredTs;


#
#pragma mark - pub/delete msg 相关定义
#
//******调用pubMsg以及delMsg 接口发送信令，toID参数相关传值；表示：此信令需要通知的对象******//
//所有人
FOUNDATION_EXTERN NSString * const TKRoomPubMsgTellAll;
//除自己以外的所有人
FOUNDATION_EXTERN NSString * const TKRoomPubMsgTellAllExceptSender;
//除旁听用户以外的所有人
FOUNDATION_EXTERN NSString * const TKRoomPubMsgTellAllExceptAuditor;
//不通知任何人
FOUNDATION_EXTERN NSString * const TKRoomPubMsgTellNone;

#
#pragma mark -  房间初始化相关设置
#
//******调用- (int)initWithAppKey:optional: 初始化设置 optional字典 key值定义*******//

//使用token方式进入教室，初始化需要传入企业域名
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalCompanyDomain;

//socekt 自动重连次数，默认是无限次
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalReconnectattempts;

//若有使用到sdk白板功能，需要设置此参数，表示会接收到白板消息通知。 若不是用sdk白板功能，可不需要设置。
//value：NSNumber类型 YES表示接受通知，NO表示不通知。
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalWhiteBoardNotify;

// 是否中断进入房间, 发送的TKRoomManagerContinueCheckRoomNotification通知以便继续进入房间.
// Paas 接入方式无需设置.
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalInteruptCheckRoom;

// UI Version
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalUIVersion;
//tk_ui_uniform_version
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalUIUniformVersion;

//设置编码格式 @optional Key值，可不传，若不传会根据房间属性设置。 value：NSNumber类型 TKVideoCodecType枚举值
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalVideoCodec;
//设置即时房间类型 @optional Key值，可不传，默认是一对多TKRoomType_More。 value：NSNumber类型 TKRoomTypes枚举值
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalRoomType;

FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalGetRoomFile;

FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalUserAgent;
//value值：BOOL类型，YES表示关闭获取位置服务，NO表示开启获取位置服务
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalByPassLocation TK_Deprecated("TKRoomSDK 5.0 deprecated.");

#pragma mark socekt使用协议参数
//value: NSNumber类型 YES:使用https wss, NO:使用http ws  默认为YES。
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalSecureSocket;

#pragma mark - 私有部署房间相关
//私有地址  默认为global.talk-cloud.net
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalPrivateHostAddress;
//私有端口  如果TKRoomSettingOptionalSecureSocket 设置为YES，默认为443；如果TKRoomSettingOptionalSecureSocket 设置为NO，默认为80.
// ***TKRoomSettingOptionalSecureSocket优先.***
FOUNDATION_EXTERN NSString * const TKRoomSettingOptionalPrivatePort;

#
#pragma mark - block重命名
#
typedef void (^completion_block)(NSError *error);
//typedef void (^progress_block)(int playID, int64_t current, int64_t total);


typedef NS_ENUM(NSInteger, TKLocalMediaPlayingStateCode) {
    TKLocalMediaPlayingState_Playing = 710,
    TKLocalMediaPlayingState_Paused = 711,
    TKLocalMediaPlayingState_Stopped = 713,
    TKLocalMediaPlayingState_Failed = 714,
};

typedef void (^TKLocalMediaProgress_block)(int playID, int64_t current, int64_t total);
typedef void (^TKLocalMediaState_block)(int playID, TKLocalMediaPlayingStateCode stateCode);

#
#pragma mark - TKAppScene 使用场景
#
typedef NS_ENUM(NSInteger, TKAppScene) {
    TKAppScene_Call    = 0,  //默认场景，适用于[1对1视频通话]、[300人视频会议]、[在线问诊]、[教育小班课]、[远程面试]等业务场景。
    TKAppScene_Live    = 1,  //适用于直播带货等
};

#
#pragma mark - TKMediaType 媒体类型
#
typedef NS_ENUM(NSInteger, TKMediaType) {
    TKMediaSourceType_unknow    = -1,
    TKMediaSourceType_camera    = 0,      //视频
    TKMediaSourceType_mic       = 11,
    TKMediaSourceType_file      = 101,    //本地电影共享
    TKMediaSourceType_screen    = 102,    //屏幕共享
    TKMediaSourceType_media     = 103,    //媒体文件 mp4、mp3
};

#
#pragma mark - TKPublishState 发布状态
#
typedef NS_ENUM(NSInteger, TKPublishState) {
    TKUser_PublishState_UNKown          = -2,                //未知状态
    TKUser_PublishState_NONE            = 0,          //没有
    TKUser_PublishState_AUDIOONLY,                  //只有音频
    TKUser_PublishState_VIDEOONLY,                  //只有视频
    TKUser_PublishState_BOTH,                       //都有
    TKUser_PublishState_Extension,                 //4表示在台上，但音视频均为打开
};
#
#pragma mark - TKMediaState 媒体流发布状态
#
typedef NS_ENUM(NSInteger, TKMediaState) {
    TKMedia_Unpulished  = 0,  //未发布
    TKMedia_Pulished    = 1,    //发布
};

#
#pragma mark - TKVideoStreamType 视频流类型
#
typedef NS_ENUM(NSInteger, TKVideoStreamType) {
    TKVideoStream_Big   = 0,  //
    TKVideoStream_Small = 1,    //小流
};

#
#pragma mark - TKVideoCodecType 视频编码格式
#
typedef NS_ENUM(NSUInteger, TKVideoCodecType) {
    TKVideoCodec_VP8 = 0,       //vp8
    TKVideoCodec_H264 = 2,      //h264
};

#
#pragma mark - TKRoomType 即时房间类型
#
typedef NS_ENUM(NSUInteger, TKRoomTypes) {
    TKRoomType_One = 0,       //一对一房间
    TKRoomType_More = 1,      //一对多房间
};

#
#pragma mark - TKRenderMode 渲染模式
#
typedef NS_ENUM(NSInteger, TKRenderMode) {
    TKRenderMode_fit       = 0,  //等比拉伸
    TKRenderMode_adaptive  = 1,  //等比拉伸，并占满全屏
};

#
#pragma mark - TKRenderState 
#
typedef NS_ENUM(NSInteger, TKRenderState) {
    TKRenderState_Interruption  = 0,   //中断
    TKRenderState_Resumption    = 1,   //恢复
};

#
#pragma mark - TKVideoMirrorMode 视频渲染镜像模式
#
typedef NS_ENUM(NSUInteger, TKVideoMirrorMode) {
    TKVideoMirrorModeAuto       = 0,  //默认设置，前置摄像头时开启镜像模式，后置摄像头时不开启镜像
    TKVideoMirrorModeEnabled    = 1,  //前置和后置均开启镜像模式
    TKVideoMirrorModeDisabled   = 2,  //前置和后置均不开启镜像模式
};

/** Reason for the user being offline. */
typedef NS_ENUM(NSUInteger, TKUserOfflineReason) {
  /** The user left the current channel. */
    TKUserOfflineReasonQuit = 0,
  /** The SDK timed out and the user dropped offline because no data packet is received within a certain period of time. If a user quits the call and the message is not passed to the SDK (due to an unreliable channel), the SDK assumes the user dropped offline. */
    TKUserOfflineReasonDropped = 1,
};
#
#pragma mark - TKLogLevel 日志等级
#
typedef NS_ENUM(NSUInteger, TKLogLevel){
    /**
     *  No logs
     */
    TKLogLevelOff = 0,
    
    /**
     *  Error logs only
     */
    TKLogLevelError = (1 << 0),
    
    /**
     *  Error and warning logs
     */
    TKLogLevelWarning = (TKLogLevelError | 1 << 1),
    
    /**
     *  Error, warning and info logs
     */
    TKLogLevelInfo = (TKLogLevelWarning | 1 << 2),
    
    /**
     *  Error, warning, info and debug logs
     */
    TKLogLevelDebug = (TKLogLevelInfo | 1 << 3),
    
    /**
     *  Error, warning, info, debug and verbose logs
     */
    TKLogLevelVerbose = (TKLogLevelDebug | 1 << 4),
    
    /**
     *  All logs (1...11111)
     */
    TKLogLevelAll = NSUIntegerMax
};

#
#pragma mark - TKUserRoleType 用户角色
#
typedef NS_ENUM(NSInteger, TKUserRoleType) {
    TKUserType_Playback   	= -1,   //回放
    TKUserType_Teacher    	= 0,    //老师
    TKUserType_Assistant  	= 1,    //助教
    TKUserType_Student	  	= 2,    //学生
    TKUserType_Live		  	= 3,    //直播
    TKUserType_Patrol		= 4,    //巡课
    TKUserType_ClassTeacher	= 5,    //班主任
    TKUserType_Onlooker     = 6,    //旁听生
    TKUserType_SystemAdministrator = 26, //系统管理员
    TKUserType_Parent       = 27,   //家长
    TKUserType_WorkorderAdministrator = 31,// 工单管理员
    TKUserType_Record   	= 88,   //录制用户
    TKUserType_Interaction 	= 98,	//交互直播房间直播用户
    TKUserType_Bypass		= 99    //旁路直播房间直播用户
    
};

#
#pragma mark - TKRecordType 录制件类型
#
typedef NS_ENUM(NSInteger, TKRecordType) {
    TKRecordType_RecordFile     = 0,    //生成录制件
    TKRecordType_RecordList     = 1,    //生成录制列表
    TKRecordType_RecordMp3File  = 2, //只生成mp3
    TKRecordType_RecordMaxFile  = 3, //同时生产mp3和mp4
};

#
#pragma mark - TKRecordState 录制状态
#
typedef NS_ENUM(NSInteger, TKRecordState) {
    TKRecordState_Stoped          = 0,    //停止录制
    TKRecordState_Started         = 1,    //开始录制
    TKRecordState_Paused      = 2,        //暂停录制
};

typedef NS_ENUM(NSInteger, TKNetQuality) {
    TKNetQuality_Excellent  = 1, //优
    TKNetQuality_Good,          //良
    TKNetQuality_Accepted,      //中
    TKNetQuality_Bad,           //差
    TKNetQuality_VeryBad,       //极差
    TKNetQuality_Down,
};

typedef NS_ENUM(NSInteger, TKOperator) {
    TKOperator_Greater_Than             = 1,
    TKOperator_Less_Than                = 2,
    TKOperator_Not_Equal                = 3,
    TKOperator_Equal                    = 4,
    TKOperator_Greater_Than_Or_Equal    = 5,
    TKOperator_Less_Than_Or_Equal       = 6,
};

typedef NS_ENUM(NSInteger, TKSampleFormat) {

    TKSampleFormat_None = -1,
    TKSampleFormat_U8,          ///< unsigned 8 bits
    TKSampleFormat_S16,         ///< signed 16 bits
    TKSampleFormat_S32,         ///< signed 32 bits
    TKSampleFormat_FLT,         ///< float
    TKSampleFormat_DBL,         ///< double
    
    TKSampleFormat_U8P,         ///< unsigned 8 bits, planar
    TKSampleFormat_S16P,        ///< signed 16 bits, planar
    TKSampleFormat_S32P,        ///< signed 32 bits, planar
    TKSampleFormat_FLTP,        ///< float, planar
    TKSampleFormat_DBLP,        ///< double, planar
    TKSampleFormat_S64,         ///< signed 64 bits
    TKSampleFormat_S64P,        ///< signed 64 bits, planar
    
    TKAVSampleFormat_NB           ///< Number of sample formats. DO NOT USE if linking dynamically
};

#
#pragma mark - TKULiveStreamInfo 云直播流信息
#
@interface TKULiveStreamInfo : NSObject
/// 流扩展ID， 组成方式为："用户ID:设备ID:流类型"， 设备ID只在多摄情况下才有值，流类型只有在非video时才有值。如："123:abc"，即表示这个流属于ID为123的用户，采集设备的ID为abc。
/// 1、用户为非多摄像头时：
///     1>、streamtype为 @“video” 时，extensionid 与 userid 相同，均为 @“123”
///     2>、streamtype为非 @“video” 时，extensionid 与 userid 不同，如userid：@“123”，extensionid：userid:streamtype(例如 @“123:media”，表示共享媒体流的扩展ID)
/// 2、用户为多摄像头时：
///     1>、streamtype为 @“video” 时, extensionid 与 userid 不同，如userid：@“123”，extensionid：userid:设备ID（如："123:abc"，即表示这个流属于ID为123的用户，采集设备的ID为abc）
///     2>、streamtype为非 @“video” 时，extensionid 与 userid 不同，如userid：@“123”，extensionid：userid:streamtype(例如 @“123:media”，表示共享媒体流的扩展ID)
@property (copy, nonatomic) NSString *extensionid;
/// 发布此流的用户ID
@property (copy, nonatomic) NSString *userid;
/// 流类型。可用值包括 "video"（摄像头/麦克风采集的流），"screen"（桌面共享流），"media"（媒体共享流，如Mp4课件），"file"（本地文件流）
@property (copy, nonatomic) NSString *streamtype;
/// 推流地址（根据 推流方式不同，可以有多种协议方式的推流url）
@property (copy, nonatomic) NSDictionary *pullurl;
@end


#
#pragma mark - TKRtcStats 音视频总统计数据
#
@interface TKRtcStats : NSObject
/**
 上行总字节数
 */
@property (assign, nonatomic) int64_t outBytes;

/**
 下行总字节数
 */
@property (assign, nonatomic) int64_t inBytes;

/**
 上行总包数
 */
@property (assign, nonatomic) NSInteger outPackets;

/**
 下行总包数
 */
@property (assign, nonatomic) NSInteger inPackets;

/**
 上行音频码率 bps
 */
@property (assign, nonatomic) NSInteger outAudioBitRate;

/**
 下行音频码率 bps
 */
@property (assign, nonatomic) NSInteger inAudioBitRate;

/**
 上行视频码率 bps
 */
@property (assign, nonatomic) NSInteger outVideoBitRate;

/**
 下行视频码率 bps
 */
@property (assign, nonatomic) NSInteger inVideoBitRate;

/**
 上行音频丢包率
 */
@property (assign, nonatomic) CGFloat outAudioPacketLostRate;

/**
 下行音频丢包率
 */
@property (assign, nonatomic) CGFloat inAudioPacketLostRate;

/**
 上行视频丢包率
 */
@property (assign, nonatomic) CGFloat outVideoPacketLostRate;

/**
 下行视频丢包率
 */
@property (assign, nonatomic) CGFloat inVideoPacketLostRate;

/**
 上行网络质量
 */
@property (assign, nonatomic) TKNetQuality outNetQuality;

/**
 下行网络质量
 */
@property (assign, nonatomic) TKNetQuality inNetQuality;

/**
 网络质量
 */
@property (assign, nonatomic) TKNetQuality netQuality;

/**
 音频延迟
 */
@property (assign, nonatomic) NSInteger audioDelay;

/**
 视频延迟
 */
@property (assign, nonatomic) NSInteger videoDelay;

/**
 时长
 */
@property (assign, nonatomic) int64_t duration;

/**
 当前 App 的 CPU 使用率 (%)
 */
@property (assign, nonatomic) CGFloat cpuAppUsage;
/**
 当前系统的 CPU 使用率 (%)
 */
@property (assign, nonatomic) CGFloat cpuTotalUsage;
/**
 当前 App 的内存占比 (%)
 */
@property (assign, nonatomic) CGFloat memoryAppUsageRatio;
/**
 当前系统的内存占比 (%)
 */
@property (assign, nonatomic) CGFloat memoryTotalUsageRatio;
/**
 当前 App 的内存大小 (KB)
 */
@property (assign, nonatomic) uint64_t memoryAppUsageInKbytes;
@end

