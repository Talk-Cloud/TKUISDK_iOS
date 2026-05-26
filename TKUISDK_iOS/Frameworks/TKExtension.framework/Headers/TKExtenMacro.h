//
//  TKExtenMacro.h
//  TKExtension
//
//  Created by zjt on 2024/8/28.
//

#import <UIKit/UIKit.h>

#ifndef TKExtenMacro_h
#define TKExtenMacro_h
//LOG
#ifdef DEBUG
#define TKLog(...) NSLog(__VA_ARGS__)
#else
#define TKLog(...) do { } while (0)
#endif

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) do { } while (0)
#endif

#define TK_EXTENSION_BUNDLE_NAME @"TKExtensionResource"
#define TK_EXTENSION_BUNDLE_PATH [[NSBundle bundleForClass:[self class]] pathForResource:TK_EXTENSION_BUNDLE_NAME ofType:@"bundle"]
#define TK_EXTENSION_BUNDLE [NSBundle bundleWithPath:TK_EXTENSION_BUNDLE_PATH]

#define TK_EXTENSION_ImageWithName(s) [NSString stringWithFormat:@"%@/image/%@", TK_EXTENSION_BUNDLE_PATH,s]
#define TKEX_MTLocalized(s) [TK_EXBUNDLE localizedStringForKey:s value:@"" table:nil]

#define IS_IPHONE_X [TKUntilTool isiPhoneX]
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
#define Fit(height) (IS_PAD ? (height) : (height) * 0.8)
// 屏幕比例，相对pad 1024 * 768
#define Proportion (ScreenH/768.0)

#define TKMainWindow  TKCurrentKeyWindow()
#define TKScreenScale [UIScreen mainScreen].scale
// 屏幕 尺寸
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ScreenW (MAX((SCREEN_WIDTH), (SCREEN_HEIGHT)))
#define ScreenH (MIN((SCREEN_WIDTH), (SCREEN_HEIGHT)))

#define StatusBarH TKStatusBarHeightSceneAware()

#ifndef TK_CURRENT_KEY_WINDOW_DEFINED
#define TK_CURRENT_KEY_WINDOW_DEFINED
static inline UIWindow *TKCurrentKeyWindow(void) {
    UIApplication *app = UIApplication.sharedApplication;
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in app.connectedScenes) {
            if (![scene isKindOfClass:[UIWindowScene class]]) { continue; }
            UIWindowScene *windowScene = (UIWindowScene *)scene;
            if (windowScene.activationState != UISceneActivationStateForegroundActive) { continue; }
            for (UIWindow *w in windowScene.windows) {
                if (w.isKeyWindow) { return w; }
            }
            if (windowScene.windows.count > 0) { return windowScene.windows.firstObject; }
        }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return app.keyWindow ?: app.delegate.window;
#pragma clang diagnostic pop
}
#endif

#ifndef TK_STATUS_BAR_HEIGHT_SCENE_AWARE_DEFINED
#define TK_STATUS_BAR_HEIGHT_SCENE_AWARE_DEFINED
static inline CGFloat TKStatusBarHeightSceneAware(void) {
    if (@available(iOS 13.0, *)) {
        UIWindow *window = TKCurrentKeyWindow();
        CGFloat h = window.windowScene.statusBarManager.statusBarFrame.size.height;
        if (h > 0) { return h; }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return UIApplication.sharedApplication.statusBarFrame.size.height;
#pragma clang diagnostic pop
}
#endif

//导航栏高度
#define TKNavHeight (IS_IPHONE ? 45 : 60)
#define TKNavStatusBarH (IS_IPHONE_X ? 54 : 10)
#define TKBottomBarH (IS_IPHONE_X ? 34 : 0)

// 手机和Ipad适配
#define Fit(height) (IS_PAD ? (height) : (height) * 0.8)
#define FitIPAD(height) (IS_PAD ? (height / 0.8) : (height) ) // 如果给定的ihone的原型图,使用这个适配ipad（注意：改适配并非通用，部分地方需要单独处理）

// 引用
#define tk_weakify(var)   __weak typeof(var) weakSelf = var
#define tk_strongify(var) __strong typeof(var) strongSelf = var

//字体
#define TKFont(s) [UIFont systemFontOfSize:s]
#define TKNUMBERFONT(S) [UIFont fontWithName:@"DINAlternate-Bold" size:(S)]
#define TKMEDIUMFONT(S) [UIFont fontWithName:@"PingFangSC-Medium" size:(S)]
#define TKREGULARFONT(S) [UIFont fontWithName:@"PingFangSC-Regular" size:(S)]
#define TKSEMIBOLDFONT(S) [UIFont fontWithName:@"PingFangSC-Semibold" size:(S)]
#define TKHELVETICAFONT(S) [UIFont fontWithName:@"HelveticaNeue-Medium" size:(S)]

// 颜色 色值设置
#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])
#define UIColorRGBA(rgb,a) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) /255.0f) alpha:a])
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

//桌面共享
static NSString *const sBundleid    =  @"bundleid";
static NSString *const sAppGroupid  =  @"appgroupid";
#endif /* TKExtenMacro_h */
