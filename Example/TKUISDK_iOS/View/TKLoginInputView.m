//
//  TKLoginInputView.m
//  EduClass
//
//  Created by lyy on 2018/4/17.
//  Copyright © 2018年 拓课云. All rights reserved.
//

#import "TKLoginInputView.h"
#import "TKDemoEnumHeader.h"
#import <TKExtension/TKExtensionHeader.h>

@interface TKLoginInputView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *backgroundView;//底层背景图

@property (nonatomic, strong) UIButton *choiceRoleButton;//角色选择按钮

@property (nonatomic, strong) UIButton *clearAllStringBtn;

//只有是选择器的时候才显示
@property (nonatomic, strong) UILabel *showLabel;
@property (nonatomic, assign) NSInteger textPosition;
@end

@implementation TKLoginInputView

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)text placeholderText:(NSString *)placeholder setImageName:(NSString *)imageName inputViewType:(TKInputViewType)inputViewType {
    if (self = [super initWithFrame:frame]) {
        self.inputViewType = inputViewType;
        self.text = text;
        _backgroundView = [[UIView alloc]init];
        [self addSubview:_backgroundView];
        [self sendSubviewToBack:_backgroundView];
        _inputView = [[UITextField alloc]init];
        [self addSubview:_inputView];
        _iconImageView = [[UIImageView alloc]init];
        [self addSubview:_iconImageView];
        if (self.inputViewType == TKInputViewRoomID || self.inputViewType == TKInputViewUserNickName || self.inputViewType == TKInputViewPassWord) {
            self.clearAllStringBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.clearAllStringBtn addTarget:self action:@selector(clearAllString) forControlEvents:UIControlEventTouchUpInside];
            [self.iconImageView addSubview:self.clearAllStringBtn];
        }
        
        _showLabel = [[UILabel alloc]init];
        _showLabel.textAlignment = NSTextAlignmentRight;
        [self setDefaultAttributeShowText:text placeholderText:placeholder setImageName:imageName];
        
    }
    return self;
}

- (void)setDefaultAttributeShowText:(NSString *)text placeholderText:(NSString *)placeholder setImageName:(NSString *)imageName {
    _backgroundView.backgroundColor  = HexRGBA("#324561", 0.04);
    _backgroundView.alpha = 1;
    _backgroundView.layer.cornerRadius = 25;
    _backgroundView.layer.masksToBounds = true;
    _backgroundView.layer.borderColor = HexRGB("3997F8").CGColor;
    _inputView.enabled = YES;
    _iconImageView.image = [UIImage imageNamed:imageName];
    _iconImageView.contentMode = UIViewContentModeCenter;
    
    _inputView.text = text;
    _inputView.delegate = self;
    _inputView.textColor = HexRGB("222222");
    _inputView.font = [UIFont systemFontOfSize:16];
    _inputView.tintColor = HexRGB("409EFD");
    [_inputView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (self.inputViewType == TKInputViewRoomID) {
        _inputView.font = [UIFont systemFontOfSize:20];
        _iconImageView.hidden = YES;
        self.clearAllStringBtn.hidden = YES;
        _iconImageView.userInteractionEnabled = YES;
    }
    
    if (self.inputViewType == TKInputViewUserNickName) {
        _iconImageView.hidden = YES;
        self.clearAllStringBtn.hidden = YES;
        _iconImageView.userInteractionEnabled = YES;
    }
    if (self.inputViewType == TKInputViewPassWord) {
        _iconImageView.hidden = NO;
        _iconImageView.image = [UIImage imageNamed:@"tk_login_help_circle"];
        self.clearAllStringBtn.hidden = NO;
        _iconImageView.userInteractionEnabled = YES;
    }

    if (placeholder) {
        UIColor * color = HexRGB("CBCBCB");
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:
                                          @{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          }];
        _inputView.attributedPlaceholder = attrString;
    }
    
    if (self.inputViewType == TKInputViewUserRole) {
        
        _inputView.tintColor = [UIColor clearColor];
        _showLabel.textColor = HexRGB("888888");
        _showLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_showLabel];
        
        //选择角色点击事件
        _choiceRoleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview: _choiceRoleButton];
        [_choiceRoleButton addTarget:self action:@selector(choiceRoleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clearAllString {
    if(self.inputViewType == TKInputViewPassWord){
        if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(showHelpView)]) {
            [self.inputDelegate showHelpView];
        }
    }else{
        self.inputView.text = nil;
    }
   
}

- (void)choiceRoleButtonClick:(UIButton *)sender{

    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(clickChoiceRole)]) {
        [self.inputDelegate clickChoiceRole];
    }
}

- (void)layoutSubviews
{
    _backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _inputView.frame = CGRectMake(24, 0, CGRectGetWidth(_backgroundView.frame) - 70, CGRectGetHeight(_backgroundView.frame));
    _showLabel.frame = CGRectMake(CGRectGetMaxX(_inputView.frame)-100, 0, 100, CGRectGetHeight(_inputView.frame));
    _iconImageView.frame = CGRectMake(CGRectGetMaxX(_inputView.frame), 0, 40, CGRectGetHeight(_inputView.frame));
    if (self.inputViewType == TKInputViewRoomID || self.inputViewType == TKInputViewUserNickName || self.inputViewType == TKInputViewPassWord) {
        self.clearAllStringBtn.frame = CGRectMake(0, 0, self.iconImageView.width, self.iconImageView.height);
    }
    if (_choiceRoleButton) {
        _choiceRoleButton.frame = CGRectMake(0, 0, self.width, self.height);
    }
}

