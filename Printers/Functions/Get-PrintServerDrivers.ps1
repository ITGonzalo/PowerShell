<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-PrintServerDrivers
{
    Begin
    {
    }
    Process
    {
        try {
            Get-PrinterDriver -ComputerName $env:COMPUTERNAME -ErrorAction Stop |
               Select-Object ComputerName, Name, Manufacturer, InfPath, DependentFiles |
               Format-Table
        }

        catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException]{
            Write-Host "Did not find Driver: $Driver, please be more precise."
        }

        catch [Microsoft.Management.Infrastructure.CimException]{
            Write-Host "Check the print server name variable in the .psm1 file, something isn't right."
        }
    }
    End
    {
    }
}