//
//  TKDemoEnumHeader.h
//  TKUIDEMO
//
//  Created by zjt on 2024/12/17.
//  Copyright © 2024 李合意. All rights reserved.
//

#ifndef TKDemoEnumHeader_h
#define TKDemoEnumHeader_h

#define TK_DEMOBUNDLE_NAME @"TKDemoResources.bundle"
#define TKDEMOIMAGEBUNDLE [NSString stringWithFormat:@"%@/image/", TK_DEMOBUNDLE_NAME]


#define TKDEMO_IMG_TKlogin(name)         [NSString stringWithFormat:@"%@TKlogin/%@", TKDEMOIMAGEBUNDLE, name]


// 输入框类型
typedef NS_ENUM(NSInteger, TKInputViewType) {
    TKInputViewRoomID = 0,// 房间号
    TKInputViewPassWord = 1, //密码
    TKInputViewUserNickName = 2, //昵称
    TKInputViewUserRole = 3, //用户角色
};

#endif /* TKDemoEnumHeader_h */
