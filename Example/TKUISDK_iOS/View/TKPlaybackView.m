//
//  TKPlaybackView.m
//  TKUIDEMO
//
//  Created by edy on 2025/7/30.
//  Copyright © 2025 李合意. All rights reserved.
//

#import "TKPlaybackView.h"
#import "TKLoginAlert.h"
#import "TKPlaybackCell.h"
#import "TKPlaybackTimeView.h"

#define PageSize 20

@interface TKPlaybackView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *roomidLab;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIButton *selectedTimeBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *emptyLab;

@property (nonatomic, strong) NSDictionary *roomParam;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int starttime;
@property (nonatomic, assign) int endtime;

@end

@implementation TKPlaybackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexColorString:@"ffffff"];
        self.dataSource = [[NSMutableArray alloc] init];
        self.page = 1;
        
        [self addSubview:self.backBtn];
        [self addSubview:self.roomidLab];
        [self addSubview:self.tipLab];
        [self addSubview:self.selectedTimeBtn];
        [self addSubview:self.collectionView];
        [self addSubview:self.emptyLab];
        [self setConstraints];
        
    }
    return self;
}

-(void)setConstraints {
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(self).offset(StatusBarH);
    }];
    
    [self.roomidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(IS_PAD ? 60 : 30);
        make.top.equalTo(self.backBtn.mas_bottom).offset(IS_PAD ? 20 : 10);
        make.height.mas_equalTo(42);
    }];
    
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomidLab);
        make.top.equalTo(self.roomidLab.mas_bottom);
    }];
    
    CGFloat width = [sAllTime widthWithFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14] height:36];
    [self.selectedTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomidLab);
        make.top.equalTo(self.tipLab.mas_bottom).offset(30);
        make.width.mas_equalTo(width + 58);
        make.height.mas_equalTo(36);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.selectedTimeBtn.mas_bottom).offset(20);
    }];
    
    [self.emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.collectionView);
        make.centerY.equalTo(self.collectionView).offset(-Fit(30));
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.selectedTimeBtn setImagePositionWithType:ImagePositionTypeRight spacing:4];
}

- (void)show:(UIView *)view withData:(NSArray *)array{
    CGRect rect = self.frame;
    self.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }];
    
    if(self.roomParam[@"serial"]){
        self.roomidLab.text = self.roomParam[@"serial"];
    }
    self.dataSource = array.mutableCopy;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    if(self.dataSource.count >= PageSize){
        self.collectionView.mj_footer = [TKMJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    [self.collectionView reloadData];
}

- (void)dismissAlert
{
    tk_weakify(self);
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = weakSelf.frame;
        weakSelf.frame = CGRectMake(CGRectGetWidth(self.frame), rect.origin.y, rect.size.width, rect.size.height);
    }completion:^(BOOL finished){
        [weakSelf removeFromSuperview];
    }];
}

- (void)calculateTimestampsForDateString:(NSString *)dateString {
    // 1. 配置日期格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.timeZone = [NSTimeZone systemTimeZone]; // 使用系统时区（关键：避免UTC导致的时差）
    
    // 2. 将字符串转换为NSDate
    NSDate *date = [formatter dateFromString:dateString];
    if (!date) {
        return;
    }
    
    // 3. 获取日历对象（用于提取和修改日期组件）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone systemTimeZone]; // 与格式化器保持同时区
    
    // 4. 计算当天0点时间戳
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *startOfDay = [calendar dateFromComponents:components];
    NSTimeInterval startTimestamp = [startOfDay timeIntervalSince1970]; // 0点时间戳（秒）
    
    // 5. 计算当天24点时间戳（即第二天0点）
    components.day += 1; // 日期加1天
    NSDate *endOfDay = [calendar dateFromComponents:components];
    NSTimeInterval endTimestamp = [endOfDay timeIntervalSince1970]; // 24点时间戳（秒）
    
    self.starttime = startTimestamp;
    self.endtime = endTimestamp;
}

-(void)updateSelectedTimeBtnWidth:(NSString *)timeStr{
    CGFloat width = [timeStr widthWithFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14] height:36];
    [self.selectedTimeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width + 58);
    }];
}

