$ComputerName = "LON-CL1"

# Using Test-Connection
Test-Connection -ComputerName $ComputerName -Count 1

# Using Test-NetConnection
Test-NetConnection -ComputerName $ComputerName

# Using .NET Ping class
$ping = New-Object System.Net.NetworkInformation.Ping
$ping.Send("www.example.com")