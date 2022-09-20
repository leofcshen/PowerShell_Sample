# $IP = "www.airitibooks.com", "10.0.1.55", "10.0.0.16", "10.0.0.27", "10.0.0.95"
$DB = "10.0.1.50", "192.168.1.129", "10.0.3.50"
do {
	$datetime = Get-Date -UFormat "%Y/%m/%d %A %H:%M:%S"
	Write-Host $datetime
	# 去 ping 閘道 IP
	# $IP | ForEach-Object -Parallel {
	# 	if (Test-Connection -Computernam $_ -Count 1 -ErrorAction SilentlyContinue) {
	# 		Write-Host $using:datetime, " Server $_ is Up" -ForegroundColor Green
	# 	}
	# 	else {
	# 		Write-Host $using:datetime, " Server $_ is Down" -ForegroundColor Red
	# 	}
	# }
	$DB | ForEach-Object -Parallel {
		$IsSuccess = (tnc $_ -Port 1433).TcpTestSucceeded
		if ($IsSuccess) {
			Write-Host $using:datetime, " Server $_ is Up" -ForegroundColor Green
		}
		else {
			Write-Host $using:datetime, " Server $_ is Down" -ForegroundColor Red
		}
	}

	# $DB | ForEach-Object {
	# 	$IsSuccess = (tnc $_ -Port 1433).TcpTestSucceeded
	# 	if ($IsSuccess) {
	# 		Write-Host $datetime, " Server $_ is Up" -ForegroundColor Green
	# 	}
	# 	else {
	# 		Write-Host $datetime, " Server $_ is Down" -ForegroundColor Red
	# 	}
	# }

	# # 停用網路卡
	# 	Disable-NetAdapter -name "Ethernet0" -Confirm:$false
	# 	Sleep 5
	# # 啟用網路卡
	# 	Enable-NetAdapter -name "Ethernet0" -Confirm:$false
	# 	Sleep 5
	# 	$datetime = Get-Date -UFormat "%Y/%m/%d %A %H:%M:%S"
	# 	if (Test-Connection -IPAddress $IP -Count 1 -ErrorAction SilentlyContinue) {
	# 		Write-Host $datetime, " Server is Up Up Up !!!"
	# 	}
	# 	else {
	# 		Write-Host $datetime, " Server is still Down !!!"
	# 	}
	Start-Sleep 10
}while ($true)