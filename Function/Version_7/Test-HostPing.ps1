function Test-HostPing {
	param (
		[PSCustomObject]$Item
	)

	$Result = Test-NetConnection -ComputerName $Item.IP -WarningAction SilentlyContinue
	$FormattedName = MyPadRight $Item.Name 20
	$FormattedIPPort = "$($Item.IP)".PadRight(26, ' ')
	$Status = ($Result.PingSucceeded) ? "成功" : "失敗"
	$Color = ($Result.PingSucceeded) ? "Green" : "Red"
	$Message = ("$FormattedName $FormattedIPPort   " + "Ping Host".PadRight($ActionPadNumber, ' ') + " " + $Status)
	Write-Host $Message -ForegroundColor $Color

	return $Result.PingSucceeded
}