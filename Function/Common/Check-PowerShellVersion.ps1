<#
	.SYNOPSIS
		回傳 PowerShell 版本是否為 7
#>
function Check-PowerShellVersion {
	$powerShellVersion = $PSVersionTable.PSVersion.Major
	return $powerShellVersion -eq 7
}
