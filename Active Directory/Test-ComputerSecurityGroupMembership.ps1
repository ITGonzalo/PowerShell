# Very rough, just conceptual, it did work but it can probably be done better

$Computers = Get-Content -Path "Computers.txt"
# Distinguished Name of Security Group
$SecurityGroup = "Insert Security Group's DN here"

foreach ($_ in $Computers) {
    $CustomObjResults += @(
    [pscustomobject]@{Computer_Name = $_; Has_SECURITY_GROUP = ((Get-ADComputer $_ -Properties Memberof | Select-Object Memberof).memberof).contains($SecurityGroup)}
)}

$CustomObjResults | Out-GridView