$SerialNumber = Get-WmiObject -ComputerName $ComputerName -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

# CIM approach:
# Get-CimInstance -ClassName Win32_BIOS | Select-Object -ExpandProperty SerialNumber

$SerialNumber