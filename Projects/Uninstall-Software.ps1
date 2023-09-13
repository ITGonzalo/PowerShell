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