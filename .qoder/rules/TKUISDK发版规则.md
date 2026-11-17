---
trigger: model_decision
description: 当用户要求发布新版本、发版、更新 SDK 到 CocoaPods，或提供了新版本号并替换了 Framework 时使用
---

# TKUISDK_iOS 发版规则

## 仓库定位
本仓库是 CocoaPods 发布载体，仅分发预编译 Framework，不包含 SDK 源码。生成 wiki/文档时只覆盖文件目录结构、配置与发版流程，不分析 Framework 内部功能。

## 发版分工
用户只负责：替换 `TKUISDK_iOS/Frameworks/` 下的 Framework 产物 + 提供版本号。其余全部由 agent 执行，优先使用仓库根目录的 `./release.sh <版本号>`，或按以下流程手动执行：

1. 前置检查：git 状态、本地/远端是否已存在同名 tag（存在则停止，让用户换版本号）
2. 修改 `TKUISDK_iOS.podspec` 的 `s.version` 为用户给的版本号 → `git add . && git commit -m "release <版本号>" && git push`
3. `pod lib lint TKUISDK_iOS.podspec --allow-warnings --skip-import-validation`
4. `git tag <版本号>`（必须与 s.version 完全一致）→ `git push origin refs/tags/<版本号>`
5. `pod spec lint TKUISDK_iOS.podspec --allow-warnings`
6. `pod trunk push TKUISDK_iOS.podspec --allow-warnings`

## 网络与代理
- git push / pod 命令网络失败时走本机代理，端口因人而异（已知本机常用 7897，旧文档为 7890），先用 `nc -z 127.0.0.1 <端口>` 探测哪个在线：
  `export https_proxy=http://127.0.0.1:<端口> http_proxy=http://127.0.0.1:<端口> all_proxy=socks5://127.0.0.1:<端口>`

## 故障处理
- trunk push 报 "GitHub commit API timed out" / "internal server error"：服务端可能已成功，先 `pod trunk info TKUISDK_iOS` 确认版本是否已收录，勿盲目重试；报 "duplicate entry" 即已发布成功。
- trunk push 报 "Authentication token is invalid"：`pod trunk register <邮箱> '<姓名>'` 重新注册，请用户点击验证邮件后重试。发布人必须是该 pod 的 owner（可由现有 owner 执行 `pod trunk add-owner TKUISDK_iOS <邮箱>` 添加）。
- 任一步失败立即停止，不带错误继续后续步骤。

## 发布后
告知客户接入方式：`pod 'TKUISDK_iOS', '<版本号>'`；CDN 延迟期间临时用 `pod 'TKUISDK_iOS', :git => 'https://github.com/Talk-Cloud/TKUISDK_iOS.git', :tag => '<版本号>'`。