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
	$notify = New-Object System.Windows.Forms.NotifyIcon

	# 設定圖示
	switch ($IconType) {
		"Warning" { $notify.Icon = [System.Drawing.SystemIcons]::Warning }
		"Error" { $notify.Icon = [System.Drawing.SystemIcons]::Error }
		"Question" { $notify.Icon = [System.Drawing.SystemIcons]::Question }
		"Hand" { $notify.Icon = [System.Drawing.SystemIcons]::Hand }
		default { $notify.Icon = [System.Drawing.SystemIcons]::Information }
	}

	# 設定標題和內容
	$notify.BalloonTipTitle = $Title
	$notify.BalloonTipText = $Text
	
	# 顯示通知 
	$notify.Visible = $true
	$notify.ShowBalloonTip(0)
    
	# 延時後清除不加這行圖示不知道為什麼不會顯示
	Start-Sleep -Seconds 1
	$notify.Dispose()
}
