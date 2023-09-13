# Still a work in progress
# need a live environment to test things out or build a test one from the ground up

# Maybe replace subnet masks with CIDR notation

$DHCPServer = "DHCP Server"

$AllDHCPScopes = Get-DHCPServerV4Scope -ComputerName $DHCPServer 

$Scopes = $AllDHCPScopes | Select-Object ScopeId, Name, State, SubnetMask

$Leases = $AllDHCPScopes | ForEach-Object {
    Get-DHCPServerv4Lease -ComputerName $DHCPServer -ScopeID $_.ScopeID | 
    Select-Object ScopeId, IPAddress, HostName, ClientID, AddressState
    } | Out-GridView

$Reservations = $AllDHCPScopes | 
    ForEach-Object {
        Get-DHCPServerv4Lease -ScopeID $_.ScopeID | 
        Where-Object {$_.AddressState -like '*Reservation'} | 
        Select-Object ScopeId, IPAddress, HostName, @{n="MACAddress"; e={$_.ClientID}}, AddressState, LeaseExpiryTime |
        Format-Table
    }

# Try to create a non-gross way to display these nicely eventually
$Scopes
$Leases
$Reservations