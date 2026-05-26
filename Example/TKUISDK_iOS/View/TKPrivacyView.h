//
//  TKPrivacyView.h
//  TKUISDK
//
//  Created by zjt on 2021/1/12.
//  Copyright © 2021 Yi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    PrivacyView_Def,
    PrivacyView_PrivacyPolicy,
    PrivacyView_UserPolicy,
} PrivacyView_Type;
@interface TKPrivacyView : UIView


+ (void)showPrivacyViewWithType:(PrivacyView_Type)type;

@property (nonatomic, assign) PrivacyView_Type  type;
@end

NS_ASSUME_NONNULL_END
