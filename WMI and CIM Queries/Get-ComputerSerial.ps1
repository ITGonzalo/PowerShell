$SerialNumber = Get-WmiObject -ComputerName $ComputerName -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber

$SerialNumber