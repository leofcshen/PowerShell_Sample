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

# 複製檔案並顯示進度條
function Copy-File {
	param( [string]$from, [string]$to)
	$ffile = [io.file]::OpenRead($from)
	$tofile = [io.file]::OpenWrite($to)
	Write-Progress -Activity "Copying file" -status "$from -> $to" -PercentComplete 0
	try {
		[byte[]]$buff = new-object byte[] 4096
		[long]$total = [int]$count = 0
		do {
			$count = $ffile.Read($buff, 0, $buff.Length)
			$tofile.Write($buff, 0, $count)
			$total += $count
			if ($total % 1mb -eq 0) {
				Write-Progress -Activity "Copying file" -status "$from -> $to" `
					-PercentComplete ([long]($total * 100 / $ffile.Length))
			}
		} while ($count -gt 0)
	}
	finally {
		$ffile.Dispose()
		$tofile.Dispose()
		Write-Progress -Activity "Copying file" -Status "Ready" -Completed
	}
}