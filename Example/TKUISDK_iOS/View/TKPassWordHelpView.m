//
//  TKPassWordHelpView.m
//  TKUISDK
//
//  Created by zjt on 2024/11/19.
//  Copyright © 2024 Yi. All rights reserved.
//

#import "TKPassWordHelpView.h"
@interface TKPassWordHelpView ()
@property (nonatomic, assign) CGRect tagerFrame;
@property (nonatomic, strong) UIImageView * arrowImageView;
@property (nonatomic, strong) UILabel * textL;

@end
@implementation TKPassWordHelpView
+ (void)showPassWordHelpViewWithtagetFrame:(CGRect)tagetFrame superView:(UIView *)superView{
    TKPassWordHelpView * helpView = [[TKPassWordHelpView alloc]initWithFrame:superView.bounds];
    helpView.tagerFrame = tagetFrame;
    [superView addSubview:helpView];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initSubViews{
    self.arrowImageView =[[UIImageView alloc]init];
    self.arrowImageView.image = [UIImage imageNamed:@"tk_login_arrow"];
    self.arrowImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.arrowImageView];
    
    self.textL = [[UILabel alloc]init];
    self.textL.backgroundColor = HexRGBA("#000000", 0.88);
    self.textL.font = [UIFont systemFontOfSize:Fit(16)];
    self.textL.textColor = [UIColor whiteColor];
    self.textL.layer.cornerRadius = 4;
    self.textL.text = NSLocalizedString(@"TKLog.NoPWD", nil);
    self.textL.layer.masksToBounds = YES;
    self.textL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textL];
}

- (void)setTagerFrame:(CGRect)tagerFrame{
    _tagerFrame = tagerFrame;
    CGFloat arrowImageViewTop = tagerFrame.origin.y +  tagerFrame.size.height;
    CGFloat arrowImageViewLeft = tagerFrame.origin.x + (tagerFrame.size.width - Fit(20)) /2;
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Fit(20), Fit(10)));
        make.top.equalTo(self).offset(arrowImageViewTop);
        make.left.equalTo(self).offset(arrowImageViewLeft);
    }];
    
    [self.textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(Fit(32)));
        make.right.equalTo(self.arrowImageView).offset(Fit(20));
        make.top.equalTo(self.arrowImageView.mas_bottom);
    }];
}


- (void)tapAction{
    [self removeFromSuperview];
}
@end
