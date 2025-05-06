#!/bin/bash

# 顏色定義
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}===== 設置 Miki 專案 Git 鉤子 =====${NC}"

# 確認當前目錄是專案根目錄
if [ ! -d ".git" ]; then
  echo -e "${RED}錯誤: 此腳本必須從專案根目錄運行.${NC}"
  exit 1
fi

# 創建 pre-commit 鉤子
HOOK_FILE=".git/hooks/pre-commit"

echo "#!/bin/bash
echo \"執行提交前檢查...\"

# 進入 Flutter 專案目錄
cd chat_first_todo || { echo \"錯誤: 找不到 Flutter 專案目錄!\"; exit 1; }

# 檢查格式
echo \"檢查代碼格式...\"
if ! dart format --output=none --set-exit-if-changed .; then
  echo \"錯誤: 代碼格式不符合要求.\"
  echo \"請運行 'dart format .' 修復格式問題.\"
  exit 1
fi

# 靜態分析
echo \"執行代碼分析...\"
if ! flutter analyze --no-pub; then
  echo \"錯誤: 代碼分析發現問題.\"
  echo \"請修復上述問題後再提交.\"
  exit 1
fi

# 運行測試
echo \"運行測試...\"
if [ -d \"test\" ] && [ \"\$(find test -name \"*_test.dart\" | wc -l)\" -gt 0 ]; then
  if ! flutter test; then
    echo \"錯誤: 測試失敗.\"
    echo \"請修復測試問題後再提交.\"
    exit 1
  fi
fi

# 檢查 iOS 構建 (僅限 macOS)
if [[ \"\$OSTYPE\" == \"darwin\"* ]]; then
  echo \"檢查 iOS 模擬器構建...\"
  if ! flutter build ios --debug --no-codesign --simulator; then
    echo \"錯誤: iOS 模擬器構建失敗.\"
    echo \"請修復 iOS 構建問題後再提交.\"
    exit 1
  fi
  
  # 檢查 CocoaPods 依賴
  echo \"檢查 iOS 依賴...\"
  cd ios || { echo \"錯誤: 找不到 iOS 目錄!\"; exit 1; }
  if ! pod install; then
    echo \"錯誤: CocoaPods 依賴安裝失敗.\"
    echo \"請檢查 Podfile 並修復依賴問題後再提交.\"
    exit 1
  fi
  cd ..
fi

echo \"所有檢查通過!\"
exit 0
" > "$HOOK_FILE"

# 使腳本可執行
chmod +x "$HOOK_FILE"

echo -e "${GREEN}Git 鉤子已成功設置!${NC}"
echo "提交前檢查已啟用，提交時將自動執行代碼格式、分析和測試檢查。"
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "已啟用 iOS 模擬器構建和 CocoaPods 依賴檢查。"
  echo "這將確保您的更改在提交前可以在 iOS 環境中正確構建。"
else
  echo "注意：您不在 macOS 環境中，iOS 構建檢查將被跳過。"
  echo "建議在 macOS 環境中進行開發以確保 iOS 構建正常。"
fi
echo "如需臨時跳過這些檢查，可使用 'git commit --no-verify' 命令。" 