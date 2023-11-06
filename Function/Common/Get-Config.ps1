<#
	.SYNOPSIS
		取得 Config 物件
#>
function Get-ConfigX {
	param (
		[string]$JsonPath
	)
	
	if(!$JsonPath) {
		$Type = "環境變數 Env:PS_Config"
		$JsonPath = $Env:PS_Config
	}
	
	Write-Host "使用$Type Config > $JsonPath" -ForegroundColor "Green"
	Write-Host
	
	$ConfigExist = Test-Path -Path $JsonPath -PathType Leaf
	if (!$ConfigExist) { throw "$Type $JsonPath 不存在" }
	$Json = Get-Content -Path $JsonPath | ConvertFrom-Json

	return $Json
}
