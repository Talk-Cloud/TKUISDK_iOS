//
//  TKWhiteBoardDelegate.h
//  TKWhiteBoard
//
//  Created by MAC-MiNi on 2018/4/9.
//  Copyright © 2018年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TKWhiteBoardManagerDelegate <NSObject>

@required

/**
 文件列表回调
 @param fileList 文件列表 是一个NSArray类型的数据
 */
- (void)onWhiteBoardFileList:(NSArray *)fileList;

/**
 返回文档服务器地址
 */
- (void)onWhiteBoardGetServerAddress:(NSString *)serverAddress;

/**
PubMsg消息
 */
- (void)onWhiteBoardPubMsgWithMsgName:(NSString *)msgName msgID:(NSString *)msgID message:(NSDictionary *)message;


/**
回放拖拽消息
 */
- (void)onWhiteBoardPlayBackSeekSharpsMsgWithMsgName:(NSString *)msgName msgID:(NSString *)msgID message:(NSDictionary *)message;

/**
 msglist消息

 @param msgList 消息
 */
- (void)onWhiteBoardOnRoomConnectedMsglist:(NSDictionary *)msgList;

/**
 界面更新
 */
- (void)onWhiteBoardViewStateUpdate:(NSDictionary *)message;
- (void)onWhiteBoardShowOnViewRatioUpdate:(CGFloat)ratio;// 原生加载课件的 ratio 更新

- (BOOL)onWhiteBoardOnRoomContainsUserTKVersionBelowNumber_6;

- (void)onWhiteBoardFileZoomChange:(CGFloat)scale;

//切换课件，老师打开课件同步
- (void)onWhiteBoardChangePageCoursewareSync;
//老师切换课件
- (void)onWhiteBoardEnlargeAvailable:(BOOL)available;

// onRecordAudio 音频录制
- (void)onWhiteBoardRecordAudio_isStart:(BOOL)isStart;

/// 语音评测
/// @param isStart 是否开始 YES:开始 NO:结束
/// @param dic 测评的数据
- (void)onWhiteBoardAssessment:(BOOL)isStart withDate:(NSDictionary *_Nullable)dic;



@end

