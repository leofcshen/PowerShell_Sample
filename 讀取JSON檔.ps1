# 讀設定檔取得 DB 設定資料
$config = Get-Content -Path .\config.json | ConvertFrom-Json
$config
