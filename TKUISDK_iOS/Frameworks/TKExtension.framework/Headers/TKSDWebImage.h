/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com"
 * (c) Florent Vilmart
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "TKSDWebImageCompat.h"

#if TKSD_UIKIT
#import <UIKit/UIKit.h>
#endif

//! Project version number for WebImage.
FOUNDATION_EXPORT double TKWebImageVersionNumber;

//! Project version string for WebImage.
FOUNDATION_EXPORT const unsigned char TKWebImageVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WebImage/PublicHeader.h"

#import "TKSDWebImageManager.h"
#import "TKSDWebImageCacheKeyFilter.h"
#import "TKImageCacheKeyFilter.h"       // 新增
#import "TKImageKeyHelper.h"            // 新增
#import "TKImageLoader.h"               // 新增
#import "TKSDWebImageCacheSerializer.h"
#import "TKSDImageCacheConfig.h"
#import "TKSDImageCache.h"
#import "TKSDMemoryCache.h"
#import "TKSDDiskCache.h"
#import "TKSDImageCacheDefine.h"
#import "TKSDImageCachesManager.h"
#import "UIView+TKWebCache.h"
#import "UIImageView+TKWebCache.h"
#import "UIImageView+TKHighlightedWebCache.h"
#import "TKSDWebImageDownloaderConfig.h"
#import "TKSDWebImageDownloaderOperation.h"
#import "TKSDWebImageDownloaderRequestModifier.h"
#import "TKSDImageLoader.h"
#import "TKSDImageLoadersManager.h"
#import "UIButton+TKWebCache.h"
#import "TKSDWebImagePrefetcher.h"
#import "UIView+TKWebCacheOperation.h"
#import "UIImage+TKMetadata.h"
#import "UIImage+TKMultiFormat.h"
#import "UIImage+TKMemoryCacheCost.h"
#import "TKSDWebImageOperation.h"
#import "TKSDWebImageDownloader.h"
#import "TKSDWebImageTransition.h"
#import "TKSDWebImageIndicator.h"
#import "TKSDImageTransformer.h"
#import "UIImage+TKTransform.h"
#import "TKSDAnimatedImage.h"
#import "TKSDAnimatedImageView.h"
#import "TKSDAnimatedImageView+WebCache.h"
#import "TKSDImageCodersManager.h"
#import "TKSDImageCoder.h"
#import "TKSDImageAPNGCoder.h"
#import "TKSDImageGIFCoder.h"
#import "TKSDImageIOCoder.h"
#import "TKSDImageFrame.h"
#import "TKSDImageCoderHelper.h"
#import "TKSDImageGraphics.h"
#import "UIImage+TKGIF.h"
#import "UIImage+TKForceDecode.h"
#import "NSData+TKImageContentType.h"
#import "TKSDWebImageDefine.h"
#import "TKSDWebImageError.h"
#import "TKSDWebImageOptionsProcessor.h"
#import "TKSDWeakProxy.h"
// Mac
#if __has_include("NSImage+TKCompatibility.h")
#import "NSImage+TKCompatibility.h"
#endif


#if __has_include("TKSDAnimatedImageRep.h")
#import "TKSDAnimatedImageRep.h"
#endif

// MapKit
#if __has_include("MKAnnotationView+TKWebCache.h")
#import "MKAnnotationView+TKWebCache.h"
#endif
