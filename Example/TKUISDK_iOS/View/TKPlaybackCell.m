//
//  TKPlaybackCell.m
//  TKUIDEMO
//
//  Created by edy on 2025/7/30.
//  Copyright © 2025 李合意. All rights reserved.
//

#import "TKPlaybackCell.h"

@interface TKPlaybackCell()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIImageView *iconIV;

@end

@implementation TKPlaybackCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.contentView.backgroundColor = HexRGB("#F8F8F8");
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.iconIV];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
        make.left.greaterThanOrEqualTo(self.timeLab.mas_right).offset(10);
    }];
}

-(void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    self.timeLab.text = timeStr;
}

#pragma mark -
-(UILabel *)timeLab{
    if(!_timeLab){
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = HexRGB("#000000");
        _timeLab.font = [UIFont systemFontOfSize:16];
        _timeLab.numberOfLines = 2;
    }
    return _timeLab;
}

-(UIImageView *)iconIV{
    if(!_iconIV){
        _iconIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_playback_icon"]];
    }
    return _iconIV;
}
@end
