#region -- 呼叫運算子 & --
function Show-Value ($value) { Write-Host $value }

$aa = "Show-Value"
&$aa aa

# 下列寫法會報錯，呼叫運算子不能解釋引數
$bb = "Show-Value bb"
&$bb
#endregion

#region -- Invoke-Expression 將字串轉成指令執行 --
# Invoke-Expression 可以解釋引數
function Myfunctionname { Write-Host "$($args[0]) $($args[1])" }

# 透過字串
Invoke-Expression "MyFunctionName scripts test"

# 透過變數
$FunctionToInvoke = "MyFunctionName";
$arg1 = "scripts"
$arg2 = "test"
Invoke-Expression  "$FunctionToInvoke $arg1 $arg2"
#endregion