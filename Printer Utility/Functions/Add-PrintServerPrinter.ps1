<#
.Synopsis
   Install printer driver locally or remotely.
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Add-PrinterServerPrinter
{
    [CmdletBinding()]
    Param
    (
        # Print Server
        [Parameter(Mandatory=$true)]
        [string]$PrintServer,

        # IP Address
        [Parameter(Mandatory=$true)]
        [string]$IPAddress,

        # Driver
        [Parameter(Mandatory=$true)]
        [string]$Driver,

        # Printer Name
        [Parameter(Mandatory=$true)]
        [string]$PrinterName
    )

    Begin
    {
    }
    Process
    {
        Add-Printer -ComputerName $PrintServer -PortName $IPAddress -DriverName $Driver -Shared $true `
        -Name $PrinterName -ShareName $PrinterName -Location $Location -Comment $Comment
    }
    End
    {
    }
}

#Check Port exists before adding printer to server
Write-Host "What is the office symbol?"
$OfficeSymbol = Read-Host

Write-Host "What is the printer function?
Input Printer Function Code: 
Printer Function Code       Printer Function
---------------------       ----------------
ColorLAS 					Color Laser Jet 
ColorINK					Color Ink Jet 
BlackLAS 					Black Laser Jet 
BlackInk 					Black Ink Jet 
MultiColorLAS 				Multi-Function Color Laser Jet 
MultiColorInk 				Multi-Function Color Ink Jet 
MultiBlackLAS 				Multi-Function Black Laser Jet 
MultiBlackINK 				Multi-Function Black Ink Jet 
CopyBlack 					Copy Machine Black Ink 
CopyColor 					Copy Machine Color Ink 
SCAN 						Scanners 
Handheld Entity Type Code 	Handheld Entity Type BlackLAS
PMP 						Portable Media"

$PrinterFunctionCode = Read-Host

Write-Host "What is the building number or name?"
$Building  = Read-Host

Write-Host "What is the room number or name?"
$Room = Read-Host

Write-Host "What is the organization?"
$Organization = Read-Host

Write-Host "What is the IP?"
$IPAddress = Read-Host

Write-Host "Which printer driver needs to be assigned?"
$Driver = Read-Host
# check if it exists on server, if not assign a dummy driver and throw a warning

$Comment = "Building: $Building, Room: $Room, Organization: $Organization"

$PrinterName = "$OfficeSymbol-$PrinterFunctionCode-B$BuildingNumber" + "R$RoomNumber"
