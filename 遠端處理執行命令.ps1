<#
	參考資料
		https://www.delftstack.com/zh-tw/howto/powershell/powershell-new-pssession/
#>

$username = ""
$password = ""
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object { $secstr.AppendChar($_) }
$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

Invoke-Command -ComputerName "電腦名稱" -ScriptBlock { [System.Net.Dns]::GetHostName() } -Credential $cred