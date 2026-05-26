//
//  TKUMShareSettings.m
//  EduClass
//
//  Created by talkcloud on 2020/8/25.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#import "TKUMShareSettings.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMConfigure.h>
// 需要更换为 贵司 ID
#define TK_WX_AppKey @"wxf447f8f7e427fae2"
#define TK_WX_Secret @"1b8e8d1ef8478b1c3de177f85d52677c"
#define TK_universal_Link @"https://global.talk-cloud.net/class/"

// 友盟统计 AppKey
#define kUMAnalyticsKey ((IS_PAD) ? @"5ec3b680167edd3d63000028" : @"5ec4a829167edd1e170001a6")
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

@interface TKUMShareSettings ()


@end

@implementation TKUMShareSettings

///MARK: - 插件
- (void)umen {
    
    
}

+ (void) UMShareSettings {
    
    // U-Share 平台设置
        [self confitUShareSettings];
        
        [self configUSharePlatformsWechatAppKey:TK_WX_AppKey appSecret:TK_WX_Secret];
    //    [self configUSharePlatformsQQAppKey:@"" appSecret:@""];
    //    [self configUSharePlatformsSinaAppKey:@"" appSecret:@"" redirectURL:@""];
}

+ (void)confitUShareSettings
{
     [UMConfigure initWithAppkey:kUMAnalyticsKey channel:@"UM-iOS"];
    
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
//    [UMSocialGlobal shareInstance].universalLinkDic =
//        @{@(UMSocialPlatformType_WechatSession):TK_universal_Link,
//          @(UMSocialPlatformType_WechatTimeLine):TK_universal_Link,
//          @(UMSocialPlatformType_Qzone):TK_universal_Link,
//          @(UMSocialPlatformType_QQ):TK_universal_Link};
    
    [UMSocialGlobal shareInstance].universalLinkDic =
    @{@(UMSocialPlatformType_WechatSession):TK_universal_Link,
      @(UMSocialPlatformType_WechatTimeLine):TK_universal_Link};
}

+ (void)configUSharePlatformsWechatAppKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:appKey appSecret:appSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:appKey appSecret:appSecret redirectURL:@"http://mobile.umeng.com/social"];
}

+ (void)configUSharePlatformsQQAppKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
}

+ (void)configUSharePlatformsSinaAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL {
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

@end
