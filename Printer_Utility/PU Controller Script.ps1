#Re-write script with use of functions (repetitive commands and stuff)
<#  Make this a controller script that calls the following functions:
    Add-PrintServerPrinter
    2* Copy-ConfiguredPrinter --> Export?
    Get-PrintServerDrivers
    Get-PrintServerPorts
    Get-PrintServerPrinters
    Install-PrinterDriver
    Uninstall-PrinterDriver?
    Remove-PrintServerDriver
    Remove-PrintServerPort
    Remove-PrintServerPrinter
    Rename-PrintServerPrinter
    Repair-PrintServerPrinter
    Test-PrintServerPort
    Update-PrintServerPrinterPort

    Notes:
    If already done add these functionalities:
    - Validate OfficeName-Functionality-BuildingNumberRoomNumberorRoomName

#>
$Script:PrintServer = Read-Host -Prompt "Input Print Server Name"

do {
    switch ($option = Read-Host -prompt `
    "Printer Utility Script Menu:
    [ 1] Add-PrintServerPort
    [ 2] Add-PrintServerPrinter
    [ 3] Get-PrintServerDrivers
    [ 4] Get-PrintServerPorts
    [ 5] Get-PrintServerPrinters
    [ 6] Install-PrintDriver
    [ 7] Remove-PrintServerDriver
    [ 8] Remove-PrintServerPort 
    [ 9] Remove-PrintServerPrinter
    [10] Rename-PrintServerPrinter
    [11] Repair-PrintServerPrinter
    [12] Test-PrintServerDriver 
    [13] Test-PrintServerPort 
    [14] Test-PrintServerPrinterName
    [15] Update-PrintServerPrinterName
    [16] Update-PrintServerPrinterDriver
    [17] Update-PrintServerPrinterPort
    [ C] Clear console
    [ Q] Quit

    Input Selection") {
    1 {
        Write-Host "`n"
    }

    2 {
        Write-Host "`n"
    }

    3 {
        Write-Host "`n"
    }

    4 {
        Write-Host "`n"
    }

    5 {
        Write-Host "`n"
    }

    6 {
        Write-Host "`n"
    }

    7 {
        Write-Host "`n"
    }

    8 {
        Write-Host "`n"
    }

    9 {
        Write-Host "`n"
    }

    10 {
        Write-Host "`n"
    }

    11 {
        Write-Host "`n"
    }

    12 {
        Write-Host "`n"
    }

    13 {
        Write-Host "`n"
    }

    14 {
        Write-Host "`n"
    }

    15 {
        Write-Host "`n"
    }
    
    Q {
        Exit
    }

    C {
        Clear-Host
    }

    default {
        Write-Host "That is not an option try again."
    }
    }
}
while ($option -ne "Q")