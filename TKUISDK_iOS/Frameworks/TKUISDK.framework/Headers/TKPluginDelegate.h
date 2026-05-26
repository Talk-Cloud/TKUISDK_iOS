//
//  TKPlugInDelegate.h
//  TKUISDK
//
//  Created by Yi on 2020/11/5.
//  Copyright © 2020 Yi. All rights reserved.
//
#import <TKRoomSDK/TKRoomSDK.h>

#ifndef TKPlugInDelegate_h
#define TKPlugInDelegate_h

static NSString *const TKShowSpeechSubtitle = @"showSpeechSubtitle";

// 分享
@protocol TKShareDelegate <NSObject>

@required
- (void) showSharePlatformWithShareDict:(NSDictionary *)shareDict image:(UIImage *)image;
- (BOOL) isInstallPlatform;

@end


@protocol TKSpeechDelegate <NSObject>

/// 初始化参数
/// @param token 微软token
/// @param region 微软region
/// @param speakLanguage 说话语言
/// @param showLanguage 字幕展示语言
- (void)initSpeechWithToken:(NSString *)token region:(NSString *)region speakLanguage:(NSString *)speakLanguage showLanguage:(NSString *)showLanguage;

/// 更新令牌
/// @param token 微软token
-(void)refreshSpeechToken:(NSString *)token;

//写入数据
- (void)writeAudioFrame:(TKAudioFrame *)frame;

//停止
- (void)stopContinuousRecognition;

@end

//// 美颜
//@protocol TKBeautyDelegate <NSObject>
//
//
//
//@end
//
//// 直播
//@protocol TKLiveDelegate <NSObject>
//
//
//
//@end
#endif /* TKPlugInDelegate_h */
