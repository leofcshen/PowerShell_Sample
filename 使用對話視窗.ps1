$wsh = New-Object -ComObject WScript.Shell
$wsh.Popup($_.Exception, 0, "發生錯誤", 0 + 48)