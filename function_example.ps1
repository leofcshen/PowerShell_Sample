 function test-net_port {
    [cmdletbinding()]
    param(
        [parameter(mandatory=$true,Position=1,Helpmessage="Enter the name of a computer to check connectivity to.")]
        [ValidateCount(1,5)]
        [ValidateLength(1,15)]
        [ValidatePattern("SZ[A-Z]{2,3}\d{1,2}$")]  #computerName 必须要满足正则表达式
        [string[]]$computerName,
        [parameter(mandatory=$false)]
        [ValidateSet(80,443,22)]    # port 的值，只能是 80,443 和 22 其中的一个
        [ValidateRange(0, 5)]
        [ValidateScript({$_ -lt 4})]
        [int] $port,
        [switch] $SomeFlag, #呼叫時加上 -SomeFlag 使其為 true
        [parameter(Mandatory=$true)]
        [String]
        [AllowNull()]
        [AllowEmptyString()]
        [AllowEmptyCollection()]
        $Name
    )
    foreach ($computer in $computerName) {
        Write-Verbose "Now testing $computer."
        if ($port -eq "")
        {
            $ping = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue
        } else {
            $ping = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue -Port $port
        }
        if ($ping){
            Write-Output $ping
        } else {
            Write-Verbose "Ping failed on $computer. Check the network connection."
            Write-Output $ping
        }
    }
}
test-net_port