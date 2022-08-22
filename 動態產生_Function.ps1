<#
	參考資料
		https://blog.poychang.net/dynamic-create-function-in-powershell/
#>

# 這三個 Function 動作長得很像，只有 Function 名稱和輸出的結果有些不同，如何在不影響其他地方的使用方式下，動態建立這些 Function 呢？
function Function1($Description) { Write-Output "Result1 - $Description" }
function Function2($Description) { Write-Output "Result2 - $Description" }
function Function3($Description) { Write-Output "Result3 - $Description" }

Function1 "Hello World 1"
Function2 "Hello World 2"
Function3 "Hello World 3"

function Add-DynamicFunction {
	# Param 接收兩個參數，分別會是 Function 名稱，以及執行 Function 時的動作。
	Param(
		[Parameter(
			Mandatory = $true,
			Position = 0,
			HelpMessage = "Function name"
		)]
		[string]$FuncName,
		[Parameter(
			Mandatory = $true,
			Position = 1,
			HelpMessage = "Function action"
		)]
		[string] $FuncAction
	)
	# 組合的 Function 前面加上 global: 表示是全域使用的 Function，否則之後會找不到此建立的 Function
	Set-Variable -name Func -value "function global:$($FuncName)() { $($FuncAction) }"
	Invoke-Expression $Func
}

# 動態建立 Function
Add-DynamicFunction -FuncName 'Get-HelloFromDynamicFunction' -FuncAction 'Write-Output "Hello-Dynamic-Function..."'
# 執行動態建立的 Function
Get-HelloFromDynamicFunction

# 批量動態建立 Function
$list = @(
	[PSCustomObject]@{ FuncName = "Func1"; Description = "1" },
	[PSCustomObject]@{ FuncName = "Func2"; Description = "2" },
	[PSCustomObject]@{ FuncName = "Func3"; Description = "3" }
);

foreach ($item in $list) {
	$Script = "Write-Output ('Hello-Dynamic-Function_with Description:$($item.Description)')"
	# 下面寫法出來的值異常
	# $Script = 'Write-Output ("Hello-Dynamic-Function_with Description:$($item.Description)")'
	Add-DynamicFunction -FuncName $item.FuncName -FuncAction $Script
}

# 執行動態建立的 Function (用 string 呼叫)
# 方法一
foreach ($item in $list) { &($item.FuncName) }
# 方法二
$list.ForEach({ &($_.FuncName) })
# 方法三
$list | ForEach-Object { &($_.FuncName) }
