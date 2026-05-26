//
//  TKWhiteBoardManager.h
//  TKWhiteBoard
//
//  Created by MAC-MiNi on 2018/4/9.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TKWhiteBoardManagerDelegate.h"
@class TKDrawView;
@class DocShowView;

@class TKWBRoomConfiguration;
@class TKFileModel;

typedef NS_ENUM(NSInteger, TKWBIsolateStageState) {
    TKWBIsolateStageDefault = 0, // 默认状态
    TKWBIsolateStageOn, // 上台
    TKWBIsolateStageOff // 下台
};


NS_ASSUME_NONNULL_BEGIN

typedef void(^pageControlRemarkBlock)(NSDictionary *remark);
typedef void(^handleH5DataBlock)(NSString *);

@interface TKWhiteBoardManager : NSObject

@property (nonatomic, copy) pageControlRemarkBlock  pageControlMarkBlock;// 课件备注

@property (nonatomic, weak) id<TKWhiteBoardManagerDelegate> delegate;

@property (nonatomic, strong) TKFileModel * fModel;         // 当前加载的文档模型.

/// 答辩教室的默认课件（开启数据隔离时对当前 fModel 做的一次 copy，后续 fModel 变更不影响此引用）
@property (nonatomic, strong) TKFileModel * replayDefaultfModel;
@property (nonatomic, assign, readonly) BOOL isShowOnWeb;   // 是否web加载;
@property (nonatomic, assign) BOOL isOnScreenShare;         // 是否正在屏幕共享中(不包含媒体共享)
@property (nonatomic, strong) UIColor * whiteBoardBgColor;  //白板背景色
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableDictionary * whiteBoardCustomBgDic;//自动以白板背景数据
@property (nonatomic, strong) NSMutableArray * usableServerHostArr;//可用的
@property (nonatomic, copy) NSString * serverDocAddrKey;    //文档服务器地址
@property (nonatomic, assign) BOOL inhibitTurnPage; //是否禁止翻页
@property (nonatomic, assign) BOOL isRestricted; //网页是否被限制

@property (nonatomic, copy, nullable) NSString * recoredId;    //录制音频id

@property (nonatomic,copy)  NSString * wbToken; // 教室内部token
@property (nonatomic,copy)  NSString * wbLang; // 教室语言 en/zh/fr 默认en

/**
 单例
 */
+ (instancetype)shareInstance;

// 创建白板组件
- (UIView *)createWhiteBoardWithFrame:(CGRect)frame;

/**
 销毁白板
 */
+ (void)destroy;

/**
 注册白板 代理和配置
 */
- (void)registerDelegate:(id<TKWhiteBoardManagerDelegate>)delegate configration:(NSDictionary *)config;

// 同步加载课件
- (int)showDocumentWithFileDic:(NSDictionary *)fileDic isPubMsg:(BOOL)isPubMsg;

// 同步课件给指定用户
- (void)showDocumentWithFileDic:(NSDictionary *)fileDic isPubMsg:(BOOL)isPubMsg toPeerID:(NSString*)toId;

// 重置白板所有的数据
- (void)resetWhiteBoardAllData;

// 刷新白板
- (void)refreshWhiteBoard;

// 刷新 webview scrollview offset (键盘消失 webview 不弹回)
- (void)refreshWBWebViewOffset:(CGPoint) point;

/**
 清空所有数据
 */
- (void)clearAllData;

/**
 重新加载白板  @此方法仅供白板测试使用
 */
- (void)webViewReload;

// 音频录制
- (void)recordAudioUploadUrl:(NSString *)url_str;

//语音结束
- (void)speechEvaluatuonResult:(CGFloat)score isSuccess:(BOOL)success;

//语音开始回调
- (void)startSpeechEvaluatuonSuccess:(BOOL)success;

// 获取外播视图
- (UIView *)getWhiteBoardOutplayView;

// 获取drawView
- (NSDictionary *)getWhiteBoarddrawDictionary;

-(TKDrawView *)getWhiteBoardDraw;

-(DocShowView *)getWhiteBoardDocView;


#pragma mark - 画笔控制
// 选择工具
- (void)brushToolsDidSelect:(TKBrushToolType)BrushToolType;

// 选择图形
- (void)didSelectDrawType:(TKDrawType)type color:(NSString *)hexColor widthProgress:(float)progress;

#pragma mark - 课件控制
/**
 课件 上一页
 */
- (void)previousPage;

/**
 课件 下一页
 */
- (void)nextPage;

/// 课件同步
/// @param isSync 是否打开同步按钮
/// @param need 需不需要立刻发信令通知别人
-(void)coursewareSync:(BOOL)isSync needPubMsg:(BOOL)need;

/**
 课件 跳转页

 @param pageNum 页码
 */
- (void)turnToPage:(int)pageNum;


/// 课件 跳转页
/// @param pageNum 页码
/// @param step 帧数
- (void)turnToPage:(int)pageNum frameStep:(int)step;

/**
 白板 放大
 */
- (void)enlarge;

/**
 白板 缩小
 */
- (void)narrow;

/**
 白板 重置大小
 */
- (void)resetEnlarge;

/**
 白板 重置课件内点击事件
 */
- (void)resetCourseAction;

//得到h5回调数据 妙小程定制
- (void)setHandleH5DataBlock:(handleH5DataBlock)block;

- (void)setH5DocumentCustomMessage:(id)data;

//h5课件内视频状态变化
-(void)videoStatusChange:(NSString *)status;

//ppt课件内配置修改
-(void)pptVideoOptionsChange:(BOOL)notPlayAV;

// 白板内部的房间状态 是否是答辩教室
@property (nonatomic,assign) BOOL wbStageIsolation;
- (void)showWhiteBoardReplayState:(TKWBIsolateStageState)state;

NS_ASSUME_NONNULL_END
@end
