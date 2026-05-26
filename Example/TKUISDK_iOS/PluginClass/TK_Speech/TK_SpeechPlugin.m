//
//  TK_SpeechPlugin.m
//  TKUIDEMO
//
//  Created by EDY on 2022/10/20.
//  Copyright © 2022 李合意. All rights reserved.
//

#import "TK_SpeechPlugin.h"
#import <MicrosoftCognitiveServicesSpeech/SPXSpeechApi.h>
#import <AVFoundation/AVFoundation.h>
#import <TKMediaEngine/TKMediaDefines.h>

@interface TK_SpeechPlugin()

@property (nonatomic, strong) SPXPushAudioInputStream *stream;
//语音识别
@property (nonatomic, strong) SPXSpeechRecognizer *speechRecognizer;
//语音翻译
@property (nonatomic, strong) SPXTranslationRecognizer *translationRecognizer;

@property (nonatomic, strong) TKAudioFrame *frame;
//老师说话的语言
@property (nonatomic, copy) NSString *speakLanguage;
//字幕展示的语言
@property (nonatomic, copy) NSString *showLanguage;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *region;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int errorNum;

@end

@implementation TK_SpeechPlugin

- (void)stopContinuousRecognition {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.stream close];
        [self.speechRecognizer stopContinuousRecognition];
        [self.translationRecognizer stopContinuousRecognition];
        [self invalidateTimer];
        self.frame = nil;
    });
}

- (void)initSpeechWithToken:(NSString *)token region:(NSString *)region speakLanguage:(NSString *)speakLanguage showLanguage:(NSString *)showLanguage {
    
    self.token = token;
    self.region = region;
    self.speakLanguage = speakLanguage;
    self.showLanguage = showLanguage;
    
    [self timer];
}

-(void)refreshSpeechToken:(NSString *)token {
    self.token = token;
    [self.speechRecognizer setAuthorizationToken:token];
    [self.translationRecognizer setAuthorizationToken:token];
}

//写入数据
- (void)writeAudioFrame:(TKAudioFrame *)frame {
    if (frame.samplesPerSec != self.frame.samplesPerSec || frame.bytesPerSample != self.frame.bytesPerSample || frame.channels != self.frame.channels) {
        
        if (!self.speakLanguage.length || !self.showLanguage.length || !self.token.length || !self.region.length) {
            return;
        }
        self.frame = frame;
        
        SPXAudioStreamFormat *audioFormat = [[SPXAudioStreamFormat alloc] initUsingPCMWithSampleRate:frame.samplesPerSec bitsPerSample:frame.bytesPerSample * 8 channels:frame.channels];
        self.stream = [[SPXPushAudioInputStream alloc] initWithAudioFormat:audioFormat];
        
        //如果说的语言和展示的语言一致，直接语音识别，否则语音翻译
        if ([self.speakLanguage isEqualToString:self.showLanguage]) {
            [self initSpeechRecognizer];
        } else {
            [self initTranslationRecognizer];
        }
        
    }
        
    [self.stream write:[self dataByFrame:frame]];
}

//语音识别
-(void)initSpeechRecognizer{
    //初始化之前先关闭，否则卡线程
    [self.speechRecognizer stopContinuousRecognition];
    
    SPXAudioConfiguration* audioConfig = [[SPXAudioConfiguration alloc] initWithStreamInput:self.stream];
    SPXSpeechConfiguration *speechConfig = [[SPXSpeechConfiguration alloc] initWithAuthorizationToken:self.token region:self.region];

    self.speechRecognizer = [[SPXSpeechRecognizer alloc] initWithSpeechConfiguration:speechConfig language:self.speakLanguage audioConfiguration:audioConfig];
    __weak typeof(self)weakSelf = self;
    [self.speechRecognizer addRecognizingEventHandler:^(SPXSpeechRecognizer * recognizer, SPXSpeechRecognitionEventArgs * eventArgs) {
        weakSelf.errorNum = 0;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:TKShowSpeechSubtitle object:eventArgs.result.text];
        });
    }];
    [self.speechRecognizer addRecognizedEventHandler:^(SPXSpeechRecognizer * recognizer, SPXSpeechRecognitionEventArgs * eventArgs) {
        weakSelf.errorNum = 0;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:TKShowSpeechSubtitle object:eventArgs.result.text];
        });
    }];
    [self.speechRecognizer addCanceledEventHandler:^(SPXSpeechRecognizer * recognizer, SPXSpeechRecognitionCanceledEventArgs * eventArgs) {
        SPXCancellationDetails *details = [[SPXCancellationDetails alloc] initFromCanceledRecognitionResult:eventArgs.result];
        if (details.reason == SPXCancellationReason_Error) {
            if (weakSelf.errorNum < 5) {
                weakSelf.frame = nil;
            }
            weakSelf.errorNum ++;
        }
    }];
      
    [self.speechRecognizer startContinuousRecognition];
        
}

//语音翻译
-(void)initTranslationRecognizer{
    //初始化之前先关闭，否则卡线程
    [self.translationRecognizer stopContinuousRecognition];

    SPXAudioConfiguration* audioConfig = [[SPXAudioConfiguration alloc] initWithStreamInput:self.stream];
    SPXSpeechTranslationConfiguration *translationConfiguration = [[SPXSpeechTranslationConfiguration alloc] initWithAuthorizationToken:self.token region:self.region];
    [translationConfiguration setSpeechRecognitionLanguage:self.speakLanguage];
    [translationConfiguration addTargetLanguage:self.showLanguage];

    self.translationRecognizer = [[SPXTranslationRecognizer alloc] initWithSpeechTranslationConfiguration:translationConfiguration audioConfiguration:audioConfig];
    __weak typeof(self)weakSelf = self;
    [self.translationRecognizer addRecognizingEventHandler:^(SPXTranslationRecognizer * recognizer, SPXTranslationRecognitionEventArgs * eventArgs) {
        weakSelf.errorNum = 0;
        NSString *str = [eventArgs.result.translations objectForKey:weakSelf.showLanguage];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:TKShowSpeechSubtitle object:str ?: @""];
        });
    }];
    [self.translationRecognizer addRecognizedEventHandler:^(SPXTranslationRecognizer * recognizer, SPXTranslationRecognitionEventArgs * eventArgs) {
        weakSelf.errorNum = 0;
        NSString *str = [eventArgs.result.translations objectForKey:weakSelf.showLanguage];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:TKShowSpeechSubtitle object:str ?: @""];
        });
    }];
    [self.translationRecognizer addCanceledEventHandler:^(SPXTranslationRecognizer * recognizer, SPXTranslationRecognitionCanceledEventArgs * eventArgs) {
        SPXCancellationDetails *details = [[SPXCancellationDetails alloc] initFromCanceledRecognitionResult:eventArgs.result];
        if (details.reason == SPXCancellationReason_Error) {
            if (weakSelf.errorNum < 5) {
                weakSelf.frame = nil;
            }
            weakSelf.errorNum ++;
        }
    }];
    
    [self.translationRecognizer startContinuousRecognition];
}

- (NSData *) dataByFrame:(TKAudioFrame *)frame {
    
    int len = (int)frame.samplesPerSec / 1000 * (int)frame.channels * 10 * (int)frame.bytesPerSample;
    NSData * buffer = [NSData dataWithBytes:frame.buffer length:len];
    return buffer;
}

- (void)invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerAction:(NSTimer *)timer {
    [[TKEduClassManager shareInstance] refreshVoiceSign];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:8 * 60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end
