# 讀設定檔取得 DB 設定資料
$config = Get-Content -Path .\config.json | ConvertFrom-Json
$config

# 產生 .json
$ConfigPath = "$PSScriptRoot\config.json"
# 檢查檔案是否存在
$ConfigExist = Test-Path -Path $ConfigPath -PathType Leaf
if (!$ConfigExist) {
	$ConfigJsonVar =	@"
{
	"BT": {
		"DownloadFolder": "",
		"BTFolder": "",
		"BTCopyFolder": ""
	},
	"LogFolder": "D:\\PowerShell\\Log"
}
"@
	$ConfigJsonObject = $ConfigJsonVar | ConvertFrom-Json
	$ConfigJsonObject | ConvertTo-Json | Out-File $ConfigPath
}