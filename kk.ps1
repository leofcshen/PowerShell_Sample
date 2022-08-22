Function Test-ValidatePattern {
	[CmdletBinding()]
	Param (
		[ValidatePattern('^\d{8}$', ErrorMessage = "Please use an 8 digit numeric value.")]
		[String]$Digits
	)

	Process {
		Write-Output $Digits
	}
}

Test-ValidatePattern -Digits '12345678'
Test-ValidatePattern -Digits '1234567A'