//
//  TKVodDownloadManager.h
//  TKLivePlayer
//
//  Created by 涂远友 on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 下载错误码
 */
typedef NS_ENUM(NSInteger, TKVodDownloadError) {
    /// 下载成功
    TKDownloadSuccess = 0,
    //// fileid鉴权失败
//    TKDownloadAuthFaild = -5001,
    /// 无此清晰度文件
    TKDownloadNoFile = -5003,
    /// 格式不支持
    TKDownloadFormatError = -5004,
    /// 网络断开
    TKDownloadDisconnet = -5005,
    /// 获取HLS解密key失败
    TKDownloadHlsKeyError = -5006,
    /// 下载目录访问失败
    TKDownloadPathError = -5007,
    /// 鉴权信息不通过，如签名过期或者请求不合法
    TKDownload403Forbidden = -5008,
    TKDownloadInvalidDownloadStatusCode = -5009,
    
    TKDownloadInvalidDownloadSessionCode = -5010,
    KDownloadInvalidDownloadCancelCode = -5011
};

@class TKVodDownloadMediaInfo;

@protocol TKVodDownloadDelegate <NSObject>

- (void)onDownloadStart:(TKVodDownloadMediaInfo *)mediaInfo;
- (void)onDownloadProgress:(TKVodDownloadMediaInfo *)mediaInfo;
- (void)onDownloadStop:(TKVodDownloadMediaInfo *)mediaInfo;
- (void)onDownloadFinish:(TKVodDownloadMediaInfo *)mediaInfo;
- (void)onDownloadError:(TKVodDownloadMediaInfo *)mediaInfo errorCode:(TKVodDownloadError)code errorMsg:(NSString *)msg;


@end

@interface TKVodDownloadManager : NSObject
/**
 * 下载任务回调
 */
@property(nonatomic, weak) id<TKVodDownloadDelegate> delegate;


+ (TKVodDownloadManager *)shareInstance;
/**
 * 设置下载文件的根目录。
 *
 * @discussion 此处设置的下载目录优先以 ‘ TXPlayerGlobalSetting #setCacheFolderPath’ 设置为准
 * @param path 目录地址，如不存在，将自动创建
 * @warning 开始下载前必须设置，否则不能下载
 */
- (void)setDownloadPath:(NSString *)path;


/**
 * 下载文件
 *
 * @param url url
 */
- (TKVodDownloadMediaInfo *)startDownloadWithUrl:(NSString *)url;

/**
 * 下载文件
 *
 * @param url 下载地址，必选参数，否则下载失败
 * @param resolution 偏好清晰度, 多清晰度url为必选参数,值为偏好清晰度宽x高(如720p传入921600=1280*720), 单清晰度传入-1
 * @param  username 账户名称,可选参数, 不传默认为"default"
 * @return 成功返回下载对象，否则nil
 */
//- (TKVodDownloadMediaInfo *)startDownloadWithUrl:(NSString *)url resolution:(long)resolution;


/**
 * 停止下载
 *
 *
 * @param media 停止下载对象
 */
- (void)stopDownload:(TKVodDownloadMediaInfo *)media;

/**
 * 删除下载产生的文件
 *
 * @param playPath 待删除的文件路径，此参数可以通过TXVodDownloadMediaInfo对象属性来获取
 * @return 文件正在下载将无法删除，返回NO
 */
- (BOOL)deleteDownloadFile:(NSString *)playPath;

/**
 * 删除下载信息
 *
 * @param downloadMediaInfo 下载的MediaInfo信息
 * @return 文件正在下载将无法删除，返回NO
 */
- (BOOL)deleteDownloadMediaInfo:(TKVodDownloadMediaInfo *)downloadMediaInfo;

/**
 * 获取下载列表
 * 调用此接口要确保之前通过 startDownload及相关接口启动过下载任务
 *
 * @return 返回查询到的下载文件信息列表
 */
- (NSArray<TKVodDownloadMediaInfo *> *)getDownloadMediaInfoList;
@end

NS_ASSUME_NONNULL_END
