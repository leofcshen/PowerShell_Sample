<#
	.SYNOPSIS
		檢查檔案是否存在
	.PARAMETER PathType
		檢查類型
		Any	0 全部
		Container	1 資料夾
		Leaf	2 檔案
	.EXAMPLE
		Test-PathExist @Path container
		Test-PathExist @Path s 2
#>
function Test-PathExist {
	param (
		[Parameter()]
		[string] $pPath,
		[Parameter()]
		[string] $PathType = 1
	)
	$FileExist = Test-Path -Path $pPath -PathType $PathType
	write-host ($FileExist ? "存在" : "不存在")
}

# 如果資料夾不存在建立資料夾
$FileExist = Test-Path -Path $LogFolder -PathType Container
if (!$FileExist) {
	New-Item -ItemType Directory -Path $LogFolder
}
# 刪除資料夾下所有東西
Get-ChildItem -Path $path -Recurse | Foreach-object { Remove-item -Recurse -path $_.FullName }

# 刪除資料夾下所有空資料夾
Get-ChildItem -Path $path -Recurse | Where-Object { (Get-ChildItem $_.FullName).Count -eq 0 } | Foreach-object { Remove-item -Recurse -path $_.FullName }

# 刪除資料夾
Remove-Item $path -Recurse