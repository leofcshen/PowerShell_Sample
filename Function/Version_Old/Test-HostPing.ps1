function Test-HostPing {
	param (
		[PSCustomObject]$Item
	)

	$Result = Test-NetConnection -ComputerName $Item.IP -WarningAction SilentlyContinue
	$FormattedName = MyPadRight $Item.Name 20
	$FormattedIPPort = "$($Item.IP)".PadRight(26, ' ')
	
	if($Result.PingSucceeded) {
		$Status = "成功"
		$Color = "Green"
	} else {
		$Status = "失敗"
		$Color = "Red"
	}
	
	$Message = ("$FormattedName $FormattedIPPort   " + "Ping Host".PadRight($ActionPadNumber, ' ') + " " + $Status)
	Write-Host $Message -ForegroundColor $Color

	return $Result.PingSucceeded
}