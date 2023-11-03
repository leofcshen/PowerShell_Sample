function Test-Http {
	param (
		[string]$Action,
		[string]$Url
	)	
	
	$Action = "Test Http > " + $Action
	$Response = Invoke-WebRequest -Uri $Url -Method Head -SkipHttpErrorCheck
	$Is200 = $response.StatusCode -eq 200
	$UrlTest = $Action.PadRight($ActionPadNumber, ' ') + " " + ($Is200 ? "成功" : "失敗") + " " + $response.StatusCode
	$Color = $Is200 ? "Green" : "Red"
	Write-Host (" " * 21 + $Url.PadRight(28, ' ') + " " + $UrlTest) -ForegroundColor $Color
}