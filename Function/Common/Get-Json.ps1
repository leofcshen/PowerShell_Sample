<#
	.SYNOPSIS
		取得 .json 物件
#>
function Get-Json {
	param (
		[string]$JsonPath
	)
	
	$ConfigExist = Test-Path -Path $JsonPath -PathType Leaf
	if (!$ConfigExist) { throw "$JsonPath 不存在" }
	$Json = Get-Content -Path $JsonPath | ConvertFrom-Json

	return $Json
}
