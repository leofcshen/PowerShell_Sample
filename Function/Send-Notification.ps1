function Send-Notification {
	param (
		[string]$Title,
		[string]$Text
	)

	
	Add-Type -AssemblyName System.Windows.Forms


	$balloon = New-Object System.Windows.Forms.NotifyIcon


	$balloon.Icon = [System.Drawing.SystemIcons]::Information


	$balloon.BalloonTipTitle = $Title
	$balloon.BalloonTipText = $Text


	$balloon.Visible = $true
	$balloon.ShowBalloonTip(0)

	Start-Sleep -Seconds 3
	$balloon.Dispose()
}