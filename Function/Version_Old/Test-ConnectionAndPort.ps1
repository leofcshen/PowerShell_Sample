function Test-ConnectionAndPort {
	param (
		[PSCustomObject]$Item,
		[string]$Action,
		[int]$Port
	)
	
	$Action = "Test Port > " + $Action
	$Result = Test-NetConnection -ComputerName $Item.IP -Port $Port -WarningAction SilentlyContinue

	$formattedIPPort = "$($Item.IP):$Port".PadRight(26, ' ')
	
	if($Result.TcpTestSucceeded) {
		$Status = "成功"
		$Color = "Green"
	} else {
		$Status = "失敗"
		$Color = "Red"
	}
	
	$Message = (" " * 21 + $FormattedIPPort + "   " + $Action.PadRight($ActionPadNumber, ' ') + " " + $Status)
	Write-Host $Message -ForegroundColor $Color

	return $Result.TcpTestSucceeded
}