#pragma mark - Action
-(void)selectTimeClick:(UIButton *)button{
    TKPlaybackTimeView *timeView = [TKPlaybackTimeView showPopViewAddedTo:self pointingAtView:button currentTime:button.titleLabel.text];
    tk_weakify(self);
    timeView.selectedTimeBlock = ^(NSString * _Nonnull selectTime) {
        [weakSelf.selectedTimeBtn setTitle:selectTime forState:UIControlStateNormal];
        [weakSelf updateSelectedTimeBtnWidth:selectTime];
        if([selectTime isEqualToString:sAllTime]){
            weakSelf.starttime = 0;
            weakSelf.endtime = 0;
        }else{
            [weakSelf calculateTimestampsForDateString:selectTime];
        }
        [weakSelf loadNewData];
    };
}

-(void)backButtonAction:(UIButton *)button{
    self.page = 1;
    self.starttime = 0;
    self.endtime = 0;
    [self.selectedTimeBtn setTitle:sAllTime forState:UIControlStateNormal];
    [self updateSelectedTimeBtnWidth:sAllTime];
    self.collectionView.mj_footer = nil;

    [self dismissAlert];
}

- (NSString *)formatTimeRangeWithStartTime:(NSNumber *)startTime duration:(NSTimeInterval)duration {
    
       NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTime.doubleValue];

       // 计算结束时间
       NSDate *endTime = [startDate dateByAddingTimeInterval:duration];
       
       // 初始化日期格式化器
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.timeZone = [NSTimeZone localTimeZone]; // 使用本地时区
       formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]; // 中文环境
       
       // 判断是否同一天
       NSCalendar *calendar = [NSCalendar currentCalendar];
       BOOL isSameDay = [calendar isDate:startDate inSameDayAsDate:endTime];
       
       // 格式化开始时间和结束时间
       NSString *startStr;
       NSString *endStr;
       
       if (isSameDay) {
           // 同一天：开始时间显示日期+时间，结束时间仅显示时间
           formatter.dateFormat = @"yyyy-MM-dd HH:mm";
           startStr = [formatter stringFromDate:startDate];
           
           formatter.dateFormat = @"HH:mm";
           endStr = [formatter stringFromDate:endTime];
       } else {
           // 跨天：两者都显示日期+时间
           formatter.dateFormat = @"yyyy-MM-dd HH:mm";
           startStr = [formatter stringFromDate:startDate];
           endStr = [formatter stringFromDate:endTime];
       }
       
       // 拼接结果
       return [NSString stringWithFormat:@"%@～%@", startStr, endStr];
}

#pragma mark - request
-(void)loadNewData {
    self.page = 1;
    [self checkRoomPlaybackWithParam:@{} callBack:^(NSDictionary * _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];

        if([responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
            NSArray *list = responseObject[@"data"][@"list"];
            // 清空原有数据
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:list];
            [self.collectionView reloadData];
            
            self.emptyLab.hidden = (self.dataSource.count != 0);
            if(self.dataSource.count < PageSize){
                self.collectionView.mj_footer = nil;
            }else{
                self.collectionView.mj_footer = [TKMJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            }
        }
    }];
}

-(void)loadMoreData {
    self.page++;
    [self checkRoomPlaybackWithParam:@{} callBack:^(NSDictionary * _Nullable responseObject) {
        [self.collectionView.mj_footer endRefreshing];

        if([responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
            NSArray *list = responseObject[@"data"][@"list"];
            [self.dataSource addObjectsFromArray:list];
            // 刷新列表
            [self.collectionView reloadData];
            
            //设置底部刷新状态
            if (list.count < PageSize) {
                // 没有更多数据
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    }];
 
}

- (void)checkRoomPlaybackWithParam:(NSDictionary *)roomParam callBack:(void(^)(NSDictionary * _Nullable responseObject))callBack{

    if(roomParam.count > 0){
        self.roomParam = roomParam;
    }
    
    NSMutableDictionary *parameters = self.roomParam.mutableCopy;
    
    NSInteger  ts = [TKUntilTool getNowTimeTimestamp] * 1000;
    [parameters setObject_TKSafe:@(ts) forKey:@"ts"];
    [parameters setObject_TKSafe:@(self.page) forKey:@"page"];
    [parameters setObject_TKSafe:@(PageSize) forKey:@"pageSize"];

    if(self.starttime > 0){
        [parameters setObject_TKSafe:@(self.starttime) forKey:@"starttime"];
    }
    if(self.endtime > 0){
        [parameters setObject_TKSafe:@(self.endtime) forKey:@"endtime"];
    }
    
    NSString * urlString = [NSString stringWithFormat:@"%@://%@:%@/client/ui/v1/getRoomRecordList", sHttp, sHost, sPort];
    [[TKNetTool shareInstance] POST:urlString parameters:parameters successCallBack:^(NSDictionary * _Nonnull responseObject) {
        callBack(responseObject);
    } progressCallBack:^(NSProgress * _Nonnull progressObject) {
        
    } failureCallBack:^(NSError * _Nonnull error) {
        callBack(nil);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TKPlaybackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TKPlaybackCell class]) forIndexPath:indexPath];
    if(indexPath.row < self.dataSource.count){
        NSDictionary *dic = self.dataSource[indexPath.row];
        NSNumber *starttime = dic[@"starttime"];
        NSNumber *duration = dic[@"duration"];
        if(starttime && duration){
            cell.timeStr = [self formatTimeRangeWithStartTime:starttime duration:duration.doubleValue];
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < self.dataSource.count){
        NSDictionary *dic = self.dataSource[indexPath.row];
        if(self.joinPlaybackRoomBlock){
            self.joinPlaybackRoomBlock(dic);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_PAD){
        return CGSizeMake((ScreenW - 138)/2, 50);
    }else{
        if(indexPath.row < self.dataSource.count){
            NSDictionary *dic = self.dataSource[indexPath.row];
            NSNumber *starttime = dic[@"starttime"];
            NSNumber *duration = dic[@"duration"];
            //计算如果一行展示不下，展示两行
            if(starttime && duration){
                NSString *timeStr = [self formatTimeRangeWithStartTime:starttime duration:duration.doubleValue];
                CGFloat width = [timeStr widthWithFont:[UIFont systemFontOfSize:16] height:20];
                if(width > SCREEN_WIDTH - 120){
                    return CGSizeMake(SCREEN_WIDTH - 60, 64);
                }
            }
        }
        return CGSizeMake(SCREEN_WIDTH - 60, 50);
    }
}

#pragma mark -
-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"tk_loginSetting_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UILabel *)roomidLab{
    if(!_roomidLab){
        _roomidLab = [[UILabel alloc] init];
        _roomidLab.textColor = HexRGB("#222222");
        _roomidLab.font = [UIFont systemFontOfSize:30];
    }
    return _roomidLab;
}

-(UILabel *)tipLab{
    if(!_tipLab){
        _tipLab = [[UILabel alloc] init];
        _tipLab.textColor = HexRGBA("#000000", 0.6);
        _tipLab.font = [UIFont systemFontOfSize:16];
        _tipLab.text = NSLocalizedString(@"Playback.select", nil);
    }
    return _tipLab;
}

-(UIButton *)selectedTimeBtn{
    if(!_selectedTimeBtn){
        _selectedTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedTimeBtn.backgroundColor = HexRGB("#F8F8FA");
        _selectedTimeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _selectedTimeBtn.layer.cornerRadius = 8;
        [_selectedTimeBtn setTitleColor:HexRGB("#232325") forState:UIControlStateNormal];
        [_selectedTimeBtn setTitle:sAllTime forState:UIControlStateNormal];
        [_selectedTimeBtn setImage:[UIImage imageNamed:@"tk_playback_down"] forState:UIControlStateNormal];
        [_selectedTimeBtn setImage:[UIImage imageNamed:@"tk_playback_up"] forState:UIControlStateSelected];
        [_selectedTimeBtn addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedTimeBtn;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 16;
        flowLayout.minimumLineSpacing = IS_PAD ? 16 : 10;
        flowLayout.sectionInset = IS_PAD ? UIEdgeInsetsMake(10, 60, 10, 60) : UIEdgeInsetsMake(10, 30, 10, 30);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TKPlaybackCell class] forCellWithReuseIdentifier:NSStringFromClass([TKPlaybackCell class])];
        _collectionView.mj_header = [TKMJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _collectionView;
}

-(UILabel *)emptyLab {
    if (!_emptyLab) {
        _emptyLab = [[UILabel alloc] init];
        _emptyLab.textColor = HexRGB("#C2C3C6");
        _emptyLab.text = NSLocalizedString(@"Playback.nodata", nil);
        _emptyLab.hidden = YES;
    }
    return _emptyLab;
}
@end
