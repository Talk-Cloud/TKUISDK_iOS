//
//  TKLoginPermissionView.m
//  TKUISDK
//
//  Created by EDY on 2023/2/17.
//  Copyright © 2023 Yi. All rights reserved.
//

#import "TKLoginPermissionView.h"
#import "TKPermissonCell.h"


@interface TKLoginPermissionView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;


@end


@implementation TKLoginPermissionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"f8f9fb"];
        [self initData];
        [self addSubview:self.backView];
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self);
            make.top.equalTo(self).offset(StatusBarH + 50);
        }];

    }
    return self;
}

//NSLocalizedString(@"Login.toSetting", nil)
-(void)initData {
    self.dataSource = @[
        @{@"name" : NSLocalizedString(@"Login.permissionCameraName", nil), @"detail" : NSLocalizedString(@"Login.permissionCameraDetail", nil)},
        @{@"name" : NSLocalizedString(@"Login.permissionPhotoName", nil), @"detail" : NSLocalizedString(@"Login.permissionPhotoDetail", nil)},
        @{@"name" : NSLocalizedString(@"Login.permissionMicrophoneName", nil), @"detail" : NSLocalizedString(@"Login.permissionMmicrophoneDetail", nil)},
        @{@"name" : NSLocalizedString(@"Login.permissionLocationName", nil), @"detail" : NSLocalizedString(@"Login.permissionLocationDetail", nil)}
    ];
    [self.tableView reloadData];
}

- (void)backButtonAction:(UIButton *)sender {
    [self dismissAlert];
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
    [UIView animateWithDuration:0.3f animations:^{
        
        CGRect rect = self.frame;
        self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
        
    }completion:^(BOOL finished){
        
        [self removeFromSuperview];
        
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TKPermissonCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TKPermissonCell class])];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.nameLab.text = dic[@"name"];
    cell.detailLab.text = dic[@"detail"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }

    }
}

#pragma mark - 懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), StatusBarH + 50);
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
        _titleLa.text = NSLocalizedString(@"Login.permission",nil);
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

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
        [_tableView registerClass:[TKPermissonCell class] forCellReuseIdentifier:NSStringFromClass([TKPermissonCell class])];
    }
    return _tableView;
}
@end
