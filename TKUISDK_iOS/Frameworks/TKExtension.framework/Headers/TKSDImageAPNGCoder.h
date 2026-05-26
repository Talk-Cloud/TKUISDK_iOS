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
 Built in coder using ImageIO that supports APNG encoding/decoding
 */
@interface TKSDImageAPNGCoder : NSObject <TKSDProgressiveImageCoder, TKSDAnimatedImageCoder>

@property (nonatomic, class, readonly, nonnull) TKSDImageAPNGCoder *sharedCoder;

@end
