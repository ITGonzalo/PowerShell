<# Fun facts about account statuses:
   Expired accounts -> Predetermined via “Account Expiration Date” , can modify to test below commands
   Locked accounts  -> Lock outs occur because of exceeded password attempt threshold per GPO configuration
   Disable accounts -> Done by an admin manually or through commands/scripts #>

Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Rate = 2
$speak.Speak("
   Fun facts about account statuses.
   Expired accounts are determined via the Account Expiration Date attribute, you can modify it to test it.
   Locked accounts occur when the threshold for password attempts are exceeded which depends on GPO configuration.
   Disabled accounts occur when an admin manually disables it through the GUI, commands, or scripts.
   ")

# Enumerate Expired Accounts
Search-ADAccount -AccountExpired -UsersOnly

# Enumerate user accounts expired within last 24-hour period
Search-ADAccount -AccountExpired -UsersOnly | 
    Where-Object {$_.AccountExpirationDate -gt (Get-Date).AddHours(-24)}

# Locate and unlock specific user account
# Locked accounts occur when users exceed password attempts in GPO Account Lockout policy
$LockedOutAccounts = Search-ADAccount -LockedOut -UsersOnly | Select-Object LockedOut, DistinguishedName, sAMAccountName 
$LockedOutAccounts | Format-Table
$Choice = Read-Host -Prompt "Please type in the sAMAccountName or DistinguishedName of the account you want to unlock"

# Retrieve all locked accounts
Search-ADAccount -LockedOut

<# Disable user accounts that have that have not been used to logon with in 30 or more days
   this includes accounts that have never logged in before as their “LastLogOnTimeStamp” is $null
   LastLogOnTimeStamp isn’t too accurate, requires DCs to replicate that info.
   LastLogOn isn’t replicated through each DC thus requires more complex scripting. #>
Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 30

# Move disabled users into a specific OU
$OUContainer = Read-Host -Prompt "Where do you want to move disabled users to?"
Search-ADAccount -AccountDisabled -UsersOnly | Move-ADObject -TargetPath $OUContainer

# Add Users into Groups
$Group = "group placeholder"
$Members = "members placeholder"
Add-ADGroupMember -Identity $Group -Members $Members

# Create OUs
$Name = "name placeholder"
$ContainerPath = "container path placeholder"
New-ADOrganizationalUnit -Name $Name -Path $ContainerPath

# Create Groups
# Specify SamAccountName if Name parameter is over 20 characters long.
$Parameters = @{
   Name = "name placeholder"
   GroupCategory = "group category placeholder"
   GroupScope = "groupscope placeholder"
   DisplayName = "displayname placeholder"
   ContainerPath = "container path placeholder"
   Description = "description placeholder"
}
New-ADGroup @Parameters

# Create list of computers with particular operating system installed
# Examples: Windows Server 2019 Datacenter Evaluation, Windows 10 Enterprise
$OperatingSystem = "Windows Server 2019 Datacenter Evaluation" 
Get-ADComputer -Properties OperatingSystem -Filter {OperatingSystem -eq $OperatingSystem}

<# Create list of computers that have not logged onto the network within 30 days
   This includes accounts that have never logged in before as their “LastLogOnTimeStamp” is $null
   LastLogOnTimeStamp isn’t too accurate, requires DCs to replicate that info.
   LastLogOn isn’t replicated through each DC thus requires more complex scripting. #>
Search-ADAccount -ComputersOnly -AccountInactive -TimeSpan 30

# Remote restart computer
Restart-Computer -ComputerName $Computer -Force

# Retrieve a list of printers installed on computer
Get-Printer # Add -ComputerName parameter to specify a remote computer

# Stop and start services on remote host
# Can also use -DisplayName $DisplayName instead
Invoke-Command -ComputerName $Computer {Start-Service -Name $Name} 
Invoke-Command -ComputerName $Computer {Stop-Service -Name $Name}

# Remove Disabled Users from all Security Groups except Domain Users
# Since most user accounts in a domain’s primary group is “Domain Users” they will not be removed from it unless it has another primary group assigned.
$DisabledUsers = Search-ADAccount -AccountDisabled -UsersOnly
foreach ($User in $DisabledUsers) {
    $Groups = (Get-ADUser -Identity $User.SamAccountName -Properties MemberOf).MemberOf
    foreach ($Group in $Groups) {
        Remove-ADGroupMember -Identity $Group -Members $User
    }
}

