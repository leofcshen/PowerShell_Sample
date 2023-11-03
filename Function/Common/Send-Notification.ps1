<#
	.SYNOPSIS
		發送 Window 通知
#>
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
