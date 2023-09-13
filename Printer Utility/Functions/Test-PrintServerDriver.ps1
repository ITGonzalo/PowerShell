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
function Test-PrintServerDriver
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$Driver
    )

    Begin
    {
    }
    Process
    {
        try {
            Write-Host "Driver: $Driver, exists on the print server."
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