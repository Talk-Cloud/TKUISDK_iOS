//
//  TKLoginSettingView.m
//  EduClass
//
//  Created by Evan on 2020/3/24.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#define CheckProportion (ScreenH < ScreenW ? ScreenW/1024.0 : ScreenH/1024.0)
#define kAppStoreFormat @"https://itunes.apple.com/app/id%ld"

#import "TKLoginSettingView.h"
#import "TKSPContentView.h"
#import <WebKit/WebKit.h>
#import "TKLoginPermissionView.h"
#import "TKAboutUSView.h"


@interface TKLoginSettingView ()
@property (nonatomic, strong) TKSPContentView *contentView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *logoIamge;
@property (nonatomic, strong) UIView *permissionCell;// 权限管理
@property (nonatomic, strong) UIView *checkDeviceCell; // 开启设备检测
@property (nonatomic, strong) UIView *aboutUSCell; // 关于我们
@property (nonatomic, strong) UILabel *CheckDevicReminderLa;
@property (nonatomic,assign) CGFloat property;
@property (nonatomic, strong) UISwitch *checkDeviceSwitch;
@property (nonatomic,assign) UIInterfaceOrientation interfaceOriention;
@property (nonatomic, strong) WKWebView    *wkWebView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) TKLoginPermissionView *permissionView;
@property (nonatomic, strong) TKAboutUSView * aboutUSView;

@end

@implementation TKLoginSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"f8f9fb"];
        
        [self addSubview:self.backView];
        [self addSubview:self.logoIamge];
        [self addSubview:self.permissionCell];
        [self addSubview:self.checkDeviceCell];
        [self addSubview:self.aboutUSCell];
        [self loadSubviews];
    }
    return self;
}


- (void)loadSubviews{
    
    
    self.contentView.frame = self.frame;
    
    self.backView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), StatusBarH + 44);
    
    self.logoIamge.frame  = CGRectMake(0, CGRectGetHeight(self.backView.frame) + 60 * CheckProportion, CGRectGetWidth(self.frame), 80);
    
    self.logoIamge.hidden = NO;
    self.property = 1;
    _CheckDevicReminderLa.numberOfLines = 2;
    self.permissionCell.frame = CGRectMake(24, CGRectGetMaxY(self.logoIamge.frame) + 60 * CheckProportion, CGRectGetWidth(self.frame) - 48, 63 * _property);
    self.checkDeviceCell.frame = CGRectMake(24, CGRectGetMaxY(self.permissionCell.frame)+ 16, CGRectGetWidth(self.frame) - 48, (IS_PAD ? 89 : 102) * _property);
    self.checkDeviceSwitch.y = (89 * _property - 30)/2;
    _checkDeviceSwitch.x = CGRectGetWidth(self.frame) - 24 - 15 - 75;
    _checkDeviceSwitch.size = CGSizeMake(50, 30);
    self.aboutUSCell.frame = CGRectMake(24, CGRectGetMaxY(self.checkDeviceCell.frame) + 16, CGRectGetWidth(self.frame) - 48, 63 * _property);
}

#pragma mark - cell的点击事件
- (void)backButtonAction:(UIButton *)sender {
    [self dismissAlert];
}

-(void)permissionAction:(UIButton *)sender {
    [self.permissionView show:self];
}

