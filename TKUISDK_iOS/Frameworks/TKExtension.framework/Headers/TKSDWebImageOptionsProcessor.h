/*
 * This file is part of the TKSDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "TKSDWebImageCompat.h"
#import "TKSDWebImageDefine.h"

@class TKSDWebImageOptionsResult;

typedef TKSDWebImageOptionsResult * _Nullable(^TKSDWebImageOptionsProcessorBlock)(NSURL * _Nullable url, TKSDWebImageOptions options, TKSDWebImageContext * _Nullable context);

/**
 The options result contains both options and context.
 */
@interface TKSDWebImageOptionsResult : NSObject

/**
 TKWebCache options.
 */
@property (nonatomic, assign, readonly) TKSDWebImageOptions options;

/**
 Context options.
 */
@property (nonatomic, copy, readonly, nullable) TKSDWebImageContext *context;

/**
 Create a new options result.

 @param options options
 @param context context
 @return The options result contains both options and context.
 */
- (nonnull instancetype)initWithOptions:(TKSDWebImageOptions)options context:(nullable TKSDWebImageContext *)context;

@end

/**
 This is the protocol for options processor.
 Options processor can be used, to control the final result for individual image request's `TKSDWebImageOptions` and `TKSDWebImageContext`
 Implements the protocol to have a global control for each indivadual image request's option.
 */
@protocol TKSDWebImageOptionsProcessor <NSObject>

/**
 Return the processed options result for specify image URL, with its options and context

 @param url The URL to the image
 @param options A mask to specify options to use for this request
 @param context A context contains different options to perform specify changes or processes, see `TKSDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 @return The processed result, contains both options and context
 */
- (nullable TKSDWebImageOptionsResult *)processedResultForURL:(nullable NSURL *)url
                                                    options:(TKSDWebImageOptions)options
                                                    context:(nullable TKSDWebImageContext *)context;

@end

/**
 A options processor class with block.
 */
@interface TKSDWebImageOptionsProcessor : NSObject<TKSDWebImageOptionsProcessor>

- (nonnull instancetype)initWithBlock:(nonnull TKSDWebImageOptionsProcessorBlock)block;
+ (nonnull instancetype)optionsProcessorWithBlock:(nonnull TKSDWebImageOptionsProcessorBlock)block;

@end
