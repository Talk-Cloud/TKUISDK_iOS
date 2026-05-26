//
//  TKLoginViewController.m
//  TKUIDEMO
//
//  Created by zjt on 2024/12/17.
//  Copyright © 2024 李合意. All rights reserved.
//

#import "TKLoginViewController.h"
#import <TKUISDK/TKEduClassManager.h>
//#import <TKLiveSDK/TLEduClassManager.h>
#import "TKLoginInputView.h"
#import "TKSPContentView.h"
#import "TKServiceAndPrivacyAlterView.h"
#import "TKLoginSettingView.h"
#import "TKPassWordHelpView.h"
#import "TKChoseRoleView.h"
#import "TKLoginAlert.h"
#import "TKPlaybackView.h"

//输入框的高度
#define inputHeigt 50
//输入框之间的间距
#define inputMarginTop 20
#define loginButtonHeight 50

@interface TKLoginViewController ()<TKLoginInputViewDelegate,TKEduRoomDelegate>
@property (nonatomic, strong) TKServiceAndPrivacyAlterView *SPAlterView;// 隐私与服务
@property (nonatomic, strong) TKSPContentView *contentView;
@property (nonatomic, strong) TKLoginSettingView *settingView;// 设置页面
@property (nonatomic, strong) TKPlaybackView *playbackView;// 回放页面
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) TKLoginInputView *roomidView;//课堂号
@property (nonatomic, strong) TKLoginInputView *nicknameView;//昵称
@property (nonatomic, strong) TKLoginInputView *passWordView;//密码
@property (nonatomic, strong) TKLoginInputView *roleView;//角色选择器
@property (nonatomic, strong) UIButton *loginButton;//登录按钮
@property (nonatomic, strong) UIButton *playbackButton;//回放按钮
@property (nonatomic, strong) UILabel *versionLabel;//版本号
@property (assign, nonatomic) NSInteger role;
@property (strong, nonatomic) NSString *defaultServer;//默认服务
@property (nonatomic, strong) UIImageView *backgroundImageView;//底层背景图
@property (nonatomic, strong) UIView *backContentView;// logo 输入框的背景view
@property (nonatomic, strong) UIButton *settingupBtn;
@property (nonatomic, strong) TKPassWordHelpView * passWordHelpView;
@property (nonatomic, strong) TKChoseRoleView * choseView;

@property (nonatomic, strong) UIButton *parenButton;
@property (nonatomic, strong) UIButton *parenButton1;

@property (nonatomic, assign) BOOL isJoiningRoom;

@end

@implementation TKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
    [self initLayout];
    //设置默认显示的内容
    [self setupData];
    
    [self addNotifi];
#if DEBUG
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckVersionFinish"  object:nil];
#else
    // 版本更新
//    [[TKAPPSetConfig shareInstance] checkForUpdate];
#endif
    
//    [self testLayout];
    
}


- (void)initSubViews{
    // 初始化背景图
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSString * imgStr = IS_IPHONE ? @"tk_login_bg_iphone" : @"tk_login_bg";
    self.backgroundImageView.image = [UIImage imageNamed:imgStr];
    self.backgroundImageView.contentMode =  UIViewContentModeScaleAspectFill;
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    
    [self.view addSubview:self.backContentView];
    // 初始化控件
    [self.backContentView addSubview:self.titleLabel];
    [self.backContentView addSubview:self.subTitleLabel];
    [self.backContentView addSubview:self.roomidView];
    [self.backContentView addSubview:self.passWordView];
    [self.backContentView addSubview:self.nicknameView];
    [self.backContentView addSubview:self.roleView];
    [self.backContentView addSubview:self.loginButton];
    [self.backContentView addSubview:self.playbackButton];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.settingupBtn];
}
- (void)initLayout{
    NSInteger inputWidth = fminf(360, CGRectGetWidth(self.view.frame) - 60);
    [self.backgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    [self.backContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roomidView);
        make.top.equalTo(self.backContentView);
    }];
    
    [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.roomidView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, inputHeigt));
    }];
    
    [self.nicknameView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.roomidView.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, inputHeigt));
    }];
    
    [self.roleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.nicknameView.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, inputHeigt));
    }];
    
    [self.passWordView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.roleView.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, inputHeigt));
    }];
    
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.passWordView.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, loginButtonHeight));
    }];
    
    [self.playbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.loginButton.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(CGSizeMake(inputWidth, loginButtonHeight));
        make.bottom.equalTo(self.backContentView);
    }];
    
    [self.versionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    [self.settingupBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(IS_PAD ? - 32 : - 10);
        make.top.equalTo(self.view).offset(44);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    self.contentView.frame = self.view.frame;
    NSString *isShowAgreement = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShowServiceAgreementAndprivacyPolicy"];
    if ([isShowAgreement isEqualToString:@"0"] || !isShowAgreement) {
        [self.view addSubview:self.SPAlterView];
        [self.SPAlterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}


#pragma mark -Notifi
- (void)addNotifi{
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    // 版本检测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelNotifi:) name:@"CheckVersionFinish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelNotifi:) name:@"kTLoginPrivacypolicyNotifi" object:nil];
}

- (void)handelNotifi:(NSNotification *)notifi{
    NSString * name = notifi.name;
    if([name isEqualToString:@"CheckVersionFinish"]){
        
    }
    
    if([name isEqualToString:@"kTLoginPrivacypolicyNotifi"]){
        
    }
}

#pragma mark - 监听键盘
- (void)KeyboardWillShowNotification:(NSNotification *)noti {
    CGRect keyboardFrame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    double duration = ([[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]);
    void (^aBlock)(void) = ^void() {
        self.backContentView.transform = CGAffineTransformMakeTranslation(0, - (keyboardHeight/2 - 60));
    };
    [UIView animateWithDuration:duration delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone) animations:aBlock completion:nil];
}
- (void)KeyboardWillHideNotification:(NSNotification *)noti {
    double duration = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    void (^aBlock)(void) = ^void() {
        self.backContentView.transform = CGAffineTransformIdentity;
    };
    [UIView animateWithDuration:duration delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone) animations:aBlock completion:nil];
}

#pragma mark - Clicked
- (void)settingupButtonAciton:(UIButton *)sender {
    [self.settingView show:self.view];
    [self.view endEditing:YES];
}

- (void)setupData
{
    NSString *meetignID =[[NSUserDefaults standardUserDefaults] objectForKey:@"meetingID"];
    if (meetignID != nil && [meetignID isKindOfClass:[NSString class]])
    {
        NSString *newID = [self jointWithString:meetignID];
        _roomidView.inputView.text = newID;
    }
    NSString *nickName =[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    if (nickName != nil && [nickName isKindOfClass:[NSString class]])
    {
        _nicknameView.inputView.text = nickName;
    }
    NSNumber  *role = [[NSUserDefaults standardUserDefaults] objectForKey:@"userrole"];
    //0-老师 ,1-助教，2-学生 4-寻课A
    if (role != nil && [role isKindOfClass:[NSNumber class]] && [role intValue] < self.roleTitles.count)
    {
        _role = [role intValue];
        _roleView.text = self.roleTitles[_role];
    }else{
        _role = 2;
        _roleView.text = NSLocalizedString(@"Role.Student", nil);
    }
}

#pragma mark - 自定义代理
- (void)clickChoiceRole {
    [self.view endEditing:YES];
    self.choseView = [[TKChoseRoleView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.choseView];
    self.choseView.currentRole = self.role;
    tk_weakify(self);
    self.choseView.choseRoleBtnBlock = ^(UIButton * _Nonnull btn) {
        weakSelf.role = btn.tag - 10000;
        weakSelf.roleView.text = btn.titleLabel.text;
        [[NSUserDefaults standardUserDefaults] setObject_TKSafe:@(weakSelf.role) forKey:@"userrole"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    };

}

- (void)showHelpView{
    CGRect tagetFrame = [self.passWordView convertRect:self.passWordView.iconImageView.frame toView:self.view];
    [TKPassWordHelpView showPassWordHelpViewWithtagetFrame:tagetFrame superView:self.view];
}


- (void)loginValueChange:(UIButton *)info {
    [UIView animateWithDuration:.2 animations:^{
        info.transform = CGAffineTransformMakeScale(.8, .8);
    }];
}

- (void)loginButtonRecovery:(UIButton *)info {
    [UIView animateWithDuration:.2 animations:^{
        info.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
// MARK: - 进入教室登录
- (void)loginButtonAction:(UIButton *)sender{
    //成功进入教室 本地做记录 去掉空格
    NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tRoomIDString.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject_TKSafe:tRoomIDString forKey:@"meetingID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [UIView animateWithDuration:.2 animations:^{
        sender.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [self.view endEditing:YES];
        NSString *content;
        /**信息检查*/
        if (!self.nicknameView.inputView.text.length|| [TKUntilTool isEmpty:self.nicknameView.inputView.text]){
            //昵称不能为空
            content =  NSLocalizedString(@"Prompt.nicknameNotNull", nil);
        }
        
        if (!self.roomidView.inputView.text.length || [TKUntilTool isEmpty:self.roomidView.inputView.text]) {
            //教室号不能为空
            content =  NSLocalizedString(@"Prompt.RoomIDNotNull", nil);
        }
        
        //弹提示
        if(content.length){
            TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:content confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
            [alert show];
            return;
        }
        
        /**登陆教室*/
        if ([TKUntilTool isDomain:sHost] == YES) {
            NSArray *array = [sHost componentsSeparatedByString:@"."];
            self.defaultServer = [NSString stringWithFormat:@"%@", array[0]];
        } else {
            self.defaultServer = @"global";
        }
        
        NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableDictionary *parameters = @{
            @"serial"    :tRoomIDString,
            @"host"      :sHost,
            @"port"      :sPort,
            @"nickname"  :self.nicknameView.inputView.text,
            @"userrole"  :@(self.role),
            @"server"    :self.defaultServer,
            @"clientType":@(3),
            sBundleid : @"com.talkcloud.eduPLUS.TKScreenRecorder",
            sAppGroupid: @"group.TalkCloudPlusScreenRecord",
//            @"userid":self.nicknameView.inputView.text
        }.mutableCopy;
        //密码
        if(self.passWordView.inputView.text){
            [parameters setValue:self.passWordView.inputView.text forKey:@"password"];
        }


#if DEBUG
        
#ifdef SERVER_ClassID
        [parameters setValue:SERVER_ClassID forKey:@"serial"];
#endif
        
#ifdef Class_NickName
        [parameters setValue:Class_NickName forKey:@"nickname"];
#endif
        
#ifdef SERVER_ClassPwd
        
        [parameters setValue:SERVER_ClassPwd forKey:@"password"];
#endif
        
#endif
       
        [self checkRoomTypeRomInfoWithParam:parameters];
    }];
}
// MARK: - 查看回放
-(void)playbackButtonAction:(UIButton *)sender {
    NSString *content;
    /**信息检查*/
 
    if (!self.roomidView.inputView.text.length || [TKUntilTool isEmpty:self.roomidView.inputView.text]) {
        //教室号不能为空
        content =  NSLocalizedString(@"Prompt.RoomIDNotNull", nil);
    }
    
    //弹提示
    if(content.length){
        TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:content confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
        [alert show];
        return;
    }
    
    NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *param = @{
        @"serial"    :tRoomIDString,
        @"userName"  :self.nicknameView.inputView.text,
        @"userType"  :@(self.role),
        @"userPwd"   :self.passWordView.inputView.text,
    };
    
    [self.playbackView checkRoomPlaybackWithParam:param callBack:^(NSDictionary * _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            
            NSNumber *result = responseObject[@"result"];
            NSString *msg = responseObject[@"msg"];
            if(result.intValue == 0){
                //成功
                if([responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
                    NSArray *list = responseObject[@"data"][@"list"];
                    if(list.count > 0){
                        [self.playbackView show:self.view withData:list];
                    }else{
                        TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:NSLocalizedString(@"Playback.noPlayback", nil) confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
                        [alert show];
                    }
                }
            }else{
                msg = [self getAlertMsgWithCode:result.intValue];
                TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:msg confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
                [alert show];
            }
        }
    }];
}


#pragma mark - 拼接成中间有空格的字符串
- (NSString *)jointWithString:(NSString *)str {
    NSString *doneTitle = @"";
    int count = 0;
    for (int i = 0; i < str.length; i++) {
        count++;
        doneTitle = [doneTitle stringByAppendingString:[str substringWithRange:NSMakeRange(i, 1)]];
        if (count == 4) {
            doneTitle = [NSString stringWithFormat:@"%@ ", doneTitle];//这个位置%@后面需要加一个空格哦
            count = 0;
        }
    }
    return doneTitle;
}

#pragma mark - Net
- (void)checkRoomTypeRomInfoWithParam:(NSDictionary *)roomParam{
    NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger  ts = [TKUntilTool getNowTimeTimestamp] * 1000;
    NSMutableDictionary *parameters = @{
        @"serial"    :tRoomIDString,
        @"userName"  :[TKUntilTool URLEncodedString:self.nicknameView.inputView.text],
        @"userType"  :@(self.role),
        @"userPwd"    :self.passWordView.inputView.text,
        @"nickName" :self.nicknameView.inputView.text,
        @"ts"  :@(ts),
    }.mutableCopy;
    
    tk_weakify(self);
    NSString * urlString = [NSString stringWithFormat:@"%@://%@:%@/client/ui/v1/getEnterRoomUrl", sHttp,sHost, sPort];
    [[TKNetTool shareInstance] POST:urlString parameters:parameters successCallBack:^(NSDictionary * _Nonnull responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            [weakSelf checkRoomSuccessInfoWithResponseObject:responseObject roomParam:roomParam];
        }
        
    } progressCallBack:^(NSProgress * _Nonnull progressObject) {
        
    } failureCallBack:^(NSError * _Nonnull error) {
        TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:NSLocalizedString(@"Error.WaitingForNetwork", nil) confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
        [alert show];
    }];
}


- (void)checkRoomSuccessInfoWithResponseObject:(NSDictionary *)responseObject roomParam:(NSDictionary *)roomParam{
    if (self.isJoiningRoom) {
        return; // 已经在进房间，直接忽略
     }
    int result = [[responseObject objectForKey:@"result"] intValue];
    if(result == 0){
        self.isJoiningRoom = YES; // 设置标记，防止重复
        NSDictionary * data = [[NSMutableDictionary alloc]initWithDictionary:[responseObject objectForKey:@"data"]];
        if([[data objectForKey:@"roomType"] intValue] == 8){//云直播
//            [[TLEduClassManager shareInstance] joinRoomWithParamDic:roomParam ViewController:self Delegate:self isFromWeb:NO];
        }else{
            [[TKEduClassManager shareInstance] joinRoomWithParamDic:roomParam ViewController:self Delegate:self isFromWeb:NO];
        }
    }else{
        NSString * contentStr = [self getAlertMsgWithCode:result];
        
        TKLoginAlert *alert = [[TKLoginAlert alloc] initWithTitle:NSLocalizedString(@"Prompt.prompt",nil) contentText:contentStr confirmTitle:NSLocalizedString(@"Prompt.Know",nil)];
        [alert show];
    }
}

-(NSString *)getAlertMsgWithCode:(int)code{
    if(code == 7002){//不支持角色
        return NSLocalizedString(@"ClassRoom.nonsupport", nil);
    }else if(code == 4002){//密码错误
        return NSLocalizedString(@"ClassRoom.incorrectPassword", nil);
    }else if(code == 1002){//缺少密码
        return NSLocalizedString(@"ClassRoom.noPassword", nil);
    }else if(code == 4007){//房间过期
        return NSLocalizedString(@"Error.RoomDeletedOrExpired", nil);
    }else if(code == 3001){//时间错误
        return  NSLocalizedString(@"Error.TimeError", nil);
    }else if(code == 4109){//签名错误
        return NSLocalizedString(@"Error.SignError", nil);
        
    }else{
        return NSLocalizedString(@"Error.WaitingForNetwork", nil);
    }
}

#pragma mark 横竖屏
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (IS_IPHONE) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    UIInterfaceOrientation interfaceOriention = [UIApplication sharedApplication].statusBarOrientation;
    if (IS_IPHONE) {
        return UIInterfaceOrientationPortrait;
    }
    if (interfaceOriention == UIInterfaceOrientationLandscapeLeft) {
        return UIInterfaceOrientationLandscapeLeft;
    }else {
        return UIInterfaceOrientationLandscapeRight;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Get
- (TKSPContentView *)contentView {
    if (!_contentView) {
        _contentView = [[TKSPContentView alloc] initWithFrame:self.view.frame];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
}

- (TKServiceAndPrivacyAlterView *)SPAlterView {
    if (!_SPAlterView) {
        _SPAlterView = [[TKServiceAndPrivacyAlterView alloc] initWithFrame:self.view.frame];
    }
    return _SPAlterView;
}

- (TKLoginSettingView *)settingView {
    if (!_settingView) {
        _settingView = [[TKLoginSettingView alloc] initWithFrame:self.view.frame];
    }
    return _settingView;
}

- (TKPlaybackView *)playbackView {
    if (!_playbackView) {
        _playbackView = [[TKPlaybackView alloc] initWithFrame:self.view.frame];
        tk_weakify(self);
        _playbackView.joinPlaybackRoomBlock = ^(NSDictionary * _Nonnull dic) {
            //  小班课看常规吧，大班课看mp4
            NSNumber *type = dic[@"type"];
            if(type && [type isKindOfClass:[NSNumber class]]){
                if(type.intValue == 5){
                    NSString *path = dic[@"mp4Url"];
                    if(path){
                        [[TKEduClassManager shareInstance] joinMp4PlayBackWithConfigDic:@{@"playUrl" :path} vc:weakSelf];
                    }
                }else{
                    NSDictionary *param = @{
                        // 房间号
                        @"serial" : dic[@"serial"] ?: @"",
                        // 回放标题
                        @"recordtitle": dic[@"recordtitle"] ?: @"",
                        // 昵称
                        @"nickname"  : weakSelf.nicknameView.inputView.text ?: @"",
                    };
                    
                    [[TKEduClassManager shareInstance] joinPlaybackRoomWithParamDic:param
                                                                     ViewController:weakSelf
                                                                           Delegate:weakSelf
                                                                          isFromWeb:NO];
                }
            }
        };
    }
    return _playbackView;
}

- (UIButton *)settingupBtn {
    if (!_settingupBtn) {
        _settingupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingupBtn setBackgroundImage:[UIImage imageNamed:@"tk_login_settingup"] forState:UIControlStateNormal];
        [_settingupBtn addTarget:self action:@selector(settingupButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingupBtn;
}

- (UIView *)backContentView {
    if (!_backContentView) {
        _backContentView = [[UIView alloc] init];
        _backContentView.backgroundColor = [UIColor clearColor];
    }
    return _backContentView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(362, 165, 210, 42);
        label.text =  NSLocalizedString(@"TKProjectName", nil);
        label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:30];
        label.alpha = 1;
        label.textAlignment = NSTextAlignmentLeft;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.alpha = 0.6;
        [self.view addSubview:label];
        label.numberOfLines = 0;
        label.text = NSLocalizedString(@"TKLog.SubTitle", nil);
        label.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:14];;
        label.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel = label;
    }
    return _subTitleLabel;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginButton.backgroundColor = [UIColor colorWithHexColorString:@"#3997F8"];
        _loginButton.layer.cornerRadius = loginButtonHeight / 2;
        [_loginButton setTitle:NSLocalizedString(@"Login.EnterRoom", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor colorWithHexColorString:@"ffffff"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginValueChange:) forControlEvents:UIControlEventTouchDown];
        [_loginButton addTarget:self action:@selector(loginButtonRecovery:) forControlEvents:UIControlEventTouchUpOutside];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_loginButton setEnabled:YES];
    }
    return _loginButton;
}

- (UIButton *)playbackButton
{
    if (!_playbackButton) {
        _playbackButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _playbackButton.backgroundColor = [UIColor colorWithHexColorString:@"#E4F2FF"];
        _playbackButton.layer.cornerRadius = loginButtonHeight / 2;
        [_playbackButton setTitle:NSLocalizedString(@"Login.EnterPlayback", nil) forState:UIControlStateNormal];
        [_playbackButton setTitleColor:[UIColor colorWithHexColorString:@"3997F8"] forState:UIControlStateNormal];
        [_playbackButton addTarget:self action:@selector(playbackButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _playbackButton;
}

- (TKLoginInputView *)roomidView
{
    if (!_roomidView) {
        _roomidView = [[TKLoginInputView alloc] initWithFrame:CGRectZero showText:nil placeholderText:NSLocalizedString(@"Label.roomPlaceholder", nil) setImageName:@"tk_login_clear_icon" inputViewType:TKInputViewRoomID];
        _roomidView.inputDelegate = self;
        _roomidView.inputView.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _roomidView;
}

- (TKLoginInputView *)passWordView
{
    if (!_passWordView) {
        _passWordView = [[TKLoginInputView alloc] initWithFrame:CGRectZero showText:nil placeholderText:NSLocalizedString(@"Label.inputPwdPlaceholder", nil) setImageName:@"tk_login_clear_icon" inputViewType:TKInputViewPassWord];
        _passWordView.inputDelegate = self;
    }
    return _passWordView;
}


- (TKLoginInputView *)nicknameView
{
    if (!_nicknameView) {
        _nicknameView = [[TKLoginInputView alloc] initWithFrame:CGRectZero showText:nil placeholderText:NSLocalizedString(@"Login.nickName", nil) setImageName:@"tk_login_clear_icon" inputViewType:TKInputViewUserNickName];
        _nicknameView.inputDelegate = self;
    }
    return _nicknameView;
}

- (TKLoginInputView *)roleView
{
    if (!_roleView) {
        _roleView = [[TKLoginInputView alloc] initWithFrame:CGRectZero showText:@"" placeholderText:NSLocalizedString(@"Label.choiceIdentity", nil) setImageName:@"tk_login_right_icon" inputViewType:TKInputViewUserRole];
        _roleView.inputDelegate = self;
    }
    return _roleView;
}

- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = [UIColor colorWithHexColorString:@"CBCBCB"];
        _versionLabel.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"sys-clientVersion"];
        _versionLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    }
    return _versionLabel;
}

- (NSArray *)roleTitles {
    //0-老师 ,1-助教，2-学生, 3-"", 4-寻课 6-旁听生
    NSArray *array = @[NSLocalizedString(@"Role.Teacher", nil),
                       NSLocalizedString(@"Role.Assistant", nil),
                       NSLocalizedString(@"Role.Student", nil),
                       @"",
                       NSLocalizedString(@"Role.Patrol", nil),
                       @"",
                       NSLocalizedString(@"Role.Auditor", nil)
    ];
    
    return  array;
}

#pragma mark - 测试
//////需要删掉正常登录时的userid = 名称
- (void)testLayout{
    [self.view addSubview:self.parenButton];
    [self.parenButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.loginButton.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(self.loginButton);
    }];
    
    [self.view addSubview:self.parenButton1];
    [self.parenButton1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backContentView);
        make.top.equalTo(self.parenButton.mas_bottom).offset(inputMarginTop);
        make.size.mas_equalTo(self.loginButton);
    }];
}


- (UIButton *)parenButton
{
    if (!_parenButton) {
        _parenButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _parenButton.backgroundColor = [UIColor colorWithHexColorString:@"#3997F8"];
        _parenButton.layer.cornerRadius = loginButtonHeight / 2;
        [_parenButton setTitle:@"家长" forState:UIControlStateNormal];
        [_parenButton setTitleColor:[UIColor colorWithHexColorString:@"ffffff"] forState:UIControlStateNormal];
        [_parenButton addTarget:self action:@selector(parenButtonRecovery) forControlEvents:UIControlEventTouchUpInside];
        [_parenButton setEnabled:YES];
    }
    return _parenButton;
}

- (void)parenButtonRecovery{
    NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableDictionary *parameters = @{
        @"serial"    :tRoomIDString,
        @"host"      :sHost,
        @"port"      :sPort,
        @"nickname"  :self.nicknameView.inputView.text,
        @"userrole"  :@(27),
        @"server"    :self.defaultServer,
        @"clientType":@(3),
        @"role":@(27),
        sBundleid : @"com.talkcloud.eduPLUS.TKScreenRecorder",
        sAppGroupid: @"group.TalkCloudPlusScreenRecord",
        @"userids":@[@"abc111",@"abc222",@"abc1",@"abc2",@"abc3",@"abc4",@"abc5",@"abc6",@"abc7",@"abc8",@"abc9",@"abc10",@"abc11",@"abc12"]
    }.mutableCopy;
    //密码
    if(self.passWordView.inputView.text){
        [parameters setValue:self.passWordView.inputView.text forKey:@"password"];
    }
    
    [[TKEduClassManager shareInstance] joinRoomWithParamDic:parameters ViewController:self Delegate:self isFromWeb:NO];
}


- (UIButton *)parenButton1
{
    if (!_parenButton1) {
        _parenButton1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _parenButton1.backgroundColor = [UIColor colorWithHexColorString:@"#3997F8"];
        _parenButton1.layer.cornerRadius = loginButtonHeight / 2;
        [_parenButton1 setTitle:@"家长不带ids" forState:UIControlStateNormal];
        [_parenButton1 setTitleColor:[UIColor colorWithHexColorString:@"ffffff"] forState:UIControlStateNormal];
        [_parenButton1 addTarget:self action:@selector(parenButton1Recovery) forControlEvents:UIControlEventTouchUpInside];
        [_parenButton1 setEnabled:YES];
    }
    return _parenButton1;
}

- (void)parenButton1Recovery{
    NSString *tRoomIDString = [self.roomidView.inputView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableDictionary *parameters = @{
        @"serial"    :tRoomIDString,
        @"host"      :sHost,
        @"port"      :sPort,
        @"nickname"  :self.nicknameView.inputView.text,
        @"userrole"  :@(27),
        @"server"    :self.defaultServer,
        @"clientType":@(3),
        @"logintype" : @(27),
        @"role":@(27),
//        @"userid" : self.nicknameView.inputView.text,
        sBundleid : @"com.talkcloud.eduPLUS.TKScreenRecorder",
        sAppGroupid: @"group.TalkCloudPlusScreenRecord",
    }.mutableCopy;
    //密码
    if(self.passWordView.inputView.text){
        [parameters setValue:self.passWordView.inputView.text forKey:@"password"];
    }
    
    [[TKEduClassManager shareInstance] joinRoomWithParamDic:parameters ViewController:self Delegate:self isFromWeb:NO];
}
/**
 进入房间失败
 
 @param result 错误码 详情看 TKRoomSDK -> TKRoomDefines ->TKRoomErrorCode 结构体
 
 @param desc 失败的原因描述
 */
- (void)onEnterRoomFailed:(int)result Description:(NSString*)desc{
    self.isJoiningRoom = NO; 
}
/**
 被踢回调

 @param reason 1:老师踢出 400:重复登录 401:课程已结束 402:课程已被取消
 */
- (void)onKitout:(int)reason{
    self.isJoiningRoom = NO;
}
/**
 摄像头打开失败回调
 */
- (void)onCameraDidOpenError
{
    self.isJoiningRoom = NO;
}
/**
 离开课堂成功后的回调
 */
- (void)leftRoomComplete{
    NSLog(@"房间操作 离开教室leftRoomComplete");
    self.isJoiningRoom = NO;
}

/**
 课堂页面消失的回调
 */
- (void)onClassRoomDisappear{
    self.isJoiningRoom = NO;
}

/**
 关闭设备检测
 */
- (void)closeCheckDevice{
    self.isJoiningRoom = NO;
}

@end