- (void)aboutUSCellAction:(UIButton *)sender {
    [self.aboutUSView show:self];
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
    
    NSString *isCheckDeviceOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShowDeveiceCheckView"];
    
    if ([isCheckDeviceOn isEqualToString:@"0"]) {
        self.checkDeviceSwitch.on = NO;
    }
    
    CGRect rect = self.frame;
    self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
    [TKMainWindow addSubview:self];
    
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
        weakSelf.titleLa.text = NSLocalizedString(@"Login.setting", nil);
    }
    else {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect rect = weakSelf.frame;
            weakSelf.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
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
            make.centerY.equalTo(_backView.mas_bottom);
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

- (UIImageView *)logoIamge {
    if (!_logoIamge) {
        _logoIamge = [[UIImageView alloc] init];
        _logoIamge.image = [UIImage imageNamed:@"tk_login_logo"];
        _logoIamge.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoIamge;
}

-(UIView *)permissionCell {
    if (!_permissionCell) {
        _permissionCell = [self creatCellViewImage:nil title:NSLocalizedString(@"Login.permission", nil) buttonName:@"tk_login_nextbutton" action:@selector(permissionAction:)];
    }
    return _permissionCell;
}

- (UIView *)aboutUSCell {
    if (!_aboutUSCell) {
        _aboutUSCell = [self creatCellViewImage:nil title:NSLocalizedString(@"Login.aboutUS", nil) buttonName:@"tk_login_nextbutton" action:@selector(aboutUSCellAction:)];
    }
    return _aboutUSCell;
}

- (UILabel *)CheckDevicReminderLa {
    if (!_CheckDevicReminderLa) {
        _CheckDevicReminderLa = [[UILabel alloc] init];
        _CheckDevicReminderLa.text = NSLocalizedString(@"Login.deviceDetectionRe", nil);
        _CheckDevicReminderLa.font = [UIFont systemFontOfSize:13];
//        _CheckDevicReminderLa.textColor = RGBCOLOR(149, 151, 164);
        _CheckDevicReminderLa.numberOfLines = 2;
    }
    return _CheckDevicReminderLa;
}

- (UIView *)checkDeviceCell {
    if (!_checkDeviceCell) {
        _checkDeviceCell = [[UIView alloc] init];
        _checkDeviceCell.backgroundColor = UIColor.whiteColor;
        _checkDeviceCell.layer.cornerRadius = 7;
        
        UILabel *titleLa = [[UILabel alloc] init];
        titleLa.text = NSLocalizedString(@"Login.deviceDetection", nil);
        titleLa.font = [UIFont systemFontOfSize:16];
//        titleLa.textColor = RGBCOLOR(82, 79, 102);
        [_checkDeviceCell addSubview:titleLa];
        [titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_checkDeviceCell.mas_left).offset(23);
            make.top.equalTo(_checkDeviceCell.mas_top).offset(16);
        }];
        
        self.checkDeviceSwitch.y = (89 * _property - 30)/2;
        _checkDeviceSwitch.x = CGRectGetWidth(self.frame) - 24 - 15 - 70;
        _checkDeviceSwitch.size = CGSizeMake(50, 30);
        
        [_checkDeviceCell addSubview:self.checkDeviceSwitch];
        
        [_checkDeviceCell addSubview:self.CheckDevicReminderLa];
        [_CheckDevicReminderLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLa);
            make.top.equalTo(titleLa.mas_bottom).offset(12 * CheckProportion);
            make.right.equalTo(_checkDeviceSwitch.mas_left).offset(-30 * CheckProportion);
        }];
    }
    return _checkDeviceCell;
}

- (UISwitch *)checkDeviceSwitch {
    if (!_checkDeviceSwitch) {
        
        NSString *isCheckDeviceOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShowDeveiceCheckView"];
        
        self.checkDeviceSwitch = [[UISwitch alloc] init];
        self.checkDeviceSwitch.onTintColor = [UIColor colorWithHexColorString:@"#3997F8"];
        [self.checkDeviceSwitch addTarget:self action:@selector(checkDeviceSwitchAction:) forControlEvents:(UIControlEventValueChanged)];
        self.checkDeviceSwitch.on = YES;
        if ([isCheckDeviceOn isEqualToString:@"0"]) {
            self.checkDeviceSwitch.on = NO;
        }
    }
    return _checkDeviceSwitch;
}



- (UIView *)creatCellViewImage:(NSString *)imageName title:(NSString *)title buttonName:(NSString *)buttonName action:(SEL)action {
    UIView *cellView = [[UIView alloc] init];
    cellView.backgroundColor = UIColor.whiteColor;
    cellView.layer.cornerRadius = 7;

    UILabel *titleLa = [[UILabel alloc] init];
    titleLa.text = title;
//    titleLa.textColor = RGBCOLOR(82, 79, 102);
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
        make.top.equalTo(cellView);
        make.left.equalTo(cellView);
        make.bottom.equalTo(cellView.mas_bottom);
    }];
    
    
    return cellView;
}



- (TKLoginPermissionView *)permissionView {
    if (!_permissionView) {
        _permissionView = [[TKLoginPermissionView alloc] initWithFrame:self.frame];
    }
    return _permissionView;
}

- (TKAboutUSView *)aboutUSView {
    if (!_aboutUSView) {
        _aboutUSView = [[TKAboutUSView alloc] initWithFrame:self.frame];
    }
    return _aboutUSView;
}


@end
