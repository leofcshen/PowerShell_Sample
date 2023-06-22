# 自訂備份位置
$BackupBase = "D:\User\Desktop\Backup"

Function Copy-WithProgress {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
		$Source,
		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
		$Destination
	)

	$Source = $Source.tolower()
	$FileList = Get-Childitem "$Source" -Recurse -Force
	$Total = $FileList.count
	$Position = 0

	foreach ($File in $FileList) {
		$Filename = $File.Fullname.tolower().replace($Source, '')
		$DestinationFile = ($Destination + $Filename)
		Write-Progress -Activity "Copying data from '$source' to '$Destination'" -Status "Copying File $Filename" -PercentComplete ($Position / $Total * 100)
		Copy-Item $File.FullName -Destination $DestinationFile
		$Position++
	}
}

try {
	1..9 | % { Write-Host }

	$Current = $MyInvocation.MyCommand
	$TargetFolerName = ($Current.name.Replace(".ps1", "") -split "_")[1]
	$TargetFolerPath = $Current.Path.Replace("Backup_", "").Replace(".ps1", "")
	$Today = Get-Date -Format "yyyyMMdd"
	$IsRunBackup = $true
	$BackupFolderNewName = "${TargetFolerName}_${Today}"
	$FolderList = @((Get-ChildItem -Path $BackupBase -Filter "${BackupFolderNewName}*") | Where-Object { $_.PSIsContainer }  | ForEach-Object { $_.Name })

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
		$BackupDestination = "${BackupBase}\${BackupFolderNewName}"
		Write-Host "備份開始"
		Write-Host "來源 $TargetFolerPath"
		Write-Host "目的 $BackupDestination"
		Write-Host "備份中，請稍候…"

		#Copy-Item -Path $TargetFolerPath -Destination $BackupDestination -Recurse -Force
		Copy-WithProgress -Source $TargetFolerPath -Destination $BackupDestination

		Write-Host "備份完成"
	}
 else {
		Write-Host "已取消備份"
	}
}
catch {
	Write-Host $Error[0]
}

Write-Host
Write-host "輸入任意鍵離開..."
$host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp")