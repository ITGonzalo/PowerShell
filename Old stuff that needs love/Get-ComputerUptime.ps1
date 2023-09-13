# Populated by dummy computer names
# Need to improve exporting reports

$Computers = "LON-SVR1", "LON-SVR2", "LON-SVR3"

Foreach ($_ in $Computers) {
    Invoke-Command -ComputerName $_ -ScriptBlock {
        $UsableTimeFormat = Get-CimInstance -ComputerName $_ win32_operatingsytem | Select-Object -ExpandProperty LastBootUpTimee
        Write-Output "$env:COMPUTERNAME $UsableTimeFormat"
    }
}