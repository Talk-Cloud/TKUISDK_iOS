//
//  TKAIConversationManager.h
//  TKRoomSDK
//
//  Created by 涂远友 on 2026/8/10.
//  Copyright © 2026 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TKAIConversationState) {
    TKAIConversationState_IDLE = 0,
    TKAIConversationState_UnKnown,
    TKAIConversationState_Failed,
    TKAIConversationState_Stopped,
    TKAIConversationState_Starting,
    TKAIConversationState_Started,
    TKAIConversationState_Listening,
    TKAIConversationState_Thinking,
    TKAIConversationState_Speaking,
    TKAIConversationState_Interrupted,
    TKAIConversationState_DoneSpeaking,
};


@interface TKAIAgentConfig : NSObject

/// AI最大空置时间，表示超过最大空置时间后，AI会自动关闭
@property(nonatomic, assign) NSInteger maxIdleTime;
/// AI启动欢迎语
@property(nonatomic, copy) NSString *welcomeMessage;

@end

@interface TKAILLMConfig : NSObject
///
@property(nonatomic, copy) NSString *LLMType;
@property(nonatomic, copy) NSString *Model;
@property(nonatomic, copy) NSString *APIKey;
@property(nonatomic, copy) NSString *APIUrl;
@property(nonatomic, copy) NSString *systemPrompt;
@property(nonatomic, assign) NSInteger history;
@end

@interface TKAITTSConfig : NSObject
@property(nonatomic, copy) NSString *TTSType;
@property(nonatomic, copy) NSString *APIKey;
@property(nonatomic, copy) NSString *voiceType;
@property(nonatomic, copy) NSString *Model;
@property(nonatomic, assign) NSInteger speed;
@property(nonatomic, assign) NSInteger volume;
@property(nonatomic, copy) NSString *emotionCategory;
@end

@interface TKAIConversationConfig : NSObject
/// 必须参数
@property(nonatomic, strong) TKAIAgentConfig * _Nonnull agentConfig;
/// 可选参数，大模型类型参数
@property(nonatomic, strong) TKAILLMConfig * _Nullable LLMConfig;
/// 可选参数，TTS参数
@property(nonatomic, strong) TKAITTSConfig * _Nullable TTSConfig;
@end

@protocol TKAIConversationListener <NSObject>

- (void)onAIConversationStateChange:(NSString *)roomId state:(TKAIConversationState)state;
- (void)onAIConversationError:(NSString *)roomId error:(NSInteger)error errorInfo:(NSString *)errorInfo;
- (void)onAIConversationText:(NSString *)roomId text:(NSDictionary *)msg;
@end

@interface TKAIConversationManager : NSObject
- (instancetype)init NS_UNAVAILABLE;
///
/// @return 0 成功,  非0 失败
- (int)startAIConversation:(TKAIConversationConfig *)config;
/// @return 0 成功,  非0 失败
- (int)stopAIConversation;

- (void)addListener:(id<TKAIConversationListener>)listener;

- (void)removeListener:(id<TKAIConversationListener>)listener;

@end

NS_ASSUME_NONNULL_END
