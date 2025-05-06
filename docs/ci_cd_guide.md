# Miki 專案 CI/CD 指南

本文檔說明了 Miki 應用程序的持續集成和持續部署 (CI/CD) 設置和工作流程。

## 概述

我們的 CI/CD 流程使用 GitHub Actions 自動執行測試、代碼分析和構建過程，確保代碼質量並簡化開發流程。目前專注於 iOS 平台的開發。

## CI 流程

我們的 CI 流程包含以下步驟：

1. **代碼質量檢查**
   - 代碼格式驗證（使用 `dart format`）
   - 靜態代碼分析（使用 `flutter analyze`）
   - 運行單元測試和部件測試

2. **構建流程**
   - 為 iOS 模擬器構建應用（調試版）
   - 為 iOS 設備構建應用（調試版，無簽名）

## 平台優先級

目前，我們專注於 iOS 平台開發，其他平台（Web、macOS、Android）將在後續階段考慮。

## 如何運作

當有新的提交或拉取請求時，GitHub Actions 會自動運行我們的工作流程：

1. 檢查分支是否為 `main` 或 `develop`，或者是否為針對這些分支的拉取請求
2. 執行代碼質量檢查工作，包括格式、分析和測試
3. 如果測試通過，執行 iOS 構建工作
4. 將構建產物存儲為工作流程成品，方便開發人員下載和測試

## 本地測試

在提交代碼前，建議本地運行以下命令：

```bash
# 進入 Flutter 專案目錄
cd chat_first_todo

# 格式化代碼
dart format .

# 靜態代碼分析
flutter analyze

# 運行測試
flutter test

# 測試 iOS 構建（如果開發環境為 macOS）
flutter build ios --simulator
```

通過 Git 鉤子，這些檢查會在每次提交前自動執行，確保代碼質量。您可以使用 `git commit --no-verify` 跳過這些檢查，但不建議這樣做。

## 手動觸發 CI 流程

您可以通過以下方式手動觸發 CI 流程：

1. 在 GitHub 上，轉到專案的 Actions 選項卡
2. 點擊 "Miki Flutter CI" 工作流程
3. 點擊 "Run workflow" 按鈕
4. 選擇要運行的分支，然後點擊 "Run workflow"

## 故障排除

如果 CI 流程失敗，請檢查以下常見問題：

1. **測試失敗**：檢查錯誤日誌，修復失敗的測試
2. **代碼格式問題**：運行 `dart format .` 修復格式問題
3. **靜態分析警告/錯誤**：修復 `flutter analyze` 報告的問題
4. **iOS 構建失敗**：
   - 檢查 iOS 依賴是否正確 (`cd ios && pod install`)
   - 確保 Xcode 版本兼容

## 相關文件

- [Flutter 官方測試指南](https://docs.flutter.dev/testing)
- [GitHub Actions 文檔](https://docs.github.com/en/actions)
- [本地環境設置](../scripts/check_env.sh)

<!-- 這是測試 Git 鉤子的測試注釋 --> 