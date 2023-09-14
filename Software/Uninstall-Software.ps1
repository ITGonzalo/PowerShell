## Still a work in progress ##

## If you want a different software to be uninstalled, find the uninstall string

$Computers = Get-Content "$PSScriptRoot\Computers.txt"
    foreach ($_ in $Computers) {

    # path entirely depends on where the program is installed at #
    # best bet is to make a csv with all the research goodies and pull from there #
    if (Test-Path "\\$_\c`$\Program Files (x86)\Software\") {
        Invoke-Command -ComputerName $_ -ScriptBlock { 
            # This is highly dependent needs more research #
            Start-Process -FilePath "Uninstall string that points to an executable" -ArgumentList "/SILENT" -PassThru -Wait -Verbose
            }
        }
    }

# Software uses different approaches for installation so requires research
# If you do not have access to your network's software management system try these methods
# Assuming you have elevated privileges and necessary permissions

# Use case: Windows Package installation, find out through Get-Package
Uninstall-Package -Name "PackageName"

# Use case: If software has an uninstall string defined in the registry
$uninstallString = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PackageName").UninstallString
Start-Process cmd -ArgumentList "/c $uninstallString"

# Use case: When the software was installed using Windows Installer and have the GUID product code
Start-Process -FilePath "msiexec.exe" -ArgumentList "/x {ProductCode} /quiet"

# Use case: When software comes with its own uninstaller executable.
Start-Process -FilePath "C:\Path\To\Uninstaller.exe" -ArgumentList "/silent"