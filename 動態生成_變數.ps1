for ($i = 1; $i -le 5; $i++) {
	New-Variable -Name "var$i" -Value $i
}

Get-Variable var*
Get-Variable var* -ValueOnly

Remove-Variable var*