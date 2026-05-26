//
//  TKPlaybackView.h
//  TKUIDEMO
//
//  Created by edy on 2025/7/30.
//  Copyright © 2025 李合意. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPlaybackView : UIView

@property (nonatomic, copy) void(^joinPlaybackRoomBlock)(NSDictionary *dic);

- (void)show:(UIView *)view withData:(NSArray *)array;

- (void)checkRoomPlaybackWithParam:(NSDictionary *)roomParam callBack:(void(^)(NSDictionary * _Nullable responseObject))callBack;
@end

NS_ASSUME_NONNULL_END
