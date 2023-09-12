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
function Test-PrintServerPort
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$PrinterPort
    )

    Begin
    {
    }
    Process
    {
        try {
            Write-Host "Printer port: $PrinterPort, exists on the print server."
        }

        catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException]{
            Write-Host "Did not find printer port: $PrinterPort, please be more precise."
        }

        catch [Microsoft.Management.Infrastructure.CimException]{
            Write-Host "Check the print server name variable in the .psm1 file, something isn't right."
        }
    }
    End
    {
    }
}