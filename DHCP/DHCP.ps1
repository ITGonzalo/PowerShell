# Maybe replace subnet masks with CIDR notation

$DHCPServer = ""

$Scopes = Get-DHCPServerV4Scope -ComputerName "$DHCPServer" | 
    Select-Object ScopeId, Name, State, SubnetMask 

$Leases = Get-DHCPServerV4Scope -ComputerName "$DHCPServer" | ForEach {
    Get-DHCPServerv4Lease -ComputerName "$DHCPServer" -ScopeID $_.ScopeID | 
    Select-Object ScopeId, IPAddress, HostName, ClientID, AddressState
    } | Out-GridView