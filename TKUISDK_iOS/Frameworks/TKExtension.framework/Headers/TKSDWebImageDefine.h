/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "TKSDWebImageCompat.h"

typedef void(^TKSDWebImageNoParamsBlock)(void);
typedef NSString * TKSDWebImageContextOption NS_EXTENSIBLE_STRING_ENUM;
typedef NSDictionary<TKSDWebImageContextOption, id> TKSDWebImageContext;
typedef NSMutableDictionary<TKSDWebImageContextOption, id> TKSDWebImageMutableContext;

#pragma mark - Image scale

/**
 Return the image scale factor for the specify key, supports file name and url key.
 This is the built-in way to check the scale factor when we have no context about it. Because scale factor is not stored in image data (It's typically from filename).
 However, you can also provide custom scale factor as well, see `TKSDWebImageContextImageScaleFactor`.

 @param key The image cache key
 @return The scale factor for image
 */
FOUNDATION_EXPORT CGFloat TKSDImageScaleFactorForKey(NSString * _Nullable key);

/**
 Scale the image with the scale factor for the specify key. If no need to scale, return the original image.
 This works for `UIImage`(UIKit) or `NSImage`(AppKit). And this function also preserve the associated value in `UIImage+TKMetadata.h`.
 @note This is actually a convenience function, which firstlly call `TKSDImageScaleFactorForKey` and then call `SDScaledImageForScaleFactor`, kept for backward compatibility.

 @param key The image cache key
 @param image The image
 @return The scaled image
 */
FOUNDATION_EXPORT UIImage * _Nullable TKSDScaledImageForKey(NSString * _Nullable key, UIImage * _Nullable image);

/**
 Scale the image with the scale factor. If no need to scale, return the original image.
 This works for `UIImage`(UIKit) or `NSImage`(AppKit). And this function also preserve the associated value in `UIImage+TKMetadata.h`.
 
 @param scale The image scale factor
 @param image The image
 @return The scaled image
 */
FOUNDATION_EXPORT UIImage * _Nullable TKSDScaledImageForScaleFactor(CGFloat scale, UIImage * _Nullable image);

#pragma mark - TKWebCache Options

