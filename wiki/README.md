# TKUISDK_iOS Wiki

> 本 Wiki 仅描述项目文件目录结构、配置与发版流程。本仓库是 CocoaPods 发布载体，Framework 为预编译二进制产物，不涉及其内部功能说明。

## 项目定位

拓课云 TKUISDK 的 CocoaPods 发布仓库：将 6 个预编译 Framework 通过 `vendored_frameworks` 打包，发布到 CocoaPods trunk 供客户 `pod 'TKUISDK_iOS'` 集成。仓库不包含 SDK 源码。

## 顶层目录

```
TKUISDK_iOS/
├── TKUISDK_iOS/            # SDK 发布内容（podspec 引用的产物目录）
├── Example/                # 示例工程（本地开发验证用）
├── TKUISDK_iOS.podspec     # CocoaPods 描述文件（发版入口）
├── README.md               # 仓库说明与客户接入指引
├── LICENSE                 # MIT 许可证（podspec 引用）
├── WIKI.md                 # Wiki 入口
├── wiki/                   # Wiki 文档目录
├── .gitignore
└── .travis.yml             # Travis CI 配置
```

## 页面导航

| 页面 | 内容 |
| --- | --- |
| [01-SDK产物目录](01-SDK产物目录.md) | `TKUISDK_iOS/` 下 Frameworks、Bundles 等目录结构 |
| [02-示例工程目录](02-示例工程目录.md) | `Example/` 下 App、Extension、Tests 及资源目录结构 |
| [03-依赖与构建配置](03-依赖与构建配置.md) | podspec、Podfile、锁定文件与 CI 配置说明 |
| [04-发版流程](04-发版流程.md) | 提交 → lint → tag → trunk push 完整命令 |