# Very situational but log off users on servers/computers if limited to X sessions
$ServerName = Read-Host -Prompt "Please type in the computer or server name"
#check if it's correct input

Write-Host "Choose an option to execute on $ServerName
[1] Query User Sessions (USERNAME | SESSIONAME | ID | STATE| IDLE TIME| LOGON TIME)
[2] Logoff User Sessions (Single/Multiple)
"

switch ($option = read-host) {

    1 {
        $Results = quser /server:$ServerName
        Write-Output $Results
    }

    2 {
        $SessionID = Read-Host -Prompt "Type in Session ID to logoff, multiple separate by a comma"
        $SessionID = $SessionID.Split(',').Trim()
        foreach ($_ in $SessionID) {
            logoff $_ /server:$ServerName
            }
        $Results = quser /server:$ServerName
        Write-Output $Results
    }


    default {
        Write-Host "Invalid Option" -ForegroundColor Red
    
    }

}