/// TKWebCache options
typedef NS_OPTIONS(NSUInteger, TKSDWebImageOptions) {
    /**
     * By default, when a URL fail to be downloaded, the URL is blacklisted so the library won't keep trying.
     * This flag disable this blacklisting.
     */
    TKSDWebImageRetryFailed = 1 << 0,
    
    /**
     * By default, image downloads are started during UI interactions, this flags disable this feature,
     * leading to delayed download on UIScrollView deceleration for instance.
     */
    TKSDWebImageLowPriority = 1 << 1,
    
    /**
     * This flag enables progressive download, the image is displayed progressively during download as a browser would do.
     * By default, the image is only displayed once completely downloaded.
     */
    TKSDWebImageProgressiveLoad = 1 << 2,
    
    /**
     * Even if the image is cached, respect the HTTP response cache control, and refresh the image from remote location if needed.
     * The disk caching will be handled by NSURLCache instead of TKSDWebImage leading to slight performance degradation.
     * This option helps deal with images changing behind the same request URL, e.g. Facebook graph api profile pics.
     * If a cached image is refreshed, the completion block is called once with the cached image and again with the final image.
     *
     * Use this flag only if you can't make your URLs static with embedded cache busting parameter.
     */
    TKSDWebImageRefreshCached = 1 << 3,
    
    /**
     * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
     * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
     */
    TKSDWebImageContinueInBackground = 1 << 4,
    
    /**
     * Handles cookies stored in NSHTTPCookieStore by setting
     * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
     */
    TKSDWebImageHandleCookies = 1 << 5,
    
    /**
     * Enable to allow untrusted SSL certificates.
     * Useful for testing purposes. Use with caution in production.
     */
    TKSDWebImageAllowInvalidSSLCertificates = 1 << 6,
    
    /**
     * By default, images are loaded in the order in which they were queued. This flag moves them to
     * the front of the queue.
     */
    TKSDWebImageHighPriority = 1 << 7,
    
    /**
     * By default, placeholder images are loaded while the image is loading. This flag will delay the loading
     * of the placeholder image until after the image has finished loading.
     */
    TKSDWebImageDelayPlaceholder = 1 << 8,
    
    /**
     * We usually don't apply transform on animated images as most transformers could not manage animated images.
     * Use this flag to transform them anyway.
     */
    TKSDWebImageTransformAnimatedImage = 1 << 9,
    
    /**
     * By default, image is added to the imageView after download. But in some cases, we want to
     * have the hand before setting the image (apply a filter or add it with cross-fade animation for instance)
     * Use this flag if you want to manually set the image in the completion when success
     */
    TKSDWebImageAvoidAutoSetImage = 1 << 10,
    
    /**
     * By default, images are decoded respecting their original size. On iOS, this flag will scale down the
     * images to a size compatible with the constrained memory of devices.
     * This flag take no effect if `TKSDWebImageAvoidDecodeImage` is set. And it will be ignored if `TKSDWebImageProgressiveLoad` is set.
     */
    TKSDWebImageScaleDownLargeImages = 1 << 11,
    
    /**
     * By default, we do not query image data when the image is already cached in memory. This mask can force to query image data at the same time. However, this query is asynchronously unless you specify `TKSDWebImageQueryMemoryDataSync`
     */
    TKSDWebImageQueryMemoryData = 1 << 12,
    
    /**
     * By default, when you only specify `TKSDWebImageQueryMemoryData`, we query the memory image data asynchronously. Combined this mask as well to query the memory image data synchronously.
     * @note Query data synchronously is not recommend, unless you want to ensure the image is loaded in the same runloop to avoid flashing during cell reusing.
     */
    TKSDWebImageQueryMemoryDataSync = 1 << 13,
    
    /**
     * By default, when the memory cache miss, we query the disk cache asynchronously. This mask can force to query disk cache (when memory cache miss) synchronously.
     * @note These 3 query options can be combined together. For the full list about these masks combination, see wiki page.
     * @note Query data synchronously is not recommend, unless you want to ensure the image is loaded in the same runloop to avoid flashing during cell reusing.
     */
    TKSDWebImageQueryDiskDataSync = 1 << 14,
    
    /**
     * By default, when the cache missed, the image is load from the loader. This flag can prevent this to load from cache only.
     */
    TKSDWebImageFromCacheOnly = 1 << 15,
    
    /**
     * By default, we query the cache before the image is load from the loader. This flag can prevent this to load from loader only.
     */
    TKSDWebImageFromLoaderOnly = 1 << 16,
    
    /**
     * By default, when you use `TKSDWebImageTransition` to do some view transition after the image load finished, this transition is only applied for image download from the network. This mask can force to apply view transition for memory and disk cache as well.
     */
    TKSDWebImageForceTransition = 1 << 17,
    
    /**
     * By default, we will decode the image in the background during cache query and download from the network. This can help to improve performance because when rendering image on the screen, it need to be firstly decoded. But this happen on the main queue by Core Animation.
     * However, this process may increase the memory usage as well. If you are experiencing a issue due to excessive memory consumption, This flag can prevent decode the image.
     */
    TKSDWebImageAvoidDecodeImage = 1 << 18,
    
    /**
     * By default, we decode the animated image. This flag can force decode the first frame only and produece the static image.
     */
    TKSDWebImageDecodeFirstFrameOnly = 1 << 19,
    
    /**
     * By default, for `TKSDAnimatedImage`, we decode the animated image frame during rendering to reduce memory usage. However, you can specify to preload all frames into memory to reduce CPU usage when the animated image is shared by lots of imageViews.
     * This will actually trigger `preloadAllAnimatedImageFrames` in the background queue(Disk Cache & Download only).
     */
    TKSDWebImagePreloadAllFrames = 1 << 20,
    
    /**
     * By default, when you use `TKSDWebImageContextAnimatedImageClass` context option (like using `TKSDAnimatedImageView` which designed to use `TKSDAnimatedImage`), we may still use `UIImage` when the memory cache hit, or image decoder is not available to produce one exactlly matching your custom class as a fallback solution.
     * Using this option, can ensure we always callback image with your provided class. If failed to produce one, a error with code `TKSDWebImageErrorBadImageData` will been used.
     * Note this options is not compatible with `TKSDWebImageDecodeFirstFrameOnly`, which always produce a UIImage/NSImage.
     */
    TKSDWebImageMatchAnimatedImageClass = 1 << 21,
};


