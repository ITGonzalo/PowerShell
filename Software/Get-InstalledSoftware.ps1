# Through the registry
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate


# Using WMI Queries
Get-WmiObject -Class Win32_Product | Select-Object Name, Version, Vendor, InstallDate

# Using CIM Instances
Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version, Vendor, InstallDate

# Using Get-Package
Get-Package | Select-Object Name, Version, ProviderName, Source