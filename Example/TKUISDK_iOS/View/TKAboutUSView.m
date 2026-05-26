//
//  TKAboutUSView.m
//  TKUISDK
//
//  Created by zjt on 2023/11/2.
//  Copyright © 2023 Yi. All rights reserved.
//
#define CheckProportion (ScreenH < ScreenW ? ScreenW/1024.0 : ScreenH/1024.0)
#define kAppStoreFormat @"https://itunes.apple.com/app/id%ld"

#import "TKAboutUSView.h"
#import "TKSPContentView.h"
#import <WebKit/WebKit.h>
#import "TKLoginPermissionView.h"

@interface TKAboutUSView ()
@property (nonatomic, strong) TKSPContentView *contentView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *logoIamge;

@property (nonatomic, strong) UIView *userAgreementCell;// 用户协议
@property (nonatomic, strong) UIView *privacyAgreementCell;// 隐私协议
@property (nonatomic, strong) UIView *versionUpdateCell; // 版本更新
@property (nonatomic, strong) UILabel *versionLabel;//版本号
@property (nonatomic,assign) CGFloat property;
@property (nonatomic,assign) UIInterfaceOrientation interfaceOriention;
@property (nonatomic, strong) WKWebView    *wkWebView;
@property (nonatomic, strong) UILabel *titleLa;

@property (nonatomic, strong) TKLoginPermissionView *permissionView;

@property (nonatomic, strong) UILabel * copyingL;
@property (nonatomic, strong) UILabel * icpL;
@property (nonatomic, strong) UILabel * appL3;
@property (nonatomic, strong) UILabel * versionL;
@property (nonatomic, strong) UIButton * icpBtn;

@end

@implementation TKAboutUSView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"f8f9fb"];
        [self addSubview:self.backView];
        [self addSubview:self.logoIamge];
        [self addSubview:self.userAgreementCell];
        [self addSubview:self.privacyAgreementCell];
        [self addSubview:self.versionUpdateCell];
        [self loadSubViews];
    }
    return self;
}
- (void)loadSubViews{
    
    self.contentView.frame = self.frame;
    self.backView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), StatusBarH + 50);
    self.logoIamge.frame  = CGRectMake(0, CGRectGetHeight(self.backView.frame) + 60 * CheckProportion, CGRectGetWidth(self.frame), 80);
    self.logoIamge.hidden = NO;
    self.property = 1;
    self.userAgreementCell.frame = CGRectMake(24, CGRectGetMaxY(self.logoIamge.frame) + 60 * CheckProportion, CGRectGetWidth(self.frame) - 48, 63);
    self.privacyAgreementCell.frame = CGRectMake(24, CGRectGetMaxY(self.userAgreementCell.frame) + 16, CGRectGetWidth(self.frame) - 48, 63 * _property);
    self.versionUpdateCell.frame = CGRectMake(24, CGRectGetMaxY(self.privacyAgreementCell.frame) + 16, CGRectGetWidth(self.frame) - 48, 63 * _property);
    
    self.copyingL = [[UILabel alloc]init];
    self.copyingL.textAlignment = NSTextAlignmentCenter;
    self.copyingL.font = [UIFont systemFontOfSize:12];
    self.copyingL.numberOfLines = 0;
    self.copyingL.textColor =HexRGB("#8F92A1");
    self.copyingL.text = NSLocalizedString(@"TKCopyright", nil);
    [self addSubview:self.copyingL];
    [self.copyingL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
    self.icpL = [[UILabel alloc]init];
    self.icpL.textAlignment = NSTextAlignmentCenter;
    self.icpL.font = [UIFont systemFontOfSize:12];
    self.icpL.textColor = HexRGB("#8F92A1");
    self.icpL.text = @"ICP备案号:京ICP备17018423号-5A >";
    [self addSubview:self.icpL];
    [self.icpL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.copyingL.mas_top).offset(-5);
    }];
    
    self.icpBtn = [[UIButton alloc]init];
    self.icpBtn.backgroundColor = [UIColor clearColor];
    [self.icpBtn addTarget:self action:@selector(icpBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.icpBtn];
    [self.icpBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icpL);
        make.bottom.equalTo(self.copyingL);
        make.width.equalTo(self.icpL);
        make.centerX.equalTo(self);
    }];
    
    
    self.versionL = [[UILabel alloc]init];
    self.versionL.textAlignment = NSTextAlignmentCenter;
    self.versionL.font = [UIFont systemFontOfSize:16];
    self.versionL.textColor = HexRGB("#8F92A1");
    self.versionL.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"sys-clientVersion"]];
    [self addSubview:self.versionL];
    [self.versionL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoIamge.mas_bottom).offset(5);
    }];
}

#pragma mark - cell的点击事件
- (void)backButtonAction:(UIButton *)sender {
    [self dismissAlert];
}

- (void)userAgreementAction:(UIButton *)sender {

    _titleLa.text = NSLocalizedString(@"Login.userAgreement", nil);
    NSString *host = [NSString stringWithFormat:@"%@/user-protocal-%@.html", sSchoolLogin,[TKUntilTool getAgreementLanguage]];
    NSString *param = [NSString stringWithFormat:@"?from=web&name=%@&company=%@&email=%@&telphone=%@", NSLocalizedString(@"TKProjectName", nil), NSLocalizedString(@"TKProjectName", nil),@"",@""];
    param = [param stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * path = [NSString stringWithFormat:@"%@%@", host, param];
    NSURL *urlPath = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlPath];
    [self.wkWebView loadRequest:request];


}

- (void)privacyAgreementAction:(UIButton *)sender {
    _titleLa.text = NSLocalizedString(@"Login.privacyAgreement", nil);
    NSString *host = [NSString stringWithFormat:@"%@/privacy-policy-%@.html", sSchoolLogin,[TKUntilTool getAgreementLanguage]];
    NSString *param = [NSString stringWithFormat:@"?from=web&name=%@&company=%@&email=%@&telphone=%@", NSLocalizedString(@"TKProjectName", nil),  NSLocalizedString(@"TKProjectName", nil),@"",@""];
    param = [param stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString * path = [NSString stringWithFormat:@"%@%@", host, param];
    
    NSURL *urlPath = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlPath];
    [self.wkWebView loadRequest:request];

}

-(void)permissionAction:(UIButton *)sender {
    [self.permissionView show:self];
}

- (void)versionUpdateAction:(UIButton *)sender {
    NSString *appStoreURL = [NSString stringWithFormat:kAppStoreFormat, [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"APP_STORE_ID"] longValue]];
    NSURL *url = [NSURL URLWithString:appStoreURL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
    }

}

- (void)icpBtnClicked:(UIButton *)sender{
    NSURL *urlPath = [NSURL URLWithString:@"https://beian.miit.gov.cn/"];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlPath];
    [self.wkWebView loadRequest:request];
}

- (void)checkDeviceSwitchAction:(UISwitch *)mySwitch {
    if (mySwitch.on == YES) {
        [[NSUserDefaults standardUserDefaults] setObject_TKSafe:@"1" forKey:@"isShowDeveiceCheckView"];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject_TKSafe:@"0" forKey:@"isShowDeveiceCheckView"];
    }
}

- (void)show:(UIView *)view
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }];
}


- (void)dismissAlert
{
    tk_weakify(self);
    if (_wkWebView && _wkWebView.superview) {
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.wkWebView.x = self.bounds.size.width;
        }completion:^(BOOL finished){
            [weakSelf.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
            [weakSelf.wkWebView removeFromSuperview];
            weakSelf.wkWebView = nil;
            
        }];
        _titleLa.text = NSLocalizedString(@"Login.aboutUS", nil);
    }
    else {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect rect = self.frame;
            self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
        }completion:^(BOOL finished){
            weakSelf.wkWebView = nil;
            [weakSelf removeFromSuperview];
            
        }];
    }
}