#pragma mark - Context Options

/**
 A String to be used as the operation key for view category to store the image load operation. This is used for view instance which supports different image loading process. If nil, will use the class name as operation key. (NSString *)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextSetImageOperationKey;

/**
 A TKSDWebImageManager instance to control the image download and cache process using in UIImageView+TKWebCache category and likes. If not provided, use the shared manager (TKSDWebImageManager *)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextCustomManager;

/**
 A id<TKSDImageTransformer> instance which conforms `TKSDImageTransformer` protocol. It's used for image transform after the image load finished and store the transformed image to cache. If you provide one, it will ignore the `transformer` in manager and use provided one instead. (id<TKSDImageTransformer>)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextImageTransformer;

/**
 A CGFloat raw value which specify the image scale factor. The number should be greater than or equal to 1.0. If not provide or the number is invalid, we will use the cache key to specify the scale factor. (NSNumber)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextImageScaleFactor;

/**
 A TKSDImageCacheType raw value which specify the store cache type when the image has just been downloaded and will be stored to the cache. Specify `TKSDImageCacheTypeNone` to disable cache storage; `TKSDImageCacheTypeDisk` to store in disk cache only; `TKSDImageCacheTypeMemory` to store in memory only. And `TKSDImageCacheTypeAll` to store in both memory cache and disk cache.
 If you use image transformer feature, this actually apply for the transformed image, but not the original image itself. Use `TKSDWebImageContextOriginalStoreCacheType` if you want to control the original image's store cache type at the same time.
 If not provide or the value is invalid, we will use `TKSDImageCacheTypeAll`. (NSNumber)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextStoreCacheType;

/**
 The same behavior like `TKSDWebImageContextStoreCacheType`, but control the store cache type for the original image when you use image transformer feature. This allows the detail control of cache storage for these two images. For example, if you want to store the transformed image into both memory/disk cache, store the original image into disk cache only, use `[.storeCacheType : .all, .originalStoreCacheType : .disk]`
 If not provide or the value is invalid, we will use `TKSDImageCacheTypeNone`, which does not store the original image into cache. (NSNumber)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextOriginalStoreCacheType;

/**
 A Class object which the instance is a `UIImage/NSImage` subclass and adopt `TKSDAnimatedImage` protocol. We will call `initWithData:scale:options:` to create the instance (or `initWithAnimatedCoder:scale:` when using progressive download) . If the instance create failed, fallback to normal `UIImage/NSImage`.
 This can be used to improve animated images rendering performance (especially memory usage on big animated images) with `TKSDAnimatedImageView` (Class).
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextAnimatedImageClass;

/**
 A id<TKSDWebImageDownloaderRequestModifier> instance to modify the image download request. It's used for downloader to modify the original request from URL and options. If you provide one, it will ignore the `requestModifier` in downloader and use provided one instead. (id<TKSDWebImageDownloaderRequestModifier>)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextDownloadRequestModifier;

/**
 A id<TKSDWebImageCacheKeyFilter> instance to convert an URL into a cache key. It's used when manager need cache key to use image cache. If you provide one, it will ignore the `cacheKeyFilter` in manager and use provided one instead. (id<TKSDWebImageCacheKeyFilter>)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextCacheKeyFilter;

/**
 A id<TKSDWebImageCacheSerializer> instance to convert the decoded image, the source downloaded data, to the actual data. It's used for manager to store image to the disk cache. If you provide one, it will ignore the `cacheSerializer` in manager and use provided one instead. (id<TKSDWebImageCacheSerializer>)
 */
FOUNDATION_EXPORT TKSDWebImageContextOption _Nonnull const TKSDWebImageContextCacheSerializer;
