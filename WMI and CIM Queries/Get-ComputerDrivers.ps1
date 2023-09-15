<#
    Queries wmi for drivers
#>

Get-WmiObject Win32_PnPSignedDriver | 
    Sort-Object DeviceName | 
    Select-Object PSComputerName, DeviceName, @{n="DriverDate"; e={($_.ConvertToDateTime($_.DriverDate)).ToString("MMM-dd-yyyy")}}, DriverVersion