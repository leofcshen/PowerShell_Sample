function Send-Notification {
	param (
		[string]$Title,
		[string]$Text,
		[string]$IconType = "Information"
	)
	# 加載 Windows UI 通知的必要組件
	Add-Type -AssemblyName System.Windows.Forms

    # 創建通知物件
	$balloon = New-Object System.Windows.Forms.NotifyIcon

    # 設定圖示
    switch ($IconType) {
			"Warning" { $balloon.Icon = [System.Drawing.SystemIcons]::Warning }
			"Error" { $balloon.Icon = [System.Drawing.SystemIcons]::Error }
			"Question" { $balloon.Icon = [System.Drawing.SystemIcons]::Question }
			"Hand" { $balloon.Icon = [System.Drawing.SystemIcons]::Hand }
			default { $balloon.Icon = [System.Drawing.SystemIcons]::Information }
    }

    # 設定標題和內容
	$balloon.BalloonTipTitle = $Title
	$balloon.BalloonTipText = $Text
    
	# 顯示通知 
	$balloon.Visible = $true
	$balloon.ShowBalloonTip(0)
    
	# 延時後清除
	Start-Sleep -Seconds 3
	$balloon.Dispose()
}

function MyPadRight {
	param (
		[string]$InputString,
		[int]$TotalWidth,
		[char]$PaddingChar = ' '
	)
	
	# 計算中文字的數量
	$chineseCharCount = ($InputString -split '' | Where-Object { $_ -match '\p{IsCJKUnifiedIdeographs}' }).Count
	
	# 調整填充長度，這裡假設一個中文字等於兩個拉丁字母的寬度
	$adjustedWidth = $TotalWidth - $chineseCharCount

	return $InputString.PadRight($adjustedWidth, $PaddingChar)
}

function Test-HostPing {
	param (
		[PSCustomObject]$Item
	)

	$Result = Test-NetConnection -ComputerName $Item.IP -WarningAction SilentlyContinue
	$formattedName = MyPadRight $Item.Name 20
	$formattedIPPort = "$($Item.IP)".PadRight(26, ' ')
	$status = ($Result.PingSucceeded) ? "成功" : "失敗"
	$Color = ($Result.PingSucceeded) ? "Green" : "Red"
	$message = ("$formattedName $formattedIPPort   " + "Ping Host".PadRight($ActionPadNumber, ' ') + " " + $status)
	Write-Host $message -ForegroundColor $Color

	return $Result.PingSucceeded
}

function Test-ConnectionAndPort {
	param (
		[PSCustomObject]$Item,
		[string]$Action,
		[int]$Port
	)
	
	$Action = "Test Port > " + $Action
	$Result = Test-NetConnection -ComputerName $Item.IP -Port $Port -WarningAction SilentlyContinue

	$formattedIPPort = "$($Item.IP):$Port".PadRight(26, ' ')
	$status = ($Result.TcpTestSucceeded) ? "成功" : "失敗"
	$Color = ($Result.TcpTestSucceeded) ? "Green" : "Red"
	$message = (" " * 21 + $formattedIPPort + "   " + $Action.PadRight($ActionPadNumber, ' ') + " " + $status)
	Write-Host $message -ForegroundColor $Color

	return $Result.TcpTestSucceeded
}

function Test-Http {
	param (
		[string]$Action,
		[string]$url
	)
	
	
	$Action = "Test Http > " + $Action
	$response = Invoke-WebRequest -Uri $url -Method Head -SkipHttpErrorCheck
	$is200 = $response.StatusCode -eq 200
	$urlTest = $Action.PadRight($ActionPadNumber, ' ') + " " + ($is200 ? "成功" : "失敗") + " " + $response.StatusCode
	$urlTestColor = $is200 ? "Green" : "Red"
	Write-Host (" " * 21 + $url.PadRight(28, ' ') + " " + $urlTest) -ForegroundColor $urlTestColor
}