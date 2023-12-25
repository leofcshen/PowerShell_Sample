<#
	.SYNOPSIS
		單行輸出不同顏色的文字
#>
function Write-Color(
	[String[]]$Text,
	[ConsoleColor[]]$Color = "White",
	# 這一行前面增加你指定的TABS
	[int]$StartTab = 0,
	# 此排文字前，你想加幾行空白的行數
	[int] $LinesBefore = 0,
	# 此排文字後，你想加幾行空白的行數
	[int] $LinesAfter = 0,
	[string] $LogFile = "",
	$TimeFormat = "yyyy-MM-dd HH:mm:ss") {
	
	$DefaultColor = $Color[0]
	if ($LinesBefore -ne 0) { for ($i = 0; $i -lt $LinesBefore; $i++) { Write-Host "`n" -NoNewline } } # Add empty line before
	if ($StartTab -ne 0) { for ($i = 0; $i -lt $StartTab; $i++) { Write-Host "`t" -NoNewLine } } # Add TABS before text
	if ($Color.Count -ge $Text.Count) {
		for ($i = 0; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
	} else {
		for ($i = 0; $i -lt $Color.Length ; $i++) { Write-Host $Text[$i] -ForegroundColor $Color[$i] -NoNewLine }
		for ($i = $Color.Length; $i -lt $Text.Length; $i++) { Write-Host $Text[$i] -ForegroundColor $DefaultColor -NoNewLine }
	}
	Write-Host
	if ($LinesAfter -ne 0) { for ($i = 0; $i -lt $LinesAfter; $i++) { Write-Host "`n" } } # Add empty line after
	if ($LogFile -ne "") {
		$TextToFile = ""
		for ($i = 0; $i -lt $Text.Length; $i++) {
			$TextToFile += $Text[$i]
		}
		Write-Output "[$([datetime]::Now.ToString($TimeFormat))]$TextToFile" | Out-File $LogFile -Encoding unicode -Append
	}
}