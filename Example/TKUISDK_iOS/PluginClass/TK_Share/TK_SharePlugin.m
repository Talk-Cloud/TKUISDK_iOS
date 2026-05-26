//
//  TK_SharePlugin.m
//  TKUIDEMO
//
//  Created by talkcloud on 2020/11/9.
//  Copyright © 2020 李合意. All rights reserved.
//

#import "TK_SharePlugin.h"
#import <UShareUI/UShareUI.h>

@interface TK_SharePlugin ()

@end

@implementation TK_SharePlugin

- (void) showSharePlatformWithShareDict:(NSDictionary *)shareDict image:(UIImage *)image {

    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlText = @"取消分享";

    //显示分享面板
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
//                                               @(UMSocialPlatformType_WechatTimeLine),
//                                               @(UMSocialPlatformType_QQ),
//                                               @(UMSocialPlatformType_Qzone),
//                                               @(UMSocialPlatformType_Sina)
//                                               ]];
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine)
    ]];

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {

        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType shareDict:shareDict image:image];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType shareDict:(NSDictionary *)shareDict image:(UIImage *)image
{
    NSString * titleString = [shareDict objectForKey:@"share_title"] ?: @"";
    NSString * descrString = [shareDict objectForKey:@"share_description"] ?: @"";
    NSString * share_link  = [shareDict objectForKey:@"share_link"] ?: @"";
                
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:titleString descr:descrString thumImage:image];
    shareObject.webpageUrl = share_link;
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {

    }];
}

- (BOOL)isInstallPlatform {
    // 是否 有 支持 分享的 app
    BOOL isSu = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    return isSu;
}

@end
