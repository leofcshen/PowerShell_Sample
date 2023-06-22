# 自訂備份位置
$BackupBase = "D:\User\Desktop\Backup"

Function Copy-Folder {
	<#
		.SYNOPSIS
			複製資料夾並顯示進度條
		.EXAMPLE
			Copy-Folder $From $To
		.EXAMPLE
			Copy-Folder $From $To -ProgressByFileNumber
	#>
	[CmdletBinding()]
	Param (
		# 備份來源
		[Parameter(Mandatory = $true, Position = 0)]
		$Source,
		# 備份位置
		[Parameter(Mandatory = $true, Position = 1)]
		$Destination,
		# 進度條是否以檔案數量顯示，沒設以檔案容量顯示。
		[Parameter()]
		[switch] $ProgressByFileNumber
	)

	$Source = $Source.tolower()
	$FileList = Get-Childitem "$Source" -Recurse -Force
	$Done = 0
	$Total = 0

	if ($ProgressByFileNumber) {
		$Type = "檔案數量模式"
	}
	else {
		$Type = "檔案容量模式"
	}

	# 計算總檔案數量或總大小
	$FileList | ForEach-Object {
		if ($ProgressByFileNumber.IsPresent) {
			$Total++
		}
		else {
			$Total += $_.Length
		}
	}

	# 開始複製檔案
	foreach ($File in $FileList ) {
		$Filename = $File.Fullname.tolower().replace($Source, '')
		$DestinationFile = $Destination + $Filename
		$Percent = $Done / $Total * 100
		$ProgressActivity = "來源 >>> '$source' 位置 >>> '$Destination'"
		Write-Progress -Activity $ProgressActivity -Status "複製 $Filename" -PercentComplete $Percent -CurrentOperation "$Type，$($Percent.ToString("f2"))% Finished"
		Copy-Item $File.FullName -Destination $DestinationFile

		if ($ProgressByFileNumber.IsPresent) {
			$Done++
		}
		else {
			$Done += $File.Length
		}
	}

	Write-Progress -Activity $ProgressActivity -Status "備份完成"
}

try {
	if (!(Test-Path $BackupBase)) {
		throw "備份位置路徑 ${BackupBase} 不存在"
	}

	$Current = $MyInvocation.MyCommand
	$TargetFolerName = ($Current.name.Replace(".ps1", "") -split "_")[1]
	$TargetFolerPath = $Current.Path.Replace("Backup_", "").Replace(".ps1", "")
	$Today = Get-Date -Format "yyyyMMdd"
	$IsRunBackup = $true
	$BackupFolderNewName = "${TargetFolerName}_${Today}"
	$FolderList = @((Get-ChildItem -Path $BackupBase -Filter "${BackupFolderNewName}*") | Where-Object { $_.PSIsContainer }  | ForEach-Object { $_.Name })

	if (!(Test-Path $TargetFolerPath)) {
		throw "備份目標路徑 ${TargetFolerPath} 不存在"
	}

	1..9 | % { Write-Host }

	if ($FolderList.Count -ne 0) {
		Write-Host "$BackupBase 已存在本日備份如下"

		foreach ($Folder in $FolderList) {
			Write-Host $Folder
		}

		Write-Host
		Write-Host "是否仍要執行新的備份? Y/N(預設)"
		$Key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp")
		$IsRunBackup = $Key.Character -eq "y"
		$FolderNumber = ([int]($FolderList | ForEach-Object { $_.Replace("${TargetFolerName}_${Today}", 0).Replace("0_", "") } | Measure-Object -Max).Maximum) + 1
		$BackupFolderNewName = "${BackupFolderNewName}_${FolderNumber}"
		Write-Host
	}

	if ($IsRunBackup) {
		$Size = (Get-ChildItem $TargetFolerPath -Recurse -Force | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum

		$SizeMB = $Size / 1MB
		if ($SizeMB -gt 1) {
			$SizeInfo = "{0:N2} MB" -f $SizeMB
		}

		$SizeGB = $Size / 1GB
		if ($SizeGB -gt 1) {
			$SizeInfo = "{0:N2} GB" -f $SizeGB
		}

		$BackupDestination = "${BackupBase}\${BackupFolderNewName}"
		Write-Host "備份開始"
		Write-Host "備份來源 >>> $TargetFolerPath"
		Write-Host "修份大小 >>> $SizeInfo"
		Write-Host "備份位置 >>> $BackupDestination"
		Write-Host "備份中，請稍候…"

		Copy-Folder $TargetFolerPath $BackupDestination

		Write-Host "備份完成"
	}
	else {
		Write-Host "已取消備份"
	}

	Write-Host
}
catch {
	Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor Red
	Write-Host $_.Exception.Message -ForegroundColor Red
	Write-Host $_.ScriptStackTrace
	Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor Red
}

Write-Host
Write-host "輸入任意鍵離開..."
$host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null