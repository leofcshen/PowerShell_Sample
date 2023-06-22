Function Copy-Folder {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, Position = 1)]
		$Destination
	)

	$Source = $Source.tolower()
	$FileList = Get-Childitem "$Source" -Recurse -Force


	$FileList | ForEach-Object {
		Write-Host $Destination
	}

	# 下列用 foreach 就不會有 Destination 變數未使用的警告

	# foreach ($File in $FileList) {
	# 	Write-Host $Destination
	# }
}