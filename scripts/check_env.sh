#!/bin/bash

# 顏色定義
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}===== Miki 專案環境檢查工具 =====${NC}"
echo "檢查您的本地開發環境是否符合 iOS 開發要求..."
echo

# 檢查操作系統
echo -n "檢查操作系統: "
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${GREEN}macOS $(sw_vers -productVersion)${NC}"
else
    echo -e "${RED}非 macOS 系統${NC}"
    echo "警告: Miki 專案目前專注於 iOS 開發，需要 macOS 環境。"
    echo "將繼續檢查基本 Flutter 環境，但 iOS 特定功能將不可用。"
fi

# 進入 Flutter 專案目錄
cd "$(dirname "$0")/../chat_first_todo" || { echo -e "${RED}找不到 Flutter 專案目錄!${NC}"; exit 1; }

# 檢查 Flutter
echo -n "檢查 Flutter 版本: "
if command -v flutter >/dev/null 2>&1; then
    flutter_version=$(flutter --version | head -1 | cut -d ',' -f1 | awk '{print $2}')
    echo -e "${GREEN}$flutter_version${NC}"
else
    echo -e "${RED}找不到 Flutter!${NC}"
    echo "請從 https://flutter.dev/docs/get-started/install 安裝 Flutter"
    exit 1
fi

# 檢查 Dart
echo -n "檢查 Dart 版本: "
if command -v dart >/dev/null 2>&1; then
    dart_version=$(dart --version | cut -d ' ' -f4)
    echo -e "${GREEN}$dart_version${NC}"
else
    echo -e "${RED}找不到 Dart!${NC}"
    echo "請從 https://dart.dev/get-dart 安裝 Dart"
    exit 1
fi

# 檢查 Xcode (適用於 macOS 用戶)
echo -n "檢查 Xcode 版本: "
if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v xcodebuild >/dev/null 2>&1; then
        xcode_version=$(xcodebuild -version | head -n 1)
        echo -e "${GREEN}$xcode_version${NC}"
        
        # 檢查 iOS 開發者命令行工具
        echo -n "檢查 iOS 開發者工具: "
        if xcrun --find simctl &>/dev/null; then
            echo -e "${GREEN}已安裝${NC}"
        else
            echo -e "${RED}未安裝${NC}"
            echo "請在 Xcode 中選擇 Xcode > Preferences > Locations，確保 Command Line Tools 已設置。"
        fi
    else
        echo -e "${RED}未安裝 Xcode${NC}"
        echo "錯誤: 沒有 Xcode，無法進行 iOS 開發。請從 App Store 安裝 Xcode。"
        exit 1
    fi
else
    echo -e "${YELLOW}非 macOS 系統，跳過 Xcode 檢查${NC}"
fi

# 檢查 CocoaPods
echo -n "檢查 CocoaPods: "
if command -v pod >/dev/null 2>&1; then
    pod_version=$(pod --version)
    echo -e "${GREEN}$pod_version${NC}"
else
    echo -e "${RED}未安裝 CocoaPods${NC}"
    echo "請運行 'sudo gem install cocoapods' 安裝 CocoaPods。"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        exit 1
    fi
fi

# 檢查 Flutter 依賴
echo -n "檢查 Flutter 依賴: "
flutter pub get
echo -e "${GREEN}依賴更新完成${NC}"

# 檢查 iOS 模塊依賴
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -n "檢查 iOS 依賴: "
    if [ -d "ios" ]; then
        cd ios
        if pod install; then
            echo -e "${GREEN}CocoaPods 依賴更新完成${NC}"
        else
            echo -e "${RED}CocoaPods 依賴更新失敗${NC}"
            echo "請嘗試手動運行 'cd ios && pod install'"
        fi
        cd ..
    else
        echo -e "${RED}找不到 iOS 目錄${NC}"
    fi
fi

# 檢查代碼格式
echo -n "檢查代碼格式: "
format_issues=$(dart format --output=none --set-exit-if-changed . 2>&1 || echo "有格式問題")
if [[ "$format_issues" == *"有格式問題"* ]]; then
    echo -e "${YELLOW}有格式問題，建議運行 'dart format .'${NC}"
else
    echo -e "${GREEN}格式正確${NC}"
fi

# 檢查代碼分析
echo -n "執行代碼分析: "
analysis_issues=$(flutter analyze 2>&1)
if [[ "$analysis_issues" == *"No issues found"* ]]; then
    echo -e "${GREEN}沒有問題${NC}"
else
    echo -e "${YELLOW}發現問題:${NC}"
    echo "$analysis_issues"
fi

# 檢查測試
echo -n "運行單元測試: "
if [[ -d "test" && "$(find test -name "*_test.dart" | wc -l)" -gt 0 ]]; then
    flutter test || echo -e "${YELLOW}測試失敗${NC}"
else
    echo -e "${YELLOW}沒有找到測試文件${NC}"
fi

# 檢查 iOS 模擬器配置 (適用於 macOS 用戶)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -n "檢查 iOS 模擬器: "
    simulators=$(xcrun simctl list devices available 2>/dev/null | grep -v "^[[:space:]]*$" | grep -v "^--" | grep -v "^Devices")
    if [[ -n "$simulators" ]]; then
        echo -e "${GREEN}可用${NC}"
        echo "可用的 iOS 模擬器:"
        xcrun simctl list devices available | grep -v "^[[:space:]]*$" | grep -v "^--" | grep -v "^Devices" | head -5
        if [[ $(xcrun simctl list devices available | grep -v "^[[:space:]]*$" | grep -v "^--" | grep -v "^Devices" | wc -l) -gt 5 ]]; then
            echo "... 更多設備 ..."
        fi
    else
        echo -e "${YELLOW}未找到可用的 iOS 模擬器${NC}"
        echo "提示: 在 Xcode 中創建 iOS 模擬器設備。運行 Xcode > Open Developer Tool > Simulator，然後選擇 File > New Simulator"
    fi

    # 檢查是否可以構建 iOS 應用
    echo -n "檢查 iOS 構建環境: "
    if flutter build ios --debug --no-codesign --simulator &>/dev/null; then
        echo -e "${GREEN}可以構建 iOS 模擬器應用${NC}"
    else
        echo -e "${YELLOW}構建 iOS 模擬器應用可能有問題${NC}"
        echo "提示: 嘗試在 Xcode 中打開項目並解決潛在問題"
    fi
fi

echo
echo -e "${YELLOW}===== 環境檢查完成 =====${NC}"
echo "如有問題，請根據上面的提示進行修復。"
echo "如果一切正常，你的 iOS 開發環境已準備好。" 