//
//  TKLoginAlert.m
//  TKUIDEMO
//
//  Created by zjt on 2024/12/19.
//  Copyright © 2024 李合意. All rights reserved.
//
#define kAlertWidth (IS_PAD ? 500 : 400)
#define kAlertHeight (IS_PAD ? 324 : 261)

#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f

#define KButtonHeight (IS_PAD ? 50.0f : 35.0f)

#define KTitleFont (IS_PAD ? 22.0f : 18.0f)
#define KTextFont  (IS_PAD ? 18.0f : 16.0f)
#define KBtnFont   (IS_PAD ? 20.0f : 17.0f)
#import "TKLoginAlert.h"
@interface TKLoginAlert ()
@property (nonatomic, strong) UIImageView *backImageView;//背景图
@property (nonatomic, strong) UIView *contentView;//内容区域
@property (nonatomic, strong) UILabel *alertTitleLabel;//标题label
@property (nonatomic, strong) UILabel *alertContentLabel;//内容label
@property (nonatomic, strong) UIButton *rightBtn;//右按钮
@property (nonatomic, strong) UIView *inputView;//输入视图
@property (nonatomic, strong) UITextField *inputTextField;//输入框
@property (nonatomic, strong) UIButton *confimBtn;//确定按钮
@property (nonatomic, strong) UIView *backView;//黑色透明视图

@end
@implementation TKLoginAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //键盘弹起、收起的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        self.backImageView = [[UIImageView alloc] init];
        self.backImageView.image = [UIImage imageNamed:@"tk_nav_alertview_bg"];
        self.backImageView.userInteractionEnabled = YES;
        [self addSubview:self.backImageView];
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kAlertWidth, kAlertHeight));
        }];
        
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Fit(52), kAlertWidth,Fit(30))];
        self.alertTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:Fit(22)];
        self.alertTitleLabel.textColor = HexRGB("#232325");
        [self addSubview:self.alertTitleLabel];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title contentText:(NSString *)content confirmTitle:(NSString *)confirmTitle
{
    if (self = [super init]) {
        self.alertTitleLabel.text = title;
        self.alertContentLabel = ({//内容
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = HexRGB("#4A4B4E");
            label.font = [UIFont systemFontOfSize:KTextFont];
            label.text = content;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                if (title.length) {
                    make.top.equalTo(self.alertTitleLabel.mas_bottom).offset(Fit(35));
                }else {
                    make.top.equalTo(self).offset(Fit(52));
                }
                make.left.equalTo(self).offset(Fit(70));
                make.right.equalTo(self.mas_right).offset(-Fit(70));
            }];
            label;
        });
        
        self.confimBtn = ({//确定
            UIButton *confimBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [confimBtn setBackgroundColor:HexRGB("#3997F8")];
            confimBtn.titleLabel.font =  [UIFont systemFontOfSize:KBtnFont];
            [confimBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [confimBtn setTitle:confirmTitle forState:(UIControlStateNormal)];
            [confimBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            confimBtn.layer.cornerRadius = KButtonHeight / 2;
            confimBtn.layer.masksToBounds = YES;
            [self addSubview:confimBtn];
            [confimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self).offset(-Fit(80));
                make.width.equalTo(@(KButtonHeight * 3.5));
                make.height.equalTo(@(KButtonHeight));
            }];
            confimBtn;
        });
    }
    return self;
}

- (void)show{
    UIViewController *topVC = [TKUntilTool appRootViewController];
 //   self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    
    [topVC.view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAlertWidth, kAlertHeight));
        make.center.equalTo(topVC.view);
    }];
}

- (void)rightBtnClicked:(id)sender{
    [self removeFromSuperview];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    if (![self.inputTextField isFirstResponder]) {
        return;
    }
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    double duration = ([[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]);
    void (^aBlock)() = ^void() {
       self.transform = CGAffineTransformMakeTranslation(0, - keyboardHeight/2);
    };
    [UIView animateWithDuration:duration delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone) animations:aBlock completion:nil];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    void (^aBlock)() = ^void() {
        self.transform = CGAffineTransformIdentity;
    };
    
    [UIView animateWithDuration:duration delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone) animations:aBlock completion:nil];
}

@end
