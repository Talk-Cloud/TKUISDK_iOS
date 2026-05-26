//
//  TKLoginAlert.h
//  TKUIDEMO
//
//  Created by zjt on 2024/12/19.
//  Copyright © 2024 李合意. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKLoginAlert : UIView
- (id)initWithTitle:(NSString *)title contentText:(NSString *)content confirmTitle:(NSString *)confirmTitle;
- (void)show;
@end

NS_ASSUME_NONNULL_END
