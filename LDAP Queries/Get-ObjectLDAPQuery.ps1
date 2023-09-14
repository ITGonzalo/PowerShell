<# 
    Need to generalize script to make it applicable to other environments
#>

# loads all attributes for acounts

$samaccountname = Read-Host -Prompt "Enter samaccountname of object"

$results = ([adsisearcher]"(&(ObjectCategory=Person)(ObjectClass=User)(samaccountname=$samaccountname*))").FindAll()
# $results = ([adsisearcher]"(&(objectCategory=computer)(objectClass=computer))").FindAll()

if ($results.Count -eq 0) {
    Write-Output "Check your input again, couldn't find anything"
}

# only one result
elseif ($results.count -eq 1) {
    $Attributes = @{
        #Insert attributes you want in this splat
    }
}

# more than one result, choose one
# find out how to make user choose

elseif ($results.Count -gt 1) {
    #choose one
    $tmpVar = 0
    foreach($_ in $results) {
        $output += @(
        [pscustomobject]@{Result_Number = $tmpVar ; Display_Name = $_.properties.displayname ; sAMAccountName = $_.properties.samaccountname
        })
        $tmpVar++
    }
    $output | Select-Object Result_number, @{n='Display_Name'; e={$_.display_name}}, @{n='sAMAccountname';e={$_.samaccountname}} | Out-GridView


    do {
        $choice = Read-Host -Prompt "Choose the result number corresponding to the account you want"

    }
    while (($choice -is [int]) -and ($choice -ge 0) -and ($choice -le $tmpVar))

    # Output useful info
    ($Results[$choice]).Properties
}

Remove-Variable -Name * -ErrorAction SilentlyContinue