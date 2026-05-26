//
//  TKNetTool.h
//  TKExtension
//
//  Created by zjt on 2024/12/18.
//

#import <Foundation/Foundation.h>
#import "TKAFHTTPSessionManager.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^TKComplete)( id _Nullable response);
typedef void(^TKError)(NSError * _Nullable response);
@interface TKNetTool : NSObject

/// ShareInstance
+ (instancetype)shareInstance;

/// GET
/// - Parameters:
///   - URLString: URLString
///   - parameters: parameters
///   - successCallBack: successCallBack
///   - progressCallBack: progressCallBack
///   - failureCallBack: failureCallBack
- (void)GET:(NSString *)URLString parameters:(id)parameters successCallBack:(void(^)(NSDictionary *responseObject))successCallBack  progressCallBack:(void (^)(NSProgress * progressObject))progressCallBack failureCallBack:(void (^_Nullable)(NSError * _Nonnull error))failureCallBack;

/// POST
/// - Parameters:
///   - URLString: URLString
///   - parameters: parameters
///   - successCallBack: successCallBack
///   - progressCallBack: progressCallBack
///   - failureCallBack: failureCallBack
- (void)POST:(NSString *)URLString parameters:(id)parameters successCallBack:(void(^)(NSDictionary *responseObject))successCallBack progressCallBack:(void (^)(NSProgress * progressObject))progressCallBack failureCallBack:(void (^_Nullable)(NSError * _Nonnull error))failureCallBack;

/// POST UPLoad
/// - Parameters:
///   - URLString: URLString
///   - parameters: parameters
///   - block: block
///   - successCallBack: successCallBack
///   - progressCallBack: progressCallBack
///   - failureCallBack: failureCallBack
- (void)POST:(NSString *)URLString parameters:(id)parameters  constructingBodyWithBlock:(void (^)(id <TKAFMultipartFormData> formData))block successCallBack:(void(^)(NSDictionary *responseObject))successCallBack  progressCallBack:(void (^)(NSProgress * progressObject))progressCallBack failureCallBack:(void (^_Nullable)(NSError * _Nonnull error))failureCallBack;

/// Download
/// - Parameters:
///   - url: url
///   - downloadProgressBlock: downloadProgressBlock
///   - destination: destination
///   - completionHandler: completionHandler
- (void )downloadTaskWithUrl:(NSString *)url progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
