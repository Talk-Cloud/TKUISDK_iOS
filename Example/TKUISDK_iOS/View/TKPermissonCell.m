//
//  TKPermissonCell.m
//  TKUISDK
//
//  Created by EDY on 2023/2/17.
//  Copyright © 2023 Yi. All rights reserved.
//

#import "TKPermissonCell.h"

@interface TKPermissonCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *settingLab;
@property (nonatomic, strong) UIImageView *iconIV;

@end

@implementation TKPermissonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = HexRGB("#F8F9FB");
        [self initUI];
    }
    return self;
}

-(void)initUI {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLab];
    [self.bgView addSubview:self.detailLab];
    [self.bgView addSubview:self.settingLab];
    [self.bgView addSubview:self.iconIV];
    
    [self setConstraints];

}

-(void)setConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(Fit(20));
        make.top.bottom.equalTo(self.contentView).inset(Fit(5));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(Fit(20));
        make.trailing.lessThanOrEqualTo(self.settingLab.mas_leading).offset(-Fit(30));
        make.top.equalTo(self.bgView).offset(Fit(16));
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bgView).offset(Fit(20));
        make.trailing.lessThanOrEqualTo(self.settingLab.mas_leading).offset(-Fit(30));
        make.top.equalTo(self.nameLab.mas_bottom).offset(Fit(3));
        make.bottom.equalTo(self.bgView).offset(-Fit(16));
    }];
    
    [self.settingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(9, 15));
        make.centerY.equalTo(self.bgView);
        make.trailing.equalTo(self.bgView).offset(-Fit(20));
        make.leading.equalTo(self.settingLab.mas_trailing).offset(Fit(10));
    }];
}


-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = Fit(7);
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)nameLab {
    if(!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = HexRGBA("#000000",0.8);
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.numberOfLines = 0;
    }
    return _nameLab;
}

-(UILabel *)detailLab {
    if(!_detailLab) {
        _detailLab = [[UILabel alloc] init];
        _detailLab.textColor = HexRGBA("#9597A4",1);
        _detailLab.font = [UIFont systemFontOfSize:12];
        _detailLab.numberOfLines = 0;
    }
    return _detailLab;
}

-(UILabel *)settingLab {
    if(!_settingLab) {
        _settingLab = [[UILabel alloc] init];
        _settingLab.textColor = HexRGBA("#9597A4",1);
        _settingLab.font = [UIFont systemFontOfSize:14];
        _settingLab.text = NSLocalizedString(@"Login.toSetting", nil);
    }
    return _settingLab;
}

-(UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_login_nextbutton"]];
    }
    return _iconIV;
}
@end
