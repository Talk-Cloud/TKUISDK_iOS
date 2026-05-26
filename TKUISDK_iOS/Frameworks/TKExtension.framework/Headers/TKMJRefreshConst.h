//  代码地址: https://github.com/CoderMJLee/MJRefresh
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

// 弱引用
#define TKMJWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define TKMJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define TKMJRefreshLog(...)
#endif

// 过期提醒
#define TKMJRefreshDeprecated(DESCRIPTION) __attribute__((deprecated(DESCRIPTION)))

// 运行时objc_msgSend
#define TKMJRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define TKMJRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define TKMJRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define TKMJRefreshLabelTextColor TKMJRefreshColor(90, 90, 90)

// 字体大小
#define TKMJRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat TKMJRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat TKMJRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat TKMJRefreshFooterHeight;
UIKIT_EXTERN const CGFloat TKMJRefreshTrailWidth;
UIKIT_EXTERN const CGFloat TKMJRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat TKMJRefreshSlowAnimationDuration;


UIKIT_EXTERN NSString *const TKMJRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const TKMJRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const TKMJRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const TKMJRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const TKMJRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const TKMJRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const TKMJRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const TKMJRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const TKMJRefreshTrailerIdleText;
UIKIT_EXTERN NSString *const TKMJRefreshTrailerPullingText;

UIKIT_EXTERN NSString *const TKMJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const TKMJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const TKMJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const TKMJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const TKMJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const TKMJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const TKMJRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const TKMJRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const TKMJRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const TKMJRefreshHeaderNoneLastDateText;

UIKIT_EXTERN NSString *const TKMJRefreshDidChangeLanguageNotification;

// 状态检查
#define TKMJRefreshCheckState \
TKMJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

// 异步主线程执行，不强持有Self
#define TKMJRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

/// 替换方法实现
/// @param _fromClass 源类
/// @param _originSelector 源类的 Selector
/// @param _toClass  目标类
/// @param _newSelector 目标类的 Selector
CG_INLINE BOOL TKMJRefreshExchangeImplementations(
                                                Class _fromClass, SEL _originSelector,
                                                Class _toClass, SEL _newSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    
    Method oriMethod = class_getInstanceMethod(_fromClass, _originSelector);
    Method newMethod = class_getInstanceMethod(_toClass, _newSelector);
    if (!newMethod) {
        return NO;
    }
    
    BOOL isAddedMethod = class_addMethod(_fromClass, _originSelector,
                                         method_getImplementation(newMethod),
                                         method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        // 如果 class_addMethod 成功了，说明之前 fromClass 里并不存在 originSelector，所以要用一个空的方法代替它，以避免 class_replaceMethod 后，后续 toClass 的这个方法被调用时可能会 crash
        IMP emptyIMP = imp_implementationWithBlock(^(id selfObject) {});
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?: emptyIMP;
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _newSelector, oriMethodIMP, oriMethodTypeEncoding);
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}
