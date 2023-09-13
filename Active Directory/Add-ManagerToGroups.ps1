$Manager = "Insert Manager Identifier here"
$GroupList = Get-Content "Group DistingushedName List.txt"

Foreach ($_ in $GroupList) {
    Set-ADGroup -Identity $_ -ManagedBy $Manager
}