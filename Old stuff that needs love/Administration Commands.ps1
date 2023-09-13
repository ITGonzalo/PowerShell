# Add more stuff that creates objects leveraging .NET framework

# Voice spitting facts 
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Rate = 2
$speak.Speak("
   Fun facts about account statuses.
   Expired accounts are determined via the Account Expiration Date attribute, you can modify it to test it.
   Locked accounts occur when the threshold for password attempts are exceeded which depends on GPO configuration.
   Disabled accounts occur when an admin manually disables it through the GUI, commands, or scripts.
   ")

# Remote restart computer
Restart-Computer -ComputerName $Computer -Force

# Retrieve a list of printers installed on computer
Get-Printer # Add -ComputerName parameter to specify a remote computer

# Stop and start services on remote host
# Can also use -DisplayName $DisplayName instead
Invoke-Command -ComputerName $Computer {Start-Service -Name $Name} 
Invoke-Command -ComputerName $Computer {Stop-Service -Name $Name}

# Retrieve network Adapter properties for remote computers
Invoke-Command -ComputerName {Get-NetAdapter}

### Old CMD commands that can be done with PowerShell ###
<# nslookup -> Resolve-DNS name
   ping -> Test-Connection/Test-NetConnection
   ipconfig -> 

#>

# Get MAC of IP
Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'"  | Select-Object -ExpandProperty MACAddress

#### STILL TESTING/NOT WORKING ###

# Release all DHCP leases?
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true and DHCPEnabled=true” | 
   Where-Object -FilterScript {$_.DHCPServer -contains "$DHCPServerIP"} | 
   ForEach-Object -Process {$_.InvokeMethod("ReleaseDHCPLease",$null)}

# Renew all DHCP leases?
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true and DHCPEnabled=true” | 
   Where-Object -FilterScript {$_.DHCPServer -contains "$DHCPServerIP"} | 
   ForEach-Object -Process {$_.InvokeMethod("ReleaseDHCPLease",$null)}