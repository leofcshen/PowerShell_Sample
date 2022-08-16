# PowerShell 7 開始才有 parallel

$Array=1..15

Measure-Command{
  $Array | ForEach-Object {
    Write-Output "I'm:$_"
    Start-Sleep -Seconds 1
  }
}

Measure-Command{
  $Array | ForEach-Object -parallel{
    Write-Output "I'm:$_"
    Start-Sleep -Seconds 1
  }
}

$Array | ForEach-Object {
  Write-Output "I'm:$_"
  Start-Sleep -Seconds 1
}

$Array | ForEach-Object -ThrottleLimit 3 -Parallel {
  Write-Output "Entering $_"
  Start-Sleep -Seconds 1
  Write-Output "Exiting $_"
}

function SayHello{
  Write-Output "Hello"
}
$funcDef=$function:SayHello.ToString()

$Array=1..5

$Array | ForEach-Object -Parallel{
  $function:SayHello=$using:funcDef
  SayHello
}
