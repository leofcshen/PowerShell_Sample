<#
	.SYNOPSIS
		取得 Library 路徑
#>
function Get-LibraryPathX {
	param (
		[string]$LibraryPath
	)
	
	$Type = "自訂變數"
	
	if(!$LibraryPath) {
		$Type = "環境變數 Env:PS_Library"
		$LibraryPath = $Env:PS_Library
	}
	
	Write-Host "使用$Type Library > $LibraryPath" -ForegroundColor "Green"
	Write-Host
	
	if(!$LibraryPath) { throw "LibraryPath 未設定" }
	if(!(Test-Path -Path $LibraryPath -PathType Leaf)) { throw " $LibraryPath 路徑不存在"}
	
	return $LibraryPath
}