#pragma mark - setter
- (TKSPContentView *)contentView {
    if (!_contentView) {
        _contentView = [[TKSPContentView alloc] initWithFrame:self.frame];
    }
    return _contentView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        
        UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backbutton setImage:[UIImage imageNamed:@"tk_loginSetting_back"] forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:backbutton];
        
        [backbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backView).offset(10);
            make.centerY.equalTo(_backView.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
                
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = NSLocalizedString(@"Login.aboutUS", nil);
        _titleLa.font = [UIFont systemFontOfSize:17];
        _titleLa.textColor = HexRGB("#47474B");
        _titleLa.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_titleLa];
        [_titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backView);
            make.centerY.equalTo(backbutton.mas_centerY);
        }];
    }
    return _backView;
}

- (UIImageView *)logoIamge {
    if (!_logoIamge) {
        _logoIamge = [[UIImageView alloc] init];
        _logoIamge.image = [UIImage imageNamed:@"tk_login_logo"];
        _logoIamge.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoIamge;
}


- (UIView *)userAgreementCell {
    if (!_userAgreementCell) {
        _userAgreementCell = [self creatCellViewImage:nil title:NSLocalizedString(@"Login.userAgreement", nil) buttonName:@"tk_login_nextbutton" action:@selector(userAgreementAction:)];
    }
    return _userAgreementCell;
}

- (UIView *)privacyAgreementCell {
    if (!_privacyAgreementCell) {
        _privacyAgreementCell = [self creatCellViewImage:nil title:NSLocalizedString(@"Login.privacyAgreement", nil) buttonName:@"tk_login_nextbutton" action:@selector(privacyAgreementAction:)];
    }
    return _privacyAgreementCell;
}

- (UIView *)versionUpdateCell {
    if (!_versionUpdateCell) {
        _versionUpdateCell = [self creatCellViewImage:nil title:NSLocalizedString(@"Login.versionUpdate", nil) buttonName:@"tk_login_nextbutton" action:@selector(versionUpdateAction:)];
    }
    return _versionUpdateCell;
}

- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = [UIColor colorWithHexColorString:@"8C8E97"];
        _versionLabel.text =  [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"sys-clientVersion"]];
        _versionLabel.font = [UIFont systemFontOfSize:13];
    }
    return _versionLabel;
}

- (UIView *)creatCellViewImage:(NSString *)imageName title:(NSString *)title buttonName:(NSString *)buttonName action:(SEL)action {
    UIView *cellView = [[UIView alloc] init];
    cellView.backgroundColor = UIColor.whiteColor;
    cellView.layer.cornerRadius = 7;

    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.text = title;
    titleLa.textColor = HexRGB("#524F66");
    titleLa.font = [UIFont systemFontOfSize:16];
    [cellView addSubview:titleLa];
    [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellView.mas_left).offset(23);
        make.centerY.equalTo(cellView);
    }];
    
    UIImageView *nextImage = [[UIImageView alloc] init];
    nextImage.image = [UIImage imageNamed:buttonName];
    [cellView addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellView.mas_right).offset(-15);
        make.centerY.equalTo(cellView);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [cellView addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellView.mas_right);
//        make.centerY.equalTo(cellView);
//        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(cellView);
        make.left.equalTo(cellView);
        make.bottom.equalTo(cellView.mas_bottom);
    }];
    
    
    return cellView;
}

- (WKWebView *)wkWebView {
    
    if (_wkWebView == nil) {
        
        WKPreferences *preference = [[WKPreferences alloc] init];
        preference.minimumFontSize =0;
        preference.javaScriptEnabled = YES;
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = preference;
        config.allowsInlineMediaPlayback = YES;
        
        
        CGRect rect = CGRectMake(0, StatusBarH + 50, self.bounds.size.width, self.bounds.size.height - StatusBarH - 50);
        _wkWebView = [[WKWebView alloc] initWithFrame:rect configuration:config];
        
    }
    [self addSubview:_wkWebView];
    return _wkWebView;
}

- (TKLoginPermissionView *)permissionView {
    if (!_permissionView) {
        _permissionView = [[TKLoginPermissionView alloc] initWithFrame:self.frame];
    }
    return _permissionView;
}




@end
