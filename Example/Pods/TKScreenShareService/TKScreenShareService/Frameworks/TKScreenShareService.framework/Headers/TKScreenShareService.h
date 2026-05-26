//
//  TKScreenShareService.h
//  TKScreenShareService
//
//  Created by MAC-MiNi on 2019/1/14.
//  Copyright © 2019年 MAC-MiNi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReplayKit/ReplayKit.h>

API_AVAILABLE(ios(11.0))
@protocol TKScreenShareServiceDelegate <NSObject>

@required
- (void)TKScreenShareServiceFinishBroadcastWithError:(NSError *)error;

@end

API_AVAILABLE(ios(11.0))
@interface TKScreenShareService : NSObject

@property (weak, nonatomic) id<TKScreenShareServiceDelegate> delegate;
//@property (copy, nonatomic) NSString *appGroup;

- (instancetype)initWithAppGroup:(NSString *)appGroup;

- (int)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo;

- (int)broadcastPaused;

- (int)broadcastResumed;

- (int)broadcastFinished;

- (int)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType;

- (int)TKScreenShareServiceFinishBroadcastWithError:(NSError *)error;
@end


