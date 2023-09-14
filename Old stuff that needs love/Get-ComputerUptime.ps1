# Populated by dummy computer names
# Need to improve exporting reports

$Computers = "LON-SVR1", "LON-SVR2", "LON-SVR3"

Foreach ($_ in $Computers) {
    Invoke-Command -ComputerName $_ -ScriptBlock {
        # Get Last Boot Up Time
        $UsableTimeFormat = Get-CimInstance -ComputerName $_ win32_operatingsytem | Select-Object -ExpandProperty LastBootUpTime
        
        # Create timespan object by subtracting the old date from the current date
        $TimeSinceLastBootUp = ((Get-Date) - $UsableTimeFormat)
        
        # Start from the old and end with the new to avoid negative values
        # New-TimeSpan -Start $UsableTimeFormat -End $(Get-Date)

        # The time it's been between dates
        $TimeSinceLastBootUp
    }
}