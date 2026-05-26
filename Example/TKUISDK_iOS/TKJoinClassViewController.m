//
//  TKJoinClassViewController.m
//  TKUIDEMO
//
//  Created by talkcloud on 2021/8/19.
//  Copyright © 2021 李合意. All rights reserved.
//

#import "TKJoinClassViewController.h"
#import <TKUISDK/TKUISDK.h>
#import <TKRoomSDK/TKRoomSDK.h>

@interface TKJoinClassViewController ()<TKEduRoomDelegate>


@end

@implementation TKJoinClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    [[TKEduClassManager shareInstance] joinRoomWithParamDic:self.iparamater
                                             ViewController:self
                                                   Delegate:self
                                                  isFromWeb:NO];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:@"click back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) btnClick {
    
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

#pragma mark - TKEduRoomDelegate
/**
 进入房间失败
 
 @param result 错误码 详情看 TKRoomSDK -> TKRoomDefines ->TKRoomErrorCode 结构体
 
 @param desc 失败的原因描述
 */
- (void)onEnterRoomFailed:(int)result Description:(NSString*)desc
{
    if (result == 0 && [desc isEqualToString:@"取消"]) {
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    }
}

- (void)onClassRoomDisappear {
    
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
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
- (void)onClassBegin{
    
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

@end
