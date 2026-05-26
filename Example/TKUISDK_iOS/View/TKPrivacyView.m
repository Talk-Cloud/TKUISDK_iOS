//
//  TKPrivacyView.m
//  TKUISDK
//
//  Created by zjt on 2021/1/12.
//  Copyright © 2021 Yi. All rights reserved.
//

#import "TKPrivacyView.h"
#import <WebKit/WebKit.h>



@interface TKPrivacyView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) WKWebView    *wkWebView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, copy) NSString  * titleString;

@end
@implementation TKPrivacyView


+ (void)showPrivacyViewWithType:(PrivacyView_Type)type{
    TKPrivacyView * view  = [[TKPrivacyView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.type = type;
    [TKMainWindow addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.backgroundColor = [UIColor colorWithHexColorString:@"f8f9fb"];
    self.backView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), StatusBarH + 50);
    [self addSubview:self.backView];
    [self addSubview:self.wkWebView];
}


- (void)backButtonAction:(UIButton *)sender{
    [self removeFromSuperview];
}



- (void)setType:(PrivacyView_Type)type{
    NSString * host = @"";
    switch (type) {
        case PrivacyView_PrivacyPolicy:
            self.titleString =NSLocalizedString(@"Login.privacypolicy", nil);
            host = [NSString stringWithFormat:@"%@/privacy-policy-%@.html", sSchoolLogin,[TKUntilTool getAgreementLanguage]];
            break;
        case PrivacyView_UserPolicy:
            self.titleString =NSLocalizedString(@"Login.userPrivacyt", nil);
            host = [NSString stringWithFormat:@"%@/user-protocal-%@.html", sSchoolLogin,[TKUntilTool getAgreementLanguage]];
            break;
        default:
            break;
    }
    self.titleLa.text = self.titleString;
    NSString *param = [NSString stringWithFormat:@"?from=web&name=%@&company=%@&email=%@&telphone=%@", NSLocalizedString(@"TKProjectName", nil),  NSLocalizedString(@"TKCompanyName", nil),@"",@""];
    param = [param stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString * path = [NSString stringWithFormat:@"%@%@", host, param];
    NSURL *urlPath = [NSURL URLWithString:path];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlPath];
    [self.wkWebView loadRequest:request];
}

#pragma mark - Getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backView.badgeColor = [UIColor redColor];
        [backbutton setImage:[UIImage imageNamed:@"tk_loginSetting_back"] forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:backbutton];
        [backbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backView).offset(10);
            make.centerY.equalTo(_backView.mas_bottom).offset(-25);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
                
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = NSLocalizedString(@"Login.setting", nil);
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

- (NSString *)urlEnCode:(NSString *)url{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString * stringUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return stringUrl;
}
@end
