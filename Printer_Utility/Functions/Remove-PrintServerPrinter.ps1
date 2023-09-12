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
function Remove-PrintServerPrinter
{
   [CmdletBinding()]
   Param
   (
       # Param1 help description
       [Parameter(Mandatory=$true)]
       [string]$PrinterName
   )

   Begin
   {
   }
   Process
   {
       try {
           Remove-Printer -ComputerName $env:COMPUTERNAME -Name $PrinterName -Verbose -ErrorAction Stop
       }

       catch [Microsoft.PowerShell.Cmdletization.Cim.CimJobException]{
           Write-Host "Did not find printer: $PrinterName, please be more precise."
       }

       catch [Microsoft.Management.Infrastructure.CimException]{
           Write-Host "Check the print server name variable in the .psm1 file, something isn't right."
       }
   }
 
   End
   {
   }
}