# 下列指令可列出 ReadKey 可用的參數
[enum]::getnames([System.Management.Automation.Host.ReadKeyOptions])
# AllowCtrlC     允許 Ctrl + C 做為按鍵事件，而不是跳離事件
# NoEcho         不顯示輸入的按鍵
# IncludeKeyDown KeyDown 跟 KeyUp 必需至少選一個
# IncludeKeyUp

$key = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyUp")
$key

Write-Host "按鍵 $($key.Character)"
Pause