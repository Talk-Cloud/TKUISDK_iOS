//  代码地址: https://github.com/CoderMJLee/MJRefresh

#import <Foundation/Foundation.h>

#if __has_include(<TKMJRefresh/TKMJRefresh.h>)
FOUNDATION_EXPORT double TKMJRefreshVersionNumber;
FOUNDATION_EXPORT const unsigned char TKMJRefreshVersionString[];

#import <TKMJRefresh/UIScrollView+TKMJRefresh.h>
#import <TKMJRefresh/UIScrollView+TKMJExtension.h>
#import <TKMJRefresh/UIView+TKMJExtension.h>

#import <TKMJRefresh/TKMJRefreshNormalHeader.h>
#import <TKMJRefresh/TKMJRefreshGifHeader.h>

#import <TKMJRefresh/TKMJRefreshBackNormalFooter.h>
#import <TKMJRefresh/TKMJRefreshBackGifFooter.h>
#import <TKMJRefresh/TKMJRefreshAutoNormalFooter.h>
#import <TKMJRefresh/TKMJRefreshAutoGifFooter.h>

#import <TKMJRefresh/TKMJRefreshNormalTrailer.h>
#import <TKMJRefresh/TKMJRefreshConfig.h>
#import <TKMJRefresh/NSBundle+TKMJRefresh.h>
#import <TKMJRefresh/TKMJRefreshConst.h>
#else
#import "UIScrollView+TKMJRefresh.h"
#import "UIScrollView+TKMJExtension.h"
#import "UIView+TKMJExtension.h"

#import "TKMJRefreshNormalHeader.h"
#import "TKMJRefreshGifHeader.h"

#import "TKMJRefreshBackNormalFooter.h"
#import "TKMJRefreshBackGifFooter.h"
#import "TKMJRefreshAutoNormalFooter.h"
#import "TKMJRefreshAutoGifFooter.h"

#import "TKMJRefreshNormalTrailer.h"
#import "TKMJRefreshConfig.h"
#import "NSBundle+TKMJRefresh.h"
#import "TKMJRefreshConst.h"
#endif
