---
kind: logging_system
name: 日志系统：无自研日志框架，依赖 CocoaPods 第三方库的原生 NSLog 输出
slug: logging_system
category: logging_system
scope:
    - '**'
---

## 1. 使用的系统/方案

仓库本身（`TKUISDK_iOS/Classes/` 目录为空）以及对外发布的预编译 Framework（`TKExtension.framework`、`TKRoomSDK.framework`、`TKLivePlayer.framework`、`TKMediaEngine.framework`、`TKWhiteBoard.framework`、`TKUISDK.framework`）**没有引入任何自研的日志框架**，也没有统一的日志门面、结构化字段定义或日志级别策略。示例应用 `Example/TKUISDK_iOS/` 中仅通过 `NSLog` 直接输出调试信息。

所有可观察到的日志行为均来自 CocoaPods 依赖的第三方库：
- `lottie-ios`：使用 `ENABLE_DEBUG_LOGGING` 宏开关包裹的 `NSLog`，用于动画渲染调试。
- `SDWebImage`：在 `SDInternalMacros.m` 中使用 `os_log_create("com.hackemist.SDWebImage", "Default")` 创建 `os_log_t`，并通过 `os_log` 输出。
- `Bugly`：提供 `BLYLogError/Warn/Info/Debug/Verbose` 宏，封装 `BuglyLog level:tag:log:`。
- `MicrosoftCognitiveServicesSpeech-iOS`：通过 C 头文件 `azac_debug.h` / `spxerror.h` 中的 `AZAC_LOG_ON_FAIL`、`printf(stderr, ...)` 等宏输出诊断信息。
- `Example/TKScreenRecorder/SampleHandler.m`：直接使用 `NSLog` 打印屏幕录制扩展生命周期回调。

## 2. 关键文件与包

- `Example/Pods/lottie-ios/lottie-ios/Classes/.../*.m`：`ENABLE_DEBUG_LOGGING` 控制的 `NSLog` 调用点。
- `Example/Pods/SDWebImage/SDWebImage/Private/SDInternalMacros.m`：`os_log_create` 初始化 `os_log_t sd_getDefaultLog()`。
- `Example/Pods/Bugly/Bugly.framework/Headers/BuglyLog.h`：`BUGLY_LOG_MACRO` 及 `BLYLog*` 系列宏。
- `Example/Pods/MicrosoftCognitiveServicesSpeech-iOS/.../azac_debug.h`：`__AZAC_LOG_HR_IMPL`、`AZAC_LOG_ON_FAIL` 等诊断宏。
- `Example/TKScreenRecorder/SampleHandler.m`：示例扩展中的 `NSLog` 调用。

## 3. 架构与约定

- **无集中式日志子系统**：仓库没有 `log/`、`logging/` 或类似目录；`TKUISDK_iOS/Classes/` 为空占位目录。
- **每个第三方库各自管理自己的日志**：SDK 使用者无法通过统一 API 控制日志级别或路由。
- **示例工程采用最简方式**：仅在 `SampleHandler.m` 中用 `NSLog` 打印屏幕共享扩展的生命周期事件，未封装日志工具类。
- **未捕获异常**：`TKExtension.framework` 暴露了 `TKUncaughtExceptionHandler.h`，但未见对应的 `.m` 实现（仅头文件），因此不能确认是否启用了全局崩溃日志收集。

## 4. 约定与约束

- **描述性约定**：示例代码和第三方库的日志输出均为人类可读的字符串，没有统一的 JSON/结构化字段规范。
- **无强制约束**：仓库中没有 lint 规则、构建脚本或文档强制要求使用某种日志框架；`NSLog` 的使用是自由散落的。
- **可观测到的模式**：第三方库普遍以宏开关（如 `ENABLE_DEBUG_LOGGING`）或条件编译控制调试日志的输出，这是由第三方库自身决定的，而非本仓库的约定。

综上，该仓库对“日志系统”这一横切关注点的实现程度为：**不存在自研日志系统**，仅依赖 CocoaPods 第三方库自带的 `NSLog`/`os_log`/`printf` 输出。