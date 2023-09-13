# Still a work in progress
# need a live environment to test things out or build a test one from the ground up
# Maybe replace subnet masks with CIDR notation using calculated properties for fun

$DHCPServer = "DHCP Server"

$AllDHCPScopes = Get-DHCPServerV4Scope -ComputerName $DHCPServer 

$Scopes = $AllDHCPScopes | 
    Select-Object ScopeId, Name, State, SubnetMask | 
    Format-Table

$Leases = $AllDHCPScopes | ForEach-Object {
    Get-DHCPServerv4Lease -ComputerName $DHCPServer -ScopeID $_.ScopeID | 
    Select-Object ScopeId, IPAddress, HostName, ClientID, AddressState | 
    Format-Table
    }

$Reservations = $Leases | 
    Where-Object {$_.AddressState -like '*Reservation'} | 
    Format-Table

# Try to create a non-gross way to display these nicely eventually
$Scopes
$Leases
$Reservations