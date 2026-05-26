//
//  TKImageLoader.h
//  TKExtension
//
//  Created by yyf on 2026/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKImageLoader : NSObject
+ (void)loadImageWithURL:(NSString *)url
               imageView:(UIImageView *)imageView
         placeholderImage:(UIImage *)placeholder;
@end

NS_ASSUME_NONNULL_END
