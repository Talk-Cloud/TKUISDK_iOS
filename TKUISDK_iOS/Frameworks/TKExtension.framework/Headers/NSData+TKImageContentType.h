/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Fabrice Aneche
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "TKSDWebImageCompat.h"

/**
 You can use switch case like normal enum. It's also recommended to add a default case. You should not assume anything about the raw value.
 For custom coder plugin, it can also extern the enum for supported format. See `TKSDImageCoder` for more detailed information.
 */
typedef NSInteger TKSDImageFormat NS_TYPED_EXTENSIBLE_ENUM;
static const TKSDImageFormat TKSDImageFormatUndefined = -1;
static const TKSDImageFormat TKSDImageFormatJPEG      = 0;
static const TKSDImageFormat TKSDImageFormatPNG       = 1;
static const TKSDImageFormat TKSDImageFormatGIF       = 2;
static const TKSDImageFormat TKSDImageFormatTIFF      = 3;
static const TKSDImageFormat TKSDImageFormatWebP      = 4;
static const TKSDImageFormat TKSDImageFormatHEIC      = 5;
static const TKSDImageFormat TKSDImageFormatHEIF      = 6;

/**
 NSData category about the image content type and UTI.
 */
@interface NSData (TKImageContentType)

/**
 *  Return image format
 *
 *  @param data the input image data
 *
 *  @return the image format as `TKSDImageFormat` (enum)
 */
+ (TKSDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data;

/**
 *  Convert TKSDImageFormat to UTType
 *
 *  @param format Format as TKSDImageFormat
 *  @return The UTType as CFStringRef
 */
+ (nonnull CFStringRef)sd_UTTypeFromImageFormat:(TKSDImageFormat)format CF_RETURNS_NOT_RETAINED NS_SWIFT_NAME(sd_UTType(from:));

/**
 *  Convert UTTyppe to TKSDImageFormat
 *
 *  @param uttype The UTType as CFStringRef
 *  @return The Format as TKSDImageFormat
 */
+ (TKSDImageFormat)sd_imageFormatFromUTType:(nonnull CFStringRef)uttype;

@end
