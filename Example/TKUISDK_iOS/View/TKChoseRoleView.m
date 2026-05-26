//
//  TKChoseRoleView.m
//  TKUISDK
//
//  Created by zjt on 2024/11/30.
//  Copyright © 2024 Yi. All rights reserved.
//

#import "TKChoseRoleView.h"
@interface TKChoseRoleView ()
@property (nonatomic, strong) UIView * roleView;
@property (nonatomic, strong) UILabel * titleL;
@property (nonatomic, strong) UIButton * closeBtn;
@property (nonatomic, strong) UIButton * teaBnt;
@property (nonatomic, strong) UIButton * stuBnt;
@property (nonatomic, strong) UIButton * patrolBnt;
@property (nonatomic, strong) UIButton * auditorBnt;
@property (nonatomic, strong) NSMutableArray * btnArr;
@end
@implementation TKChoseRoleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        self.btnArr = [[NSMutableArray alloc]init];
        [self loadSubViews];
        [self loadLayout];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.roleView.layer.cornerRadius = 30.0;
    if (@available(iOS 11.0, *)) {
        self.roleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    } else {
        // Fallback on earlier versions
    }
    self.roleView.layer.masksToBounds = YES;
}

- (void)loadSubViews{
    self.backgroundColor = HexRGBA("#000000", 0.5);
    
    self.roleView = [[UIView alloc]init];
    self.roleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.roleView];
    
    self.titleL = [[UILabel alloc]init];
    self.titleL.font = [UIFont fontWithName:@"DINAlternate-Bold" size:20];
    self.titleL.textColor = HexRGB("#232325");
    self.titleL.textAlignment = NSTextAlignmentLeft;
    self.titleL.text = NSLocalizedString(@"Label.choiceRoleViewIdentity", nil);
    [self.roleView addSubview:self.titleL];
    
    self.closeBtn = [[UIButton alloc]init];
    [self.closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn setImage:[UIImage imageNamed:@"tk_login_close"] forState:UIControlStateNormal];
    [self.roleView addSubview:self.closeBtn];
    
    self.teaBnt = [[UIButton alloc]init];
    self.teaBnt.layer.cornerRadius = Fit(25);
    self.teaBnt.layer.masksToBounds = YES;
    [self.teaBnt addTarget:self action:@selector(roleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.teaBnt setTitle:NSLocalizedString(@"Role.Teacher", nil) forState:UIControlStateNormal];
    [self.teaBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.teaBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.teaBnt.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.teaBnt setBackgroundColor:HexRGB("#F6F8FC")];
    self.teaBnt.tag = 10000;
    [self.roleView addSubview:self.teaBnt];
    [self.btnArr addObject:self.teaBnt];
    
    self.stuBnt = [[UIButton alloc]init];
    self.stuBnt.layer.cornerRadius = Fit(25);
    self.stuBnt.layer.masksToBounds = YES;
    [self.stuBnt addTarget:self action:@selector(roleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.stuBnt setTitle:NSLocalizedString(@"Role.Student", nil) forState:UIControlStateNormal];
    [self.stuBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stuBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.stuBnt.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.stuBnt setBackgroundColor:HexRGB("#F6F8FC")];
    self.stuBnt.tag = 10002;
    [self.roleView addSubview:self.stuBnt];
    [self.btnArr addObject:self.stuBnt];
    
    self.patrolBnt = [[UIButton alloc]init];
    self.patrolBnt.layer.cornerRadius = Fit(25);
    self.patrolBnt.layer.masksToBounds = YES;
    [self.patrolBnt addTarget:self action:@selector(roleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.patrolBnt setTitle:NSLocalizedString(@"Role.Patrol", nil) forState:UIControlStateNormal];
    [self.patrolBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.patrolBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.patrolBnt.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.patrolBnt setBackgroundColor:HexRGB("#F6F8FC")];
    self.patrolBnt.tag = 10004;
    [self.roleView addSubview:self.patrolBnt];
    [self.btnArr addObject:self.patrolBnt];
    
    self.auditorBnt = [[UIButton alloc]init];
    self.auditorBnt.layer.cornerRadius = Fit(25);
    self.auditorBnt.layer.masksToBounds = YES;
    [self.auditorBnt addTarget:self action:@selector(roleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.auditorBnt setTitle:NSLocalizedString(@"Role.Auditor", nil) forState:UIControlStateNormal];
    [self.auditorBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.auditorBnt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.auditorBnt.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.auditorBnt setBackgroundColor:HexRGB("#F6F8FC")];
    self.auditorBnt.tag = 10006;
    [self.roleView addSubview:self.auditorBnt];
    [self.btnArr addObject:self.auditorBnt];
}


- (void)loadLayout{
    CGFloat itemSizeW = Fit(440);
    CGFloat itemSizeH = Fit(50);
    
    [self.roleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);

    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.roleView).offset(Fit(20));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleL);
        make.right.equalTo(self.roleView).offset(-Fit(20));
        make.size.mas_equalTo(CGSizeMake(Fit(25), Fit(25)));
    }];
    
    [self.auditorBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.roleView);
        make.size.mas_equalTo(CGSizeMake(itemSizeW, itemSizeH));
        make.bottom.equalTo(self.roleView).offset(-Fit(45));
    }];
    
    [self.patrolBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.roleView);
        make.size.mas_equalTo(CGSizeMake(itemSizeW, itemSizeH));
        make.bottom.equalTo(self.auditorBnt.mas_top).offset(-Fit(14));
    }];
    
    [self.stuBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.roleView);
        make.size.mas_equalTo(CGSizeMake(itemSizeW, itemSizeH));
        make.bottom.equalTo(self.patrolBnt.mas_top).offset(-Fit(14));
    }];
    
    [self.teaBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.roleView);
        make.size.mas_equalTo(CGSizeMake(itemSizeW, itemSizeH));
        make.bottom.equalTo(self.stuBnt.mas_top).offset(-Fit(14));
        make.top.equalTo(self.roleView).offset(Fit(60));
    }];
    
    
}

- (void)setCurrentRole:(NSInteger)currentRole{
    _currentRole = currentRole;
    for (UIButton * btn in self.btnArr) {
        if (btn.tag == currentRole + 10000) {
            [btn setBackgroundColor:HexRGB("#3997F8")];
            btn.selected = YES;
        }else{
            [btn setBackgroundColor:HexRGB("#F6F8FC")];
            btn.selected = NO;
        }
    }
}

#pragma mark - Click
- (void)closeBtnClicked{
    [self removeFromSuperview];
    if(!self.currentRole){
        if (self.choseRoleBtnBlock) {
            self.choseRoleBtnBlock(self.teaBnt);
        }
    }
}

- (void)roleBtnClicked:(UIButton *)btn{
    self.currentRole = btn.tag - 10000;
    if (self.choseRoleBtnBlock) {
        self.choseRoleBtnBlock(btn);
    }
    [self closeBtnClicked];
}
@end
