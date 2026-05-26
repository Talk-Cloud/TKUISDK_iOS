//
//  TKChoseRoleView.h
//  TKUISDK
//
//  Created by zjt on 2024/11/30.
//  Copyright © 2024 Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKChoseRoleView : UIView
@property (nonatomic, assign) NSInteger currentRole;
@property(nonatomic, copy) void (^choseRoleBtnBlock)(UIButton * btn);
@end

NS_ASSUME_NONNULL_END
