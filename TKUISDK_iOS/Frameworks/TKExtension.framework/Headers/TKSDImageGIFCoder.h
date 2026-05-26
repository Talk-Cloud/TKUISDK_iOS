/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "TKSDImageCoder.h"

/**
 Built in coder using ImageIO that supports animated GIF encoding/decoding
 @note `TKSDImageIOCoder` supports GIF but only as static (will use the 1st frame).
 @note Use `TKSDImageGIFCoder` for fully animated GIFs. For `UIImageView`, it will produce animated `UIImage`(`NSImage` on macOS) for rendering. For `TKSDAnimatedImageView`, it will use `TKSDAnimatedImage` for rendering.
 @note The recommended approach for animated GIFs is using `TKSDAnimatedImage` with `TKSDAnimatedImageView`. It's more performant than `UIImageView` for GIF displaying(especially on memory usage)
 */
@interface TKSDImageGIFCoder : NSObject <TKSDProgressiveImageCoder, TKSDAnimatedImageCoder>

@property (nonatomic, class, readonly, nonnull) TKSDImageGIFCoder *sharedCoder;

@end
