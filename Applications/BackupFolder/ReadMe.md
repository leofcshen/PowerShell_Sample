# 功能說明

以今天日期 `FolderName_yyyyMMdd` 的名稱備份資料夾，如果備份資料夾已存在可選擇是否再備份至 `FolderName_yyyyMMdd_Index`，`Index` 從 1 開始累加。

# 使用說明

> PowerShell 2.0 請使用 2.0_Version

1. 將腳本置於要備份的資料夾同一層目錄。
2. 重新命名腳本名稱 `Backup_FolderName.ps1` 將 `FolderName` 替換為你要備份的資料夾名稱。
3. 編輯腳本第一行設定要放備份的目的資料夾
4. 執行。
