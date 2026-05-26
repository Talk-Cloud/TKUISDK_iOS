//
//  TKPlaybackTimeView.m
//  TKUIDEMO
//
//  Created by edy on 2025/7/31.
//  Copyright © 2025 李合意. All rights reserved.
//

#import "TKPlaybackTimeView.h"

@interface TKPlaybackTimeView ()

@property (strong , nonatomic) UIView *targetView;
@property (copy , nonatomic) NSString *currentTime;


@property (strong , nonatomic) UIView *contantBgView;
@property (strong , nonatomic) UIImageView *checkIV;
@property (strong , nonatomic) UIButton *allTimeBtn;
@property (strong , nonatomic) UITextField *selectedTimeTF;

// 时间选择器
@property (nonatomic,strong) UIDatePicker *timeDatePicker;
// 时间选择确定取消
@property (nonatomic,strong) UIToolbar *toobarForDatepicker;

@end

@implementation TKPlaybackTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.contantBgView];
    [self.contantBgView addSubview:self.checkIV];
    [self.contantBgView addSubview:self.allTimeBtn];
    [self.contantBgView addSubview:self.selectedTimeTF];
    
    [self.checkIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.equalTo(self.contantBgView).offset(20);
//        make.centerY.equalTo(self.allTimeBtn);
    }];
    
    [self.allTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contantBgView).offset(46);
        make.top.equalTo(self.contantBgView).offset(14);
    }];
    
    CGFloat width = [NSLocalizedString(@"Playback.selectDate", nil) widthWithFont:[UIFont systemFontOfSize:14] height:38];
    [self.selectedTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(width < 124 ? 128 : width + 4);
        make.left.equalTo(self.allTimeBtn);
        make.bottom.equalTo(self.contantBgView).offset(-14);
    }];
}

+ (TKPlaybackTimeView *)showPopViewAddedTo:(UIView *)containerView pointingAtView:(UIView *)targetView currentTime:(NSString *)currentTime
{
    CGRect rect = CGRectMake(0, 0, containerView.size.width, containerView.size.height);
    TKPlaybackTimeView *popView = [[self alloc] initWithFrame:rect];
    popView.backgroundColor = [UIColor clearColor];
    popView.targetView = targetView;
    popView.currentTime = currentTime;
    [containerView addSubview:popView];

    [popView setConstraints];

    return popView;
}

-(void)setConstraints {
    CGRect frame  = [self.targetView.superview convertRect:self.targetView.frame toView:self];

    [self.contantBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 100));
        make.left.equalTo(self).offset(CGRectGetMinX(frame));
        make.top.equalTo(self).offset(CGRectGetMaxY(frame) + 2);
    }];
    
    if([self.currentTime isEqualToString:sAllTime]){
        [self.checkIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.allTimeBtn);
        }];
    }else{
        self.selectedTimeTF.text = self.currentTime;
        [self.checkIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.selectedTimeTF);
        }];
    }
}

#pragma mark - Action
-(void)cancelChooseTimeClick {
    [self.selectedTimeTF resignFirstResponder];
}

-(void)confirmChooseTimeClick {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStr = [dateFormatter stringFromDate:self.timeDatePicker.date];
    self.selectedTimeTF.text = timeStr;
    [self.selectedTimeTF resignFirstResponder];
    [self hide];

    if(self.selectedTimeBlock){
        self.selectedTimeBlock(timeStr);
    }
}

-(void)allTimeBtnClick:(UIButton *)button {
    if(self.selectedTimeBlock){
        self.selectedTimeBlock(self.allTimeBtn.titleLabel.text);
    }
    [self hide];
}

#pragma mark - touches

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

- (void)hide {
    [self removeFromSuperview];
}

#pragma mark -
-(UIView *)contantBgView{
    if(!_contantBgView){
        _contantBgView = [[UIView alloc] init];
        _contantBgView.backgroundColor = [UIColor whiteColor];
        _contantBgView.layer.cornerRadius = 10;
        _contantBgView.layer.shadowColor = UIColor.blackColor.CGColor;
        _contantBgView.layer.shadowOffset = CGSizeMake(0, 1);
        _contantBgView.layer.shadowOpacity = 0.2;
        _contantBgView.layer.shadowRadius = 10;
    }
    return _contantBgView;
}

-(UIImageView *)checkIV{
    if(!_checkIV){
        _checkIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tk_playback_check"]];
    }
    return _checkIV;
}

-(UIButton *)allTimeBtn{
    if(!_allTimeBtn){
        _allTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allTimeBtn setTitleColor:HexRGB("#232325") forState:UIControlStateNormal];
        _allTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allTimeBtn setTitle:sAllTime forState:UIControlStateNormal];
        [_allTimeBtn addTarget:self action:@selector(allTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allTimeBtn;
}

-(UITextField *)selectedTimeTF{
    if(!_selectedTimeTF){
        _selectedTimeTF = [[UITextField alloc] init];
        _selectedTimeTF.font = [UIFont systemFontOfSize:14];
        _selectedTimeTF.layer.cornerRadius = 8;
        _selectedTimeTF.layer.borderColor = HexRGBA("000000",0.1).CGColor;
        _selectedTimeTF.layer.borderWidth = 0.5;
        _selectedTimeTF.textColor = HexRGB("#000000");
        _selectedTimeTF.textAlignment = NSTextAlignmentLeft;
        _selectedTimeTF.placeholder = NSLocalizedString(@"Playback.selectDate", nil);
        _selectedTimeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 1)];
        _selectedTimeTF.leftViewMode = UITextFieldViewModeAlways;
        _selectedTimeTF.tintColor = [UIColor clearColor];
        _selectedTimeTF.inputView = self.timeDatePicker;
        _selectedTimeTF.inputAccessoryView = self.toobarForDatepicker;
    }
    return _selectedTimeTF;
}

- (UIDatePicker *)timeDatePicker
{
    if(!_timeDatePicker){
        _timeDatePicker = [[UIDatePicker alloc] init];
        _timeDatePicker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            _timeDatePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        _timeDatePicker.locale = [NSLocale currentLocale];
        _timeDatePicker.maximumDate = [NSDate date];
    }
    return _timeDatePicker;
}

- (UIToolbar *)toobarForDatepicker
{
    if (!_toobarForDatepicker) {
        //UIToolBar默认宽度与界面宽度相同，可以不指定它的宽度和XY值，仅指定高度即可
        _toobarForDatepicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
        //创建三个item
        //取消按钮并设置响应的方法
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelChooseTimeClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
        //弹簧按钮
        UIBarButtonItem * springItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //确认按钮并设置响应的方法
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [confirmBtn setTitle:@"完成" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirmChooseTimeClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * confirmItem = [[UIBarButtonItem alloc] initWithCustomView:confirmBtn];
        //将三个item加入到UIToolbar中
        //items属性是UIToolBar中所有item的集合
        _toobarForDatepicker.items = @[cancelItem,springItem,confirmItem];
    }
    return _toobarForDatepicker;
}


@end
