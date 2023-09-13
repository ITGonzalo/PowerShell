#function Add-BulkUsers {
    <# import info from csv
       assumes the follow:
       headers: firstname, middleinitial, lastname, username, email, streetaddress, 
       city, zipcode, state, countrycode, department, password, telephone, jobtitle, 
       company, ou, maildomain

       figuring out what needs to be set to what was confusing, did my best
    #>

    # creates the account but can't log in
    $FilePath = "Your CSV File Path Here"
    $UsersFromFile = Import-Csv -Path $FilePath
    foreach ($_ in $UsersFromFile) {
        $Parameters = @{
        name = "$($_.firstname) $($_.middleinitial) $($_.lastname)"
        displayname = "$($_.firstname) $($_.middleinitial) $($_.lastname)"
        SamAccountName = $_.username
        accountpassword = (ConvertTo-SecureString $_.password -AsPlainText -Force)
        givenname = $_.firstname
        surname = $_.lastname
        UserPrincipalName = "$($_.username)@$($_.maildomain)"
        emailaddress = $_.email
        streetaddress = $_.streetaddress
        city = $_.city
        postalcode = $_.zipcode
        state = $_.state
        country = $_.countrycode
        department = $_.department
        officephone = $_.telephone
        title = $_.jobtitle
        company = $_.company
        enabled = $true
        path = $_.ou
        }
        New-ADUser @Parameters
    }
#}