//
//  TKCheckDeviceTool.h
//  TKUISDK
//
//  Created by WS on 2021/12/7.
//  Copyright © 2021 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKCheckDeviceTool : NSObject

/// 根据音量分贝 将音量划分等级
/// @param lowPassResults 音量分贝
+(void)getDownLoadTime:(void(^)(NSInteger))completion;
+(void)getNetStandardWithHttp:(NSString *)http host:(NSString *)host completion:(void(^)(void))completion;
+(void)delayTestDataWithHttp:(NSString *)http host:(NSString *)host completion:(void(^)(NSInteger delay, NSInteger speed))completion;
+(void)uploadTestDataWithHttp:(NSString *)http host:(NSString *)host completion:(void(^)(NSInteger delay, NSInteger speed))completion;
+(NSInteger)downStream_bad;
+(NSInteger)downStream_generally;
+(NSInteger)upStream_bad;
+(NSInteger)upStream_generally;

+(int)prepareVolume:(CGFloat)lowPassResults;

@end

NS_ASSUME_NONNULL_END
