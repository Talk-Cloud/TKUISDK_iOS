//
//  TKMBProgressHUD+Add.h
//  TKUISDK
//
//  Created by edy on 2022/10/22.
//  Copyright © 2022 Yi. All rights reserved.
//

#import <TKExtension/TKMBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKMBProgressHUD (Add)


+ (void)showError:(NSString *)errorText toView:(UIView *)view;

+ (TKMBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
