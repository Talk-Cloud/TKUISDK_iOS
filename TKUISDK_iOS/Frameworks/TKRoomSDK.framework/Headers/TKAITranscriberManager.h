//
//  AITranscriberManager.h
//  TKRoomSDK
//
//  Created by 涂远友 on 2026/8/5.
//  Copyright © 2026 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TKAITranscriberState) {
    TKAITranscriber_IDLE = 0,
    TKAITranscriber_Starting,
    TKAITranscriber_Started,
    TKAITranscriber_Failed,
    TKAITranscriber_Stopped,
};

/// 实时AI语音转录配置参数
@interface TKAITranscriberParams : NSObject
/// 目标转录用户ID和需要转录语言，字典
/// @note Specifies the language of the source audio.
/// Key is the translation userID, and value is  the translation language code (e.g., "zh", "en").
/// Supported languages are as follows : "zh"(Chinese)，"en"(English)，"fr"(French)，"ja"(Japanese)，"ko"(Korean)，"es"(Spanish)，"id"(Indonesian)，"vi"(Vietnamese).
/// eg: @{  @"userid1" : @"en",
///       @"userid2" : @"fr" }
@property(nonatomic, strong) NSDictionary<NSString *, NSString *> *userIdsToTranscribe;
/// 是否开启语音识别， 默认NO
@property(nonatomic, assign) BOOL enableRecognition;

@end

/// 实时AI语音转录事件回调
@protocol TKAITranscriberListener <NSObject>
@optional

/**
 * Real-time transcription state change callback.
 * @param roomId Room ID
 */
- (void)onSpeechTranscriberStateChange:(NSString *)roomId AITranscriberState:(TKAITranscriberState)state;

/**
 * Receive transcription message callback.
 *
 * The transcription service pushes the recognized text and translation results to you in real-time through this callback.
 * @param roomId Room ID
 * @param message Transcription message.
 */
- (void)onSpeechReceiveTranscriberMessage:(NSString *)roomId message:(NSDictionary *)message;


/**
 * Real-time transcription error callback.
 *
 * Received when an error occurs in the real-time transcription service.
 * @param roomId Room ID
 * @param error Error code
 * @param errorInfo Error information
 */
- (void)onSpeechTranscriberError:(NSString *)roomId error:(NSInteger)error errorInfo:(NSString *)errorInfo;

@end

/// 实时AI语音转录管理类
@interface TKAITranscriberManager : NSObject
/**
 * The AITranscriberManager object cannot be created directly. Use the {@link getAITranscriberManager} interface in TKRoomManager to obtain it.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * 开启实时AI语音转录
 * @param params Transcription parameters, including list of user IDs to transcribe, and target translation languages. For details, please refer to {@link TKAITranscriberParams}.
 * 需进入教室后调用相关接口，才能生效
 * @return 0表示调用成功，非0表示调用失败
 */
- (int)startSpeechTranslation:(TKAITranscriberParams *)params;

/**
 * 设置翻译目标语言，
 * Supported languages are as follows : "zh"(Chinese)，"en"(English)，"fr"(French)，"ja"(Japanese)，"ko"(Korean)，"es"(Spanish)，"id"(Indonesian)，"vi"(Vietnamese).
 * 需进入教室后调用相关接口，才能生效
 */
- (int)setTranslationLanguages:(NSArray *)langs;

/**
 * 停止实时AI语音转录
 * 需进入教室后调用相关接口，才能生效
 */
- (int)stopSpeechTranslation;

/**
 * 添加实时AI语音转录事件回调
 * @param listener Transcription event listener
 */
- (void)addListener:(id<TKAITranscriberListener>)listener;

/**
 * 移除实时AI语音转录事件回调
 * @param listener Transcription event listener
 */
- (void)removeListener:(id<TKAITranscriberListener>)listener;
@end

NS_ASSUME_NONNULL_END
