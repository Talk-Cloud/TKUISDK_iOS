//
//  NSUserDefaults+TKSafe.h
//  TKExtension
//
//  Created by zjt on 2025/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (TKSafe)
- (void)setObject_TKSafe:(nullable id)value forKey:(NSString *)defaultName;
@end

NS_ASSUME_NONNULL_END