#pragma mark textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
            
    if(range.length + range.location > textField.text.length) return NO;
    
    if ([string isEqualToString:@""] && range.length == 0) {
        return NO;
    }
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return  NO;
    }
    
    // 验证教室号 是否是数字
    if (self.inputViewType == TKInputViewRoomID) {
        
        NSString * leftStr = [textField.text substringToIndex:range.location];
        NSString * righStr = [self getNumberString:[textField.text substringFromIndex:range.location + range.length]];
                
        NSString * middStr = [self getNumberString:string];
        if (string.length > 0 && middStr.length == 0) {
//            [TKUtil showMessage:TKMTLocalized(@"Prompt.onlyNumber")];
            return NO;
        }
        
        if ([string isEqualToString:@""] && range.location > 0) {
            // 删除
            // 1-删除的是空格需要将前一位也删除
            NSString * sub1 = [textField.text substringWithRange:range];
            // 2-删除的前一位是空格需要将空格也删除
            NSString * sub2 = [textField.text substringWithRange:NSMakeRange(range.location - 1, 1)];
            if ([sub1 isEqualToString:@" "] || [sub2 isEqualToString:@" "]) {
                leftStr = [textField.text substringToIndex:range.location - 1];
            }
        }
                
        NSInteger position = leftStr.length;
        
        if (middStr.length > 0) {
            leftStr = [self string:leftStr appendingString:middStr];
            position = leftStr.length;
        }
        
        if (righStr.length > 0) {
            leftStr = [self string:leftStr appendingString:righStr];
        }
        
        textField.text = leftStr;
        [self textFieldDidChange:textField];
        
        UITextPosition * sta = [textField positionFromPosition:[textField beginningOfDocument] offset:position];
        UITextPosition * end = [textField positionFromPosition:sta offset:0];
        [textField setSelectedTextRange:[textField textRangeFromPosition:sta toPosition:end]];
        return NO;
        
    } else if (self.inputViewType == TKInputViewUserNickName) {
                        
        // 用户名最大12位
        return (textField.text.length > 24 && ![string isEqualToString:@""]) ? NO : YES;
    }else if (self.inputViewType == TKInputViewPassWord){
        // 允许的字符集（字母、数字和常用符号）
        NSString *allowedCharacters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=<>?,./:;\"'{}[]|\\`~";
        // 检查输入的字符是否在允许的字符集中
        NSCharacterSet *allowedCharacterSet = [NSCharacterSet characterSetWithCharactersInString:allowedCharacters];
        NSCharacterSet *inputCharacterSet = [NSCharacterSet characterSetWithCharactersInString:string];
        return [allowedCharacterSet isSupersetOfSet:inputCharacterSet];
    }
    return YES;
}

- (NSString *) string:(NSString *)string appendingString:(NSString *)appendingStr {
    
    int i = 0;
    while (i < appendingStr.length) {
        
        NSString * sub = [appendingStr substringWithRange:NSMakeRange(i, 1)];
        if ((string.length + 1) % 5 == 0) {
            string = [string stringByAppendingString:@" "];
        }
        string = [string stringByAppendingString:sub];
        i ++;
    }
    return string;
}

- (NSString *) getNumberString:(NSString*)string {
    
    if (NO == [string isKindOfClass:NSString.class]) {
        string = [NSString stringWithFormat:@"%@", string];
    }
    
    if (nil == string || string.length == 0) {
        return @"";
    }
    
    NSString * str = @"";
    NSCharacterSet * tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < string.length) {
        NSString * sub = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [sub rangeOfCharacterFromSet:tmpSet];
        if (range.length > 0) {
            str = [str stringByAppendingString:sub];
        }
        i++;
    }
    return str;
}

#pragma mark - 监听textField.text的长度
- (void)textFieldDidChange:(UITextField *)textField {
    if ((self.inputViewType == TKInputViewRoomID || self.inputViewType == TKInputViewUserNickName) && textField.text.length == 0) {
        self.iconImageView.hidden = YES;
        self.clearAllStringBtn.hidden = YES;
    }else {
        self.iconImageView.hidden = NO;
        self.clearAllStringBtn.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _backgroundView.backgroundColor  = HexRGBA("#324561", 0.04);
    _backgroundView.layer.borderWidth = 0.0f;
    if (self.inputViewType == TKInputViewRoomID || self.inputViewType == TKInputViewUserNickName ) {
        self.iconImageView.hidden = YES;
        self.clearAllStringBtn.hidden = YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _backgroundView.backgroundColor  = [UIColor clearColor];
    _backgroundView.layer.borderWidth = 1.0f;
    
    if ((self.inputViewType == TKInputViewRoomID || self.inputViewType == TKInputViewUserNickName) && textField.text.length > 0) {
        self.iconImageView.hidden = NO;
        self.clearAllStringBtn.hidden = NO;
    }
}
- (void)setText:(NSString *)text{
    _text = text;
    _inputView.text = text;
}


- (void)dealloc
{

}

@end
