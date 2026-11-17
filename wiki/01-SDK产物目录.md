# 01 - SDK 产物目录（TKUISDK_iOS/）

本目录是 podspec 引用的 SDK 发布内容，发版时替换其中的二进制产物与资源，不涉及源码编译。

## 目录结构

```
TKUISDK_iOS/
├── Frameworks/             # 6 个预编译 Framework（vendored_frameworks 分发主体）
│   ├── TKUISDK.framework/
│   ├── TKRoomSDK.framework/
│   ├── TKMediaEngine.framework/
│   ├── TKWhiteBoard.framework/
│   ├── TKLivePlayer.framework/
│   └── TKExtension.framework/
├── Bundles/
│   └── TKResources.bundle/ # 共享静态资源包
├── Assets/                 # 占位目录（仅 .gitkeep，当前未使用）
└── Classes/                # 占位目录（仅 .gitkeep，源码不随仓库分发）
```

## Frameworks/

- podspec 中 `s.ios.vendored_frameworks = 'TKUISDK_iOS/Frameworks/*.framework'` 指向此目录，6 个 Framework 全部随 pod 分发。
- 每个 `.framework` 为已签名的预编译产物（含二进制、Headers、Modules、Info.plist 等标准结构），内部功能不在本 Wiki 范围内。
- 发版操作：用新构建的 Framework 整体替换对应目录即可。

## Bundles/TKResources.bundle/

跨框架共享的静态资源包，按类型组织：

```
TKResources.bundle/
├── image/                  # 图片资源，按业务界面/工具模块分目录（共 32 类）
│   ├── TKAlert/ TKAliveClass/ TKBeautyIcon/ TKChatView/ TKControl/
│   ├── TKDeviceCheck/ TKEmoji/ TKFileList/ TKGuid/ TKLayout/
│   ├── TKMP4MP3/ TKNavgationView/ TKRoombase/ TKSkin/ TKSmallVideo/
│   ├── TKToolbox_DialView/ TKToolbox_DiskView/ TKToolbox_Grouping/
│   ├── TKToolbox_answer/ TKToolbox_item/ TKToolbox_responder/
│   ├── TKToolbox_smallWB/ TKToolbox_timer/ TKUserlist/
│   ├── TKVideoControll/ TKWBBrushTools/ TKWBPageControll/ TKWhiteBoard/
│   └── TKlogin/ TKmicrophoneVolume/ TKmp3player/ TKmp4loading/
├── dist/                   # 前端构建产物
├── react_mobile_new_publishdir/  # React 移动端发布产物
├── en.lproj/               # 英文字符串
├── zh-Hans.lproj/          # 简体中文字符串
├── zh-Hant-TW.lproj/       # 繁体中文字符串
├── removeTrophy.gif / removeTrophy.mp3     # 奖杯移除动效与音效
├── tk_book_loading.gif / tk_cupGif.gif     # 加载与奖杯动效
├── timer_default.wav / zb_timer_default.mp3 / trophy_tones.wav  # 计时器与奖杯音效
```

## 资源分发约定

- 资源已内嵌在各 Framework 的 bundle 中，podspec 未声明 `s.resources` / `s.resource_bundles`。
- `Assets/`、`Classes/` 为 pod 模板遗留的占位目录，当前无实际内容。