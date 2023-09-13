#Under headers, authorization each "bearer" is unique and is limited to 1,000 requests per day, limited 1 request per second.
#Documentation: https://macvendors.com/api
$MACAddress = Get-Content -Path "TEXT DOCUMENT OF MACS TO SEARCH UP"

#Initialized Array to populate results into
$CompiledList = @()

#Authentication headers for API request
#Authorization header is where the API token presented
#API token was issued to a throwaway email, presents no threat hardcording the API token into script
$headers = @{
    'Authorization' = "INSERT API TOKEN"
    'Accept' = 'text/plain'
}

#Look that takes each MAC in the list and puts it through Invoke-RestMethod (API search)
foreach ($_ in $MACAddress) {
    $MACVendorsURI = "https://api.macvendors.com/v1/lookup/$_"
    
    #Tries the MAC
    try {
        $LookUp = Invoke-RestMethod -Uri $MACVendorsURI -Method Get -Headers $headers
        }

    #Catches any errors thrown back if the MAC format is invalid or MAC vendor wasn't found in database
    catch [System.Net.WebException]{
        $LookUp = "Not Found or Invalid MAC format, please check input"
        }
    
    #Populating initialized array
    $CompiledList +=  [pscustomobject]@{
        MAC_Address = $_
        Vendor = $LookUp
        }

    #Precaution to make sure only one API request is done per second
    Start-Sleep -Seconds 1
    }

#Outputs array of resultant objects to desired path
$CompiledList | Export-Csv -Path "INSERT DESIRED PATH\Result.csv" -NoTypeInformation

#Opens created CSV file automatically to QA results
Invoke-Item "INSERT DESIRED PATH\Result.csv"