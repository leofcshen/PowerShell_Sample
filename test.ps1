function A {
	Param($functionToCall)
	Write-Host "I'm calling : $functionToCall"

	#access the function-object like this.. Ex. get the value of the StartPosition property
    (Get-Item "function:$functionToCall").ScriptBlock.StartPosition

}

function B {
	Write-Host "Function B"
}

Function C {
	write-host "Function C"
}

a -functionToCall c
https://stackoverflow.com/questions/22129621/pass-function-as-a-parameter