//
//  TKLoginInputView.h
//  EduClass
//
//  Created by lyy on 2018/4/17.
//  Copyright © 2018年 拓课云. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TKLoginInputViewDelegate <NSObject>

- (void)clickChoiceRole;
- (void)showHelpView;
@end

@interface TKLoginInputView : UIView

@property (nonatomic, weak) id<TKLoginInputViewDelegate> inputDelegate;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UITextField *inputView;//输入框
@property (nonatomic,assign) TKInputViewType inputViewType;
@property (nonatomic, strong) UIImageView *iconImageView;//icon
/**
 自定义input

 @param frame 位置大小
 @param text 显示的文本
 @param placeholder 未输入时的默认值
 @param imageName icon标签
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)text placeholderText:(NSString *)placeholder setImageName:(NSString *)imageName inputViewType:(TKInputViewType)inputViewType;

@end
