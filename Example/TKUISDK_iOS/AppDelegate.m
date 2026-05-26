//
//  AppDelegate.m
//  TKUIDEMO
//
//  Created by talkcloud on 2019/10/14.
//  Copyright © 2019 talkcloud. All rights reserved.
//

#import "AppDelegate.h"
#import <TKUISDK/TKUISDK.h>
#import "TKUMShareSettings.h"
#import "TK_SharePlugin.h"
#import "TK_SpeechPlugin.h"
#import "TKLoginViewController.h"

#import <Bugly/Bugly.h>

#if __has_include(<UMShare/UMShare.h>)
#import <UMShare/UMShare.h>
#else
#endif


@interface AppDelegate ()

@property (nonatomic, strong) NSString * roomUrlString;
@property (nonatomic, strong) TK_SharePlugin * sharePlugin;
@property (nonatomic, strong) TK_SpeechPlugin *speechPlugin;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 暂不让UITextview支持shake编辑;
    application.applicationSupportsShakeToEdit = NO;
    
    // 设置拓课云Demo App 检查更新开关on UISDK 不需要此代码
    [[TKAPPSetConfig shareInstance] setCheckUpdateSwitchOn:YES];
    
    // 使用拓课云登录界面
    [[TKAPPSetConfig shareInstance] setLoginViewForRootViewController:self.window];
    
    TKLoginViewController * loginVC = [[TKLoginViewController alloc] init];
    self.window.rootViewController = nil;
    self.window.rootViewController = loginVC;
    
    // 加载自定义GIF图
    [[TKAPPSetConfig shareInstance] roomLoadingImageWithPath:@""];
    
    
    BOOL isAllow = [[TKAPPSetConfig shareInstance] isShowServiceAgreementAndprivacyPolicy];
    if (isAllow) {
        [self initThirdSDK];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allowServiceAgreement) name:@"TKAllowServiceAgreementAndprivacyPolicy" object:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinRoomComplete:) name:@"joinRoomComplete" object:nil];
    return YES;
}

- (void) allowServiceAgreement {
    // 第三方SDK初始化会短暂阻塞主线程，所以延时0.1秒 使隐私协议页正常移除。
    [self performSelector:@selector(afterTimes) withObject:nil afterDelay:0.1];
}

- (void) afterTimes {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TKAllowServiceAgreementAndprivacyPolicy" object:nil];
    
    [self initThirdSDK];
    
    if (self.roomUrlString) {
        
        [[TKEduClassManager shareInstance] joinRoomWithUrl:self.roomUrlString];
//        [TKEduClassManager shareInstance].isUrlOpen = YES;//记录外部链接打开
        
        self.roomUrlString = nil;
    }
}

- (void) initThirdSDK {
    
    // 初始化 bugly（非必须、如果使用拓课云buglyID，版本号需要使用下面方法从SDK获取）
    BuglyConfig *bc = [BuglyConfig new];
    bc.version = [[TKAPPSetConfig shareInstance] getUISDKVersion];
    
    // 添加
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"sys-clientVersion"];
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"TKStandard_%@",versionString]];
    
#ifdef DEBUG

    [Bugly startWithAppId:@"9a3ae3c354" config:bc];

#else
    
    [Bugly startWithAppId:@"9950489142" config:bc];

#endif
    
    [self addTKSharePlugin];
    
    [self addTKSpeechPlugin];
}

- (void)joinRoomComplete:(NSNotification *)notify {
    NSDictionary *userinfo = notify.object;
    [Bugly setUserValue:userinfo[@"userID"] forKey:@"userID"];
    [Bugly setUserValue:userinfo[@"roomID"] forKey:@"roomID"];
}

- (void) addTKSharePlugin {
    
    // 友盟分享（如果使用需要完成以下内容）
    // 1 pod 集成相关UM库（参考podfile）
    // 2 在 UM 和 微信 平台创建账号并申请权限（当前版本只支持分享到微信好友和朋友圈）并完成相关配置
    // 3 填写 TKUMShareSettings 分享内相关宏定义的值.   APP启动时调用 [TKUMShareSettings UMShareSettings] 初始化分享，
    [TKUMShareSettings UMShareSettings];
    
    // 进入教室前 设置分享回调
    _sharePlugin = [[TK_SharePlugin alloc] init];
    [[TKAPPSetConfig shareInstance] registerSharePlusin:_sharePlugin];
}

-(void) addTKSpeechPlugin {
    _speechPlugin = [[TK_SpeechPlugin alloc] init];
    [[TKAPPSetConfig shareInstance] registerSpeechPlusin:_speechPlugin];
}



-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    if ([url.relativeString containsString:@"enterroomnew://"]) {
        if ([[TKAPPSetConfig shareInstance] isShowServiceAgreementAndprivacyPolicy]) {
            [self joinRoom:url.relativeString];
            //⚠️⚠️集成SDK不要加下一行代码⚠️
            [TKEduClassManager shareInstance].isUrlOpen = YES;//记录外部链接打开
        } else {
            self.roomUrlString = url.relativeString;
        }
    }else {
#if __has_include(<UMShare/UMShare.h>)
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
        if (result == NO) {
            
        }
        return result;
#else
#endif
    }
    return YES;
}

//判断教室类型
-(void)joinRoom:(NSString *)urlString{
    urlString = [urlString stringByRemovingPercentEncoding];
    
    if ([urlString containsString:@"jsondata"]) {
        urlString = [[NSAttributedString alloc] initWithData:[urlString dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)} documentAttributes:nil error:nil].string;
    }
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];

    // 查找 "roomtype=" 字符串的位置
   NSRange range = [urlString rangeOfString:@"roomtype="];
   
   if (range.location != NSNotFound) {
       // 提取 "roomtype=" 后面的部分
       NSString *roomTypeSubString = [urlString substringFromIndex:range.location + range.length];
       
       // 获取值，直到遇到第一个 '&' 或者字符串结尾
       NSRange endRange = [roomTypeSubString rangeOfString:@"&"];
       if (endRange.location != NSNotFound) {
           roomTypeSubString = [roomTypeSubString substringToIndex:endRange.location];
       }
       
       if([roomTypeSubString intValue] == 8){//云直播
//           [[TLEduClassManager shareInstance] joinRoomWithUrl:urlString];
       }else{
           [[TKEduClassManager shareInstance] joinRoomWithUrl:urlString];
       }
   }
}

#if __has_include(<UMShare/UMShare.h>)
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
        // 其他SDK的回调
    }
    return YES;
}
#else
#endif

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[TKEduClassManager shareInstance] applicationWillTerminate];
    [[TKEduClassManager shareInstance] leaveRoom];
  
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    [[TKEduClassManager shareInstance] applicationDidBecomeActive];
}



@end
