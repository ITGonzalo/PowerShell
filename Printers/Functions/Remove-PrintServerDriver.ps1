<#
.Synopsis
   Removes Print Server Driver from list and driver store.
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Remove-PrintServerDriver
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
            Remove-PrinterDriver -ComputerName $Script:PrintServer -Name $Driver -ErrorAction Stop -RemoveFromDriverStore -Verbose
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