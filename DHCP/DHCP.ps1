# Still a work in progress
# need a live environment to test things out or build a test one from the ground up

# Maybe replace subnet masks with CIDR notation

$DHCPServer = ""

$Scopes = Get-DHCPServerV4Scope -ComputerName "$DHCPServer" | 
    Select-Object ScopeId, Name, State, SubnetMask 

$Leases = Get-DHCPServerV4Scope -ComputerName "$DHCPServer" | ForEach-Object {
    Get-DHCPServerv4Lease -ComputerName "$DHCPServer" -ScopeID $_.ScopeID | 
    Select-Object ScopeId, IPAddress, HostName, ClientID, AddressState
    } | Out-GridView

# Try to create a non-gross way to display these nicely eventually
$Scopes
$Leases