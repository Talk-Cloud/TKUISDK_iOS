//
//  TKAPPSetConfig.h
//  EduClass
//
//  Created by maqihan on 2018/11/30.
//  Copyright © 2018 talkcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPluginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKAPPSetConfig : NSObject

typedef NS_ENUM(NSInteger,TKCheckUpdateDuration) {
    TKCheckUpdateDuration_Minute,
    TKCheckUpdateDuration_Hour,
    TKCheckUpdateDuration_Day,
    TKCheckUpdateDuration_Week,
    TKCheckUpdateDuration_Month
};

+ (instancetype)shareInstance;

/**
  是否 同意 用户协议
*/
- (BOOL) isShowServiceAgreementAndprivacyPolicy;

/**
  设置 登录页为 rootviewcontroller
*/
- (void) setLoginViewForRootViewController:(UIWindow *) window;

/**
  获取UISDK版本号
*/
- (NSString *) getUISDKVersion;

/**
  是否隐藏设备检测页(默认显示)
  YES 隐藏
  NO 显示
*/
- (void)isHiddenDeviceCheckView:(BOOL)isHidden;

///下课后学生是否直接离开教室 默认不直接退出
/// @param direct 是否直接退出
- (void)isDirectExit:(BOOL)direct;

/**
  检查更新
*/
- (void)checkForUpdate;


/// 设置检查更新开关
/// - Parameter on: 开关
- (void)setCheckUpdateSwitchOn:(BOOL)on;



/// 设置检查更新开关
/// - Parameters:
///   - on: 开关
///   - domain: 企业domain
///   - versionString: 更新版本:2023010100
///   - source: 来源 如 门课 为4
///   - checkDuration:检查更新频率
- (void)setCheckUpdateSwitchOn:(BOOL)on companyDomain:(NSString *)domain updateVersion:(NSString *)versionString source:(NSString *)source checkDuration:(TKCheckUpdateDuration)checkDuration;

/**
  腾讯COS
*/
- (void)setupCOS;

/**
  加载自定义的loading gif图
  @param path Gif图名字或者GIF图的URL (name传空或者不调用这个方法的话 加载默认的loading)
*/
- (void)roomLoadingImageWithPath:(NSString *)path;


// MARK: - 插件
- (void)registerSharePlusin:(id<TKShareDelegate>)delegate;
- (void)registerSpeechPlusin:(id<TKSpeechDelegate>)delegate;

//- (void)registerBeautyPlusin:(id<TKBeautyDelegate>)delegate;
//- (void)registerLivePlusin:(id<TKLiveDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
