# 測試全域變數是否存在
#region 方法一 Get-Variable
Get-Variable MyVariable -Scope global # 找不到會報錯

# 呼略錯誤
if (Get-Variable MyVariable -Scope Global -ErrorAction Ignore) {
	$true
}
else {
	$false
}

# 簡略寫法
[bool](Get-Variable MyVariable -Scope Global -ErrorAction Ignore)
[bool](gv foo -s global -ea ig)

# 處理錯誤
try {
	Get-Variable MyVariable -Scope Global -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException] {
	Write-Warning $_
}
#endregion

#region 方法二 Test-Path
Test-Path vaiable:global:MyVariable
#endregion