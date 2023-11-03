function Test-ConnectionAndPort {
	param (
		[PSCustomObject]$Item,
		[string]$Action,
		[int]$Port
	)
	
	$Action = "Test Port > " + $Action
	$Result = Test-NetConnection -ComputerName $Item.IP -Port $Port -WarningAction SilentlyContinue

	$FormattedIPPort = "$($Item.IP):$Port".PadRight(26, ' ')
	$Status = ($Result.TcpTestSucceeded) ? "成功" : "失敗"
	$Color = ($Result.TcpTestSucceeded) ? "Green" : "Red"
	$Message = (" " * 21 + $FormattedIPPort + "   " + $Action.PadRight($ActionPadNumber, ' ') + " " + $Status)
	Write-Host $Message -ForegroundColor $Color

	return $Result.TcpTestSucceeded
}