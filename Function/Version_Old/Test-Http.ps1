function Test-Http {
	param (
		[string]$Action,
		[string]$Url
	)	
	
	$Action = "Test Http > " + $Action
	$Response = Invoke-WebRequest -Uri $Url -Method Head -SkipHttpErrorCheck
	$Is200 = $response.StatusCode -eq 200
	
	if($Is200) {
		$Result = "成功"
		$Color = "Green"
	} else {
		$Result = "失敗"
		$Color = "Red"
	}
	
	$UrlTest = $Action.PadRight($ActionPadNumber, ' ') + " " + $Result + " " + $response.StatusCode
	Write-Host (" " * 21 + $Url.PadRight(28, ' ') + " " + $UrlTest) -ForegroundColor $Color
}