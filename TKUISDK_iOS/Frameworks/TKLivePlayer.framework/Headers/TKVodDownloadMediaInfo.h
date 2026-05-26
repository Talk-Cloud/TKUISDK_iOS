//
//  TKVodDownloadMediaInfo.h
//  TKLivePlayer
//
//  Created by 涂远友 on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 下载状态
 */
typedef NS_ENUM(NSInteger, TKVodDownloadMediaInfoState) {

    /// 初始化状态
    TKVodDownloadMediaInfoStateInit = 0,

    /// 启动
    TKVodDownloadMediaInfoStateStart = 1,

    /// 停止
    TKVodDownloadMediaInfoStateStop = 2,

    /// 错误
    TKVodDownloadMediaInfoStateError = 3,

    /// 下载完成
    TKVodDownloadMediaInfoStateFinish = 4,
};


@interface TKVodDownloadMediaInfo : NSObject

/**
 * 下载地址（使用私有加密下载时，请使用fileid对象下载）
 */
@property(nonatomic, copy) NSString *url;

/**
 * 任务 id，唯一表示下载任务
 */
@property(nonatomic, copy) NSString *taskId;

/**
 * 时长，单位：秒
 */
@property(nonatomic, assign) int duration;
 
/**
 * 文件总大小，单位：byte
 */
@property(nonatomic, assign) long size;

/**
 * 已下载大小，单位：byte
 */
@property(nonatomic, assign) long downloadSize;

/**
 * 进度
 */
@property(nonatomic, assign) float progress;

/**
 * 播放路径，视频下载完成后可传给TKVodPlayer进行本地文件播放
 *
 * @discussion 此参数用于下载播放时，需要通过getDownloadMediaInfoList或 getDownloadMediaInfo: 接口获取得到，不可以私下保存
 */
@property(nonatomic, copy) NSString *playPath;

/**
 * 下载速度，byte每秒
 */
@property(nonatomic, assign) int speed;

/**
 * 下载状态
 */
@property(nonatomic, assign) TKVodDownloadMediaInfoState downloadState;


/**
 * 下载是否已完成
 */
- (BOOL)isDownloadFinished;
@end

NS_ASSUME_NONNULL_END
