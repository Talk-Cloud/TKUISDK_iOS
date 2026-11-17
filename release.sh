#!/bin/bash
# TKUISDK_iOS 一键发版脚本
# 用法: ./release.sh <版本号> [提交信息] [--proxy] [--yes]
# 示例: ./release.sh 4.19.0.6
#       ./release.sh 4.19.0.6 "release 4.19.0.6 修复xx" --proxy --yes
#
# 前置条件: 已将新 Framework 替换到 TKUISDK_iOS/Frameworks/
# 流程: 改 podspec 版本 -> commit/push -> lib lint -> tag/push -> spec lint -> trunk push
# 代理: --proxy 启用，端口默认 7897，可用环境变量 PROXY_PORT 覆盖（如 PROXY_PORT=7890 ./release.sh x.x.x.x --proxy）

set -euo pipefail

cd "$(dirname "$0")"
PODSPEC="TKUISDK_iOS.podspec"

# ---------- 参数解析 ----------
VERSION=""
COMMIT_MSG=""
USE_PROXY=0
AUTO_YES=0

for arg in "$@"; do
  case "$arg" in
    --proxy) USE_PROXY=1 ;;
    --yes)   AUTO_YES=1 ;;
    *)
      if [[ -z "$VERSION" ]]; then VERSION="$arg"
      elif [[ -z "$COMMIT_MSG" ]]; then COMMIT_MSG="$arg"
      fi ;;
  esac
done

if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
  echo "❌ 用法: ./release.sh <版本号> [提交信息] [--proxy] [--yes]"
  echo "   版本号格式: x.x.x 或 x.x.x.x，例如 4.19.0.6"
  exit 1
fi
[[ -z "$COMMIT_MSG" ]] && COMMIT_MSG="release ${VERSION}"

if [[ "$USE_PROXY" == "1" ]]; then
  PORT="${PROXY_PORT:-7897}"
  export http_proxy="http://127.0.0.1:${PORT}"
  export https_proxy="http://127.0.0.1:${PORT}"
  export all_proxy="socks5://127.0.0.1:${PORT}"
  echo "🌐 已启用代理 127.0.0.1:${PORT}"
fi

confirm() {
  [[ "$AUTO_YES" == "1" ]] && return 0
  read -r -p "$1 [y/N] " ans
  [[ "$ans" == "y" || "$ans" == "Y" ]]
}

step() { echo ""; echo "========== $1 =========="; }

# ---------- 前置检查 ----------
step "0/6 前置检查"
[[ -f "$PODSPEC" ]] || { echo "❌ 未找到 $PODSPEC"; exit 1; }
command -v pod >/dev/null || { echo "❌ 未安装 CocoaPods，请先 sudo gem install cocoapods"; exit 1; }

if git rev-parse -q --verify "refs/tags/${VERSION}" >/dev/null; then
  echo "❌ 本地已存在 tag ${VERSION}，请换版本号或先删除旧 tag"
  exit 1
fi
if git ls-remote --tags origin "refs/tags/${VERSION}" | grep -q .; then
  echo "❌ 远端已存在 tag ${VERSION}，请换版本号"
  exit 1
fi

OLD_VERSION=$(grep -E "s\.version\s*=" "$PODSPEC" | head -1 | sed -E "s/.*'([^']+)'.*/\1/")
echo "版本: ${OLD_VERSION} -> ${VERSION}"
echo "待提交变更:"
git status --short | head -20
confirm "确认发布 ${VERSION}？" || { echo "已取消"; exit 0; }

# ---------- 1. 修改版本号并提交 ----------
step "1/6 修改 podspec 版本号并提交推送"
sed -i '' -E "s/(s\.version[[:space:]]*=[[:space:]]*)'[^']+'/\1'${VERSION}'/" "$PODSPEC"
grep -E "s\.version\s*=" "$PODSPEC"

git add .
git commit -m "$COMMIT_MSG"
git push

# ---------- 2. 本地校验 ----------
step "2/6 本地校验 (pod lib lint)"
pod lib lint "$PODSPEC" --allow-warnings --skip-import-validation

# ---------- 3. 打 tag ----------
step "3/6 打 tag 并推送"
git tag "$VERSION"
git push origin "refs/tags/${VERSION}"

# ---------- 4. 远程校验 ----------
step "4/6 远程校验 (pod spec lint)"
pod spec lint "$PODSPEC" --allow-warnings

# ---------- 5. 发布 ----------
step "5/6 发布到 CocoaPods trunk"
confirm "lint 全部通过，确认 trunk push ${VERSION}？" || { echo "已停在发布前，tag 已推送，可手动执行: pod trunk push $PODSPEC --allow-warnings"; exit 0; }
if ! pod trunk push "$PODSPEC" --allow-warnings; then
  echo ""
  echo "⚠️ push 报错。若为超时/服务器错误，可能服务端已成功，先执行 pod trunk info TKUISDK_iOS 确认版本是否已收录，勿盲目重试。"
  echo "⚠️ 若为 Authentication token 失效，执行 pod trunk register <你的邮箱> '<姓名>' 并点击验证邮件后重试。"
  exit 1
fi

# ---------- 6. 完成 ----------
step "6/6 发布完成 🎉"
echo "版本 ${VERSION} 已发布。trunk 生效有延迟，客户可临时使用:"
echo "  pod 'TKUISDK_iOS', :git => 'https://github.com/Talk-Cloud/TKUISDK_iOS.git', :tag => '${VERSION}'"