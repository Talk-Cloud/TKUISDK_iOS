//
//  TKImageKeyHelper.h
//  TKExtension
//
//  Created by yyf on 2026/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKImageKeyHelper : NSObject
+ (BOOL)isCDNProcessedImage:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
