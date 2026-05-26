//
//  ViewController.m
//  TKUIDEMO
//
//  Created by talkcloud on 2019/10/14.
//  Copyright © 2019 talkcloud. All rights reserved.
//

#import "ViewController.h"
#import <TKUISDK/TKUISDK.h>
#import <TKRoomSDK/TKRoomSDK.h>
#import "TKJoinClassViewController.h"


@interface ViewController ()<TKEduRoomDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIButton *firstButton;
@property (strong, nonatomic) UIButton *secondButton;
@property (strong, nonatomic) UIButton *thirdButton;
@property (strong, nonatomic) UIButton *fourthButton;
@property (strong, nonatomic) UIButton *fifthButton;
@property (strong, nonatomic) UIButton *sixthButton;
@property (strong, nonatomic) UIButton *seventhButton;
@property (strong, nonatomic) UIButton *eighthButton;
@property (strong, nonatomic) UIButton *ninthButton;
@property (nonatomic, strong) NSNumber *pagenum;

@property (nonatomic, strong) UIWindow * secWindow;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstButton = [self buttonWithFrame:CGRectMake(75, 50, 300, 30)];
    [self.firstButton setTitle:@"通过参数进教室" forState:UIControlStateNormal];
    [self.firstButton addTarget:self action:@selector(firstBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.secondButton = [self buttonWithFrame:CGRectMake(75, 50 + 70, 300, 30)];
    [self.secondButton setTitle:@"通过参数播放常规回放" forState:UIControlStateNormal];
    [self.secondButton addTarget:self action:@selector(secondBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.thirdButton = [self buttonWithFrame:CGRectMake(75, 50 + 140, 300, 30)];
    [self.thirdButton setTitle:@"通过链接进教室" forState:UIControlStateNormal];
    [self.thirdButton addTarget:self action:@selector(thirdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.fourthButton = [self buttonWithFrame:CGRectMake(75, 50 + 210, 300, 30)];
    [self.fourthButton setTitle:@"通过链接播放mp4回放" forState:UIControlStateNormal];
    [self.fourthButton addTarget:self action:@selector(fourthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.fifthButton = [self buttonWithFrame:CGRectMake(75, 50 + 280, 300, 30)];
    [self.fifthButton setTitle:@"mp4回放视频续播" forState:UIControlStateNormal];
    [self.fifthButton addTarget:self action:@selector(fifthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.sixthButton = [self buttonWithFrame:CGRectMake(75, 50 + 350, 300, 30)];
    [self.sixthButton setTitle:@"double window" forState:UIControlStateNormal];
    [self.sixthButton addTarget:self action:@selector(sixthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.seventhButton = [self buttonWithFrame:CGRectMake(75, 50 + 420, 300, 30)];
    [self.seventhButton setTitle:@"展示设备检测页面" forState:UIControlStateNormal];
    [self.seventhButton addTarget:self action:@selector(seventhBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.eighthButton = [self buttonWithFrame:CGRectMake(75, 50 + 490, 300, 30)];
    [self.eighthButton setTitle:@"" forState:UIControlStateNormal];
    [self.eighthButton addTarget:self action:@selector(eighthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.ninthButton = [self buttonWithFrame:CGRectMake(75, 50 + 560, 300, 30)];
    [self.ninthButton setTitle:@"TEST" forState:UIControlStateNormal];
    [self.ninthButton addTarget:self action:@selector(ninthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void) firstBtnClick {
    
        NSDictionary *param = @ {
            // 房间号
            @"serial":@"297804499",
            // 用户角色 老师(0) 助教(1) 学生(2)
            @"userrole": @(27),
            // 用户昵称
            @"nickname": @"BBQ",
            // 密码（没有可不填）
            @"password": @(1),
            /*
             用户ID,可选字段(不可传空字符),如果不传，SDK 会自动生成用户唯一ID
             注意:教室内唯一ID , 多个相同ID 会互踢.
             */
            @"userid" : @"abc123",
            @"logintype" : @(27),
            @"ids" :@[@"abc111",@"abc222"]
            
        };

        [[TKEduClassManager shareInstance] joinRoomWithParamDic:param
                                                 ViewController:self
                                                       Delegate:self
                                                      isFromWeb:NO];
}

- (void) secondBtnClick {
    
    // 常规回放 path参数参考 集成文档-常见问题
        NSDictionary *param = @{
            // 房间号
            @"serial" : @"722976513",
            // 回放标题
            @"recordtitle":@"1757324598138",
//            @"userids":@[@"abc111",@"c0e3bb57-ade0-92a1-2769-23c04862d622"]
        };

        [[TKEduClassManager shareInstance] joinPlaybackRoomWithParamDic:param
                                                         ViewController:self
                                                               Delegate:self
                                                              isFromWeb:NO];
}

- (void) thirdBtnClick {
    // app外部跳转打开app进入教室 使用的是该方法，协议头需要先行约定
    // （根据后台配置的参数可进入教室和播放常规回放） https://doccdncf.talk-cloud.net/static/h5_new_4.7.0.33/index.html#/replay?timestamp=1655886503160&reset=true
    NSString *url = @"enterroomnew://replay?host=global.talk-cloud.net&domain=jszhou&serial=1608234827&type=3&roomtype=3&path=hw-record.talk-cloud.net/b3b5bb54-9c16-47b6-8e5c-6f32838914f3-1608234827/&layout=1&colourid=purple&tplId=default&skinId=default&skinResource=&recordtitle=1741768258678&companyidentify=1&logourl=https://h5-static.talk-cloud.net/logo/117912_1ae4fe3b15a7a47dbe3513246b93a6cd.jpg&userids=abc111";
    [[TKEduClassManager shareInstance] joinRoomWithUrl:url];
}

- (void) fourthBtnClick {
    
//    [[TKEduClassManager shareInstance] playVideo:self path:@"https://recordcdn.talk-cloud.net/3426dae1-5bc4-4de7-9a7e-4e03a16b18c0-82218266/record.mp4"];
}

- (void) fifthBtnClick {
    //
//    [[TKEduClassManager shareInstance] joinRoomWithPlaybackPath:@"https://recordcdn.talk-cloud.net/9d20b5de-01cf-43ff-8069-36cf6da8433f-778899992/record.mp4" ViewController:self skipTime:@"" breakurl:@""];
    
    NSDictionary * donfigDic = @{
        @"playUrl" : @"https://recorddemo.talk-cloud.net/fe53e718-b29a-4b79-884a-74569fb0474c-2125097632/record.mp4?filename=x'04.09-00",
        @"serial" : @"2125097632",
        @"userId":@"50580288",
        @"recordTitle":@"1776925900297",
        
    };
    [[TKEduClassManager shareInstance] joinMp4PlayBackWithConfigDic:donfigDic vc:self];
}

- (void) sixthBtnClick {
    
    NSDictionary *param = @ {
        // 房间号
        @"serial":@"1395818318",
        // 用户角色 老师(0) 助教(1) 学生(2)
        @"userrole": @(2),
        // 用户昵称
        @"nickname": @"BBQ",
        // 密码（没有可不填）
        @"password": @(1),
        /*
         用户ID,可选字段(不可传空字符),如果不传，SDK 会自动生成用户唯一ID
         注意:教室内唯一ID , 多个相同ID 会互踢.
         */
        @"userid" : @"abc123",
    };
    
    if (self.secWindow == nil) {
        UIWindow * window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor whiteColor];
        self.secWindow = window;
    }
    [self.secWindow makeKeyAndVisible];
    
    TKJoinClassViewController * class = [[TKJoinClassViewController alloc] init];
    class.iparamater = param;
    self.secWindow.rootViewController = class;
}

/// 通过参数播放mp4回放饿
- (void) seventhBtnClick {
    
//    NSDictionary *param = @ {
//        // 房间号
//        @"serial":@"68254459"
//    };
    
//    [[TKEduClassManager shareInstance] enterMP4PlayBackViewWithController:self param:param];
    [[TKEduClassManager shareInstance] showDeviceStatusCheckDomain:@"" userid:@"" callBack:nil];
    
}

- (void) eighthBtnClick {
    
}

- (void) ninthBtnClick {
//    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    NSArray * arr1 = @[@"0",@"1",@"2"];
    NSMutableArray * arr = @[@1,@2];
    NSString * str = [arr objectAtIndex:1];
    NSInteger *  len = str.length;
//    NSString * str1;
//    NSDictionary * dic = @{@"str":str1};
//    NSMutableDictionary * dicm = [[NSMutableDictionary alloc]init];
//    [dicm setObject_TKSafe:@"1" forKey:str1];
//    NSLog(@"数组越界:%@",str1);
//    [arr replaceObjectAtIndex:3 withObject:@(2)];
//    [arr replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:arr1];
//    if ( [self.pagenum intValue] == 0) {
//        NSLog(@"数组越界:%@");
//    }
    int d =  (arc4random() % 6) + 2;
    NSLog(@"测试 %d",d);
   
}

- (void) tenthClick{
//    [TKRoomManager instance]  使用封装到sessionHandle中
    
}

#pragma mark - TKEduRoomDelegate
/**
 进入房间失败
 
 @param result 错误码 详情看 TKRoomSDK -> TKRoomDefines ->TKRoomErrorCode 结构体
 
 @param desc 失败的原因描述
 */
- (void)onEnterRoomFailed:(int)result Description:(NSString*)desc
{
    
}

/**
 被踢回调

 @param reason 1:被老师踢出 400：重复登录
 */
- (void)onKitout:(int)reason
{
    
}

/**
 进入课堂成功后的回调
 */
- (void)joinRoomComplete
{
    
}

/**
 离开课堂成功后的回调
 */
- (void)leftRoomComplete
{
    
}

/**
 课堂开始的回调
 */
- (void)onClassBegin
{
    
}

/**
 课堂结束的回调
 */
- (void)onClassDismiss
{
    
}

/**
 摄像头打开失败回调
 */
- (void)onCameraDidOpenError
{
    
}

- (UIButton *) buttonWithFrame:(CGRect)frame {
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:btn];
    return btn;
}

- (void) showErrorMsg:(NSString *)msg {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
