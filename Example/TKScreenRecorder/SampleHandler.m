//
//  SampleHandler.m
//  TKScreenRecord
//
//  Created by 涂远友 on 2022/5/30.
//  Copyright © 2022 beijing. All rights reserved.
//


#import "SampleHandler.h"
#import <TKScreenShareService/TKScreenShareService.h>
#import <CoreMedia/CoreMedia.h>
#import <VideoToolbox/VideoToolbox.h>

@interface SampleHandler()

@property (strong, nonatomic) TKScreenShareService *shareService;

@end

@implementation SampleHandler


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _shareService = [[TKScreenShareService alloc] initWithAppGroup:@"group.TalkCloudPlusScreenRecord"];
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                        (__bridge const void *)(self),
                                        StopScreenRecord,
                                        CFSTR("stopScreenRecord"),
                                        NULL,
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
    }
    
    return self;
}

#pragma 停止屏幕共享
void StopScreenRecord(CFNotificationCenterRef center,
                      void *observer, CFStringRef name,
                      const void *object, CFDictionaryRef
                      userInfo)
{
    SampleHandler *self = (__bridge SampleHandler *)(observer);
    NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:0 userInfo:@{NSLocalizedFailureReasonErrorKey:NSLocalizedString(@"TKScreenShare.Stop", nil)}];
    [self finishBroadcastWithError:error];
}

- (void)handleStopScreenRecordNotification:(NSNotification *)notify
{
   
}

- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
    NSLog(@"broadcastStartedWithSetupInfo");
        //通知屏幕采集进程 开始屏幕直播
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                         CFSTR("ScreenbroadcastStarted"),NULL,nil,YES);
    [_shareService broadcastStartedWithSetupInfo:setupInfo];
}

- (void)broadcastPaused {
    // User has requested to pause the broadcast. Samples will stop being delivered.
    NSLog(@"broadcastPaused");
}

- (void)broadcastResumed {
    // User has requested to resume the broadcast. Samples delivery will resume.
    NSLog(@"broadcastResumed");

}

- (void)broadcastFinished {
    // User has requested to finish the broadcast.
    NSLog(@"broadcastFinished");
    [self.shareService broadcastFinished];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
                                         CFSTR("ScreenbroadcastFinished"),NULL,nil,YES);
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    
    switch (sampleBufferType) {
        case RPSampleBufferTypeVideo:
            // Handle video sample buffer
            [_shareService processSampleBuffer:sampleBuffer withType:sampleBufferType];
            break;
        case RPSampleBufferTypeAudioApp:
            // Handle audio sample buffer for app audio
            break;
        case RPSampleBufferTypeAudioMic:
            // Handle audio sample buffer for mic audio
            break;
            
        default:
            break;
    }
}
@end
