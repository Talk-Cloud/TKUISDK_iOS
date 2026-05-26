//
//  TKLiveCodes.h
//  TKLivePlayer
//
//  Created by tyy on 2023/4/26.
//

#ifndef TKLiveCodes_h
#define TKLiveCodes_h

/**
 * Copyright (c) 2021 talkcloud. All rights reserved.
 * Module:   TKLiveCode
 * Function: 云直播服务(LVB)错误码和警告码的定义。
 */
#import <Foundation/Foundation.h>

/////////////////////////////////////////////////////////////////////////////////
//
//      错误码和警告码
//
/////////////////////////////////////////////////////////////////////////////////

/**
 *  错误码和警告码
 */
typedef NS_ENUM(NSInteger, TKLiveCode) {

    /// 没有错误。
    TKPLAYER_OK = 0,

    /// 暂未归类的通用错误。
    TKPLAYER_ERROR_FAILED = -1,

    ///调用 API 时，传入的参数不合法。
    TKPLAYER_ERROR_INVALID_PARAMETER = -2,

    /// API 调用被拒绝。
    TKPLAYER_ERROR_REFUSED = -3,

    ///当前 API 不支持调用。
    TKPLAYER_ERROR_NOT_SUPPORTED = -4,

    /// 请求服务器超时。
    TKPLAYER_ERROR_REQUEST_TIMEOUT = -6,

    /// 服务器无法处理您的请求。
    TKPLAYER_ERROR_SERVER_PROCESS_FAILED = -7,

    /// 连接断开。
    TKPLAYER_ERROR_DISCONNECTED = -8,
    
    TKPLAYER_ERROR_CONNECTED_FAILED = -9,
    TKPLAYER_ERROR_CLOSED = -10,


    /////////////////////////////////////////////////////////////////////////////////
    //
    //      网络相关的警告码
    //
    /////////////////////////////////////////////////////////////////////////////////

    /// 网络状况不佳：上行带宽太小，上传数据受阻。
    TKPLAYER_WARNING_NETWORK_BUSY = 1101,

    ///当前视频播放出现卡顿。
    TKPLAYER_WARNING_VIDEO_BLOCK = 2105,
    
    
    TKPLAYER_WARNING_DEVICE_WARNING = 3100,
};

#endif /* TKLiveCodes_h */
