$IsVersion7 = $PSVersionTable.PSVersion.Major -eq 7
$CommonBase = "$PSScriptRoot\Common"
$FunctionBase7 = "$PSScriptRoot\Version_7"
$FunctionBaseOld = "$PSScriptRoot\Version_Old"

# region 依 PowerShell 版本引用方法
if($IsVersion7) {
	$FunctionBase = $FunctionBase7
} else {
	$FunctionBase = $FunctionBaseOld
}

Get-ChildItem $FunctionBase | % { . $_.FullName }
# endregion

# 引用通用方法
Get-ChildItem $CommonBase | % { . $_.FullName}

function MyPadRight {
	param (
		[string]$InputString,
		[int]$TotalWidth,
		[char]$PaddingChar = ' '
	)
	
	# 計算中文字的數量
	$chineseCharCount = ($InputString -split '' | Where-Object { $_ -match '\p{IsCJKUnifiedIdeographs}' }).Count
	
	# 調整填充長度，這裡假設一個中文字等於兩個拉丁字母的寬度
	$adjustedWidth = $TotalWidth - $chineseCharCount

	return $InputString.PadRight($adjustedWidth, $PaddingChar)
}

function Check-IsRunTime {
	param (
		[PSCustomObject]$RunTime
	)
	
	$isRunTime = $false
	# 獲取當前日期和時間
	$now = Get-Date
	# 獲取當前星期
	$dayOfWeek = $now.DayOfWeek
	# 獲取當前時間
	$timeNow = [int]($now.ToString("HHmm"))
	# 取得今天星期 X 的設定
	$TodaySetting = $RunTime | Where-Object { $_.DayOfWeek -eq $dayOfWeek }
	if ($TodaySetting.Enable -and $timeNow -ge $TodaySetting.StartTime -and $timeNow -le $TodaySetting.EndTime) {
		$isRunTime = $true
	}
	
	return $isRunTime
}
