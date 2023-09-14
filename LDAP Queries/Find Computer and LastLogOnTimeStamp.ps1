<#
    Uses LDAP query to find computers from a list and the LastLogOnTimeStamp attribute
    LDAP queries are generally faster than cmdlets if you are dealing with lots of objects
    ^ Atleast through what I've seen
#>

# Specify the input file path
$computersFile = "$PSScriptRoot\computers.txt"

# Specify the output file path
$csvPath = "$PSScriptRoot\output.csv"

# Read the computer names from the input file
$computerNames = Get-Content $computersFile

# Create an array to store the results
$results = @()

# Iterate through each computer name
foreach ($computerName in $computerNames) {
    # Create a new [adsisearcher] object to search for the specific computer object
    $searcher = [adsisearcher]"(&(objectCategory=computer)(objectClass=computer)(name=$computerName))"

    # Specify the properties to retrieve
    $searcher.PropertiesToLoad.AddRange(@("name", "lastLogonTimeStamp"))

    # Execute the search
    $computer = $searcher.FindOne()

    # Check if the computer object exists
    if ($computer) {
        # Get the computer's name and last logon timestamp
        $computerName = $computer.Properties["name"][0]
        $lastLogonTimestamp = [datetime]::FromFileTime($computer.Properties["lastLogonTimeStamp"][0])

        # Add the computer's information to the results array
        $result = [PSCustomObject]@{
            ComputerName    = $computerName
            LastLogonDate   = $lastLogonTimestamp
        }
        $results += $result
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path $csvPath -NoTypeInformation