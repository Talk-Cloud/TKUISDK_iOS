/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "TKSDWebImageCompat.h"

#if TKSD_UIKIT

#import "TKSDWebImageManager.h"

/**
 * Integrates TKSDWebImage async downloading and caching of remote images with UIImageView for highlighted state.
 */
@interface UIImageView (TKHighlightedWebCache)

/**
 * Set the imageView `highlightedImage` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url NS_REFINED_FOR_SWIFT;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url     The url for the image.
 * @param options The options to use when downloading the image. @see TKSDWebImageOptions for the possible values.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(TKSDWebImageOptions)options NS_REFINED_FOR_SWIFT;

/**
 * Set the imageView `highlightedImage` with an `url`, custom options and context.
 *
 * The download is asynchronous and cached.
 *
 * @param url     The url for the image.
 * @param options The options to use when downloading the image. @see TKSDWebImageOptions for the possible values.
 * @param context     A context contains different options to perform specify changes or processes, see `TKSDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(TKSDWebImageOptions)options
                              context:(nullable TKSDWebImageContext *)context;

/**
 * Set the imageView `highlightedImage` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                            completed:(nullable TKSDExternalCompletionBlock)completedBlock NS_REFINED_FOR_SWIFT;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see TKSDWebImageOptions for the possible values.
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(TKSDWebImageOptions)options
                            completed:(nullable TKSDExternalCompletionBlock)completedBlock;

/**
 * Set the imageView `highlightedImage` with an `url` and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see TKSDWebImageOptions for the possible values.
 * @param progressBlock  A block called while image is downloading
 *                       @note the progress block is executed on a background queue
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(TKSDWebImageOptions)options
                             progress:(nullable TKSDImageLoaderProgressBlock)progressBlock
                            completed:(nullable TKSDExternalCompletionBlock)completedBlock;

/**
 * Set the imageView `highlightedImage` with an `url`, custom options and context.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param options        The options to use when downloading the image. @see TKSDWebImageOptions for the possible values.
 * @param context     A context contains different options to perform specify changes or processes, see `TKSDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 * @param progressBlock  A block called while image is downloading
 *                       @note the progress block is executed on a background queue
 * @param completedBlock A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)sd_setHighlightedImageWithURL:(nullable NSURL *)url
                              options:(TKSDWebImageOptions)options
                              context:(nullable TKSDWebImageContext *)context
                             progress:(nullable TKSDImageLoaderProgressBlock)progressBlock
                            completed:(nullable TKSDExternalCompletionBlock)completedBlock;

@end

#endif
