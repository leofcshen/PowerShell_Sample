$Base = $args[0]
$FileArray = $args[1]
$CopyTo = $args[2]

try {
	$ErrorActionPreference = 'Stop'
	# 取得資料夾名稱
	$FolderName = Split-Path $Base -leaf
	# 要複製到的資料夾名稱
	$CopyToFolderPath = "$CopyTo\$FolderName"
	
	# 刪除原有的資料夾
	if (Test-Path $CopyToFolderPath) {
		Remove-Item -LiteralPath $CopyToFolderPath -Force -Recurse
	}	
	
	Write-Host "開始複製 $($FileArray.Length) 個檔案"
	Write-Host

	foreach ($item in $FileArray){		
		$From = $Base + $item
		$To = "$CopyToFolderPath\$item"
		#	創建要複製的檔案資料夾結構
		$null = New-Item -ItemType Directory -Path (Split-Path $To) -Force
		Write-Host "複製 $To"
		Copy-Item -Path $From -Destination $To
	}
	
	Write-Host
	Write-Host "複製完成"
}
catch {
	Write-Host "!!!!!! 發生錯誤 !!!!!" -BackgroundColor Red
	Write-Host $_.Exception.Message -ForegroundColor Red
	Write-Host $_.ScriptStackTrace
	Write-Host "!!!!!!!!!!!!!!!!!!!!!" -BackgroundColor Red
}

Write-Host
Pause