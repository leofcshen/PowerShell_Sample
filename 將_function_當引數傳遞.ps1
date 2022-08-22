# 參考資料
#		https://stackoverflow.com/questions/22129621/pass-function-as-a-parameter

function A {
	Param([scriptblock]$FunctionToCall, $word)
	Write-Host "I'm calling $($FunctionToCall.Invoke($word))"
}

function B($x) {
	Write-Output "Function B with $x"
}

Function C {
	Param($x)
	Write-Output "Function C with $x"
}

A -FunctionToCall $function:B bbb
A -FunctionToCall $function:C ccc
A -FunctionToCall { Param($x) "MyScript show $x" } ddd

# function A {
# 	Param($functionToCall)
# 	Write-Host "I'm calling : $functionToCall"

# 	#access the function-object like this.. Ex. get the value of the StartPosition property
# 	(Get-Item "function:$functionToCall").ScriptBlock.StartPosition
# }

# function B {
# 	Write-Host "Function B"
# }

# Function C {
# 	write-host "Function C"
# }

# a -functionToCall c