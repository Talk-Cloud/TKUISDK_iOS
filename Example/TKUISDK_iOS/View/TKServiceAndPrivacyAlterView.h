//
//  TKServiceAndPrivacyAlterView.h
//  EduClass
//
//  Created by Evan on 2020/3/16.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^didTextBlock) (NSString *text);

@interface TKServiceAndPrivacyAlterView : UIView

@property (nonatomic, copy) didTextBlock textBlock;

@end

NS_ASSUME_NONNULL_END
