$aa = '123'
Get-Variable aa | Select-Object -ExpandProperty Name

Get-Variable -Name "aa" -ValueOnly
