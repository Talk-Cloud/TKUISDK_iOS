//
//  TKSPContentView.m
//  EduClass
//
//  Created by Evan on 2020/3/17.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#define CheckProportion (ScreenH < ScreenW ? ScreenW/1024.0 : ScreenH/1024.0)

#import "TKSPContentView.h"


@interface TKSPContentView ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *getBackBtn;// 返回按钮去
@property (nonatomic, strong) UILabel *titleLa; // 标提

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UILabel *contentLa;
@property (nonatomic, strong) UIScrollView *contentLaBackView;




@end

@implementation TKSPContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.backView];
        [self addSubview:self.contentTextView];
        
        [self addSubview:self.contentLaBackView];
        [self.contentLaBackView addSubview:self.contentLa];
        
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(StatusBarH + 50);
        }];
        
        
        [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLa.mas_bottom).offset(30 * CheckProportion);
            make.left.equalTo(self).offset(30 * CheckProportion);
            make.right.equalTo(self.mas_right).offset(-30 * CheckProportion);
            make.bottom.equalTo(self);
        }];
        
        
        
    }
    return self;
}


- (void)backButtonAciton:(UIButton *)sender {
    [self dismissAlert];
}


- (void)show:(UIView *)view
{
    [TKMainWindow addSubview:self];
    CGRect rect = self.frame;
    self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
    [TKMainWindow addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }];
}


- (void)dismissAlert
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         CGRect rect = self.frame;
                         self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                     }];
    
    
}



#pragma mark - setter


- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = UIColor.whiteColor;
        UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backbutton setImage:[UIImage imageNamed:@"tk_loginSetting_back"] forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(backButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:backbutton];
        
        [backbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backView).offset(10);
            make.centerY.equalTo(_backView.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont systemFontOfSize:17];
        _titleLa.textColor = HexRGB("#47474B");
        [_backView addSubview:_titleLa];
        [_titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backView);
            make.centerY.equalTo(backbutton.mas_centerY);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = HexRGB("#E7E7EE");
        [_backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_backView);
            make.height.equalTo(@(.6));
        }];
        
    }
    return _backView;
}

//- (UIButton *)getBackBtn {
//    if (!_getBackBtn) {
//        _getBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_getBackBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_getBackBtn addTarget:self action:@selector(backButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _getBackBtn;
//}

//- (UILabel *)titleLa {
//    if (!_titleLa) {
//        _titleLa = [[UILabel alloc] init];
//        [_titleLa setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:30 * CheckProportion]];
//        _titleLa.text = @"服务协议";
//    }
//    return _titleLa;
//}


- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [UIColor whiteColor];
        _contentTextView.textColor = HexRGB("#5F5F5F");
        _contentTextView.editable = NO;
    }
    return _contentTextView;
}

- (UILabel *)contentLa {
    if (!_contentLa) {
        _contentLa = [[UILabel alloc] init];
        _contentLa.font = [UIFont systemFontOfSize:16 * CheckProportion];
        _contentLa.textColor = HexRGB("#5F5F5F");
        _contentLa.numberOfLines = 0;
    }
    return _contentLa;
}


- (UIScrollView *)contentLaBackView {
    if (!_contentLaBackView) {
        _contentLaBackView = [[UIScrollView alloc] init];
    }
    return _contentLaBackView;
}



@end
