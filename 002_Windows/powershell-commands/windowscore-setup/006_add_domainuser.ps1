# AD user toevoegen
New-Aduser -Name "ZJLocal.test\joey-admin" -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Enabled $true 

# AD user aan domain admin toevoegen
Add-ADGroupMember -Identity "Domain Admins" -Members "joey-admin"

# Default admin account uitschakelen
Disable-ADAccount -Identity "Administrator"

# meest gebruikte commands
# Get-ADUser
Get-ADUser -Filter * -SearchBase "OU=Users,DC=ZJLocal,DC=test"


# New-ADUser
# Set-ADUser
# Remove-ADUser
# Enable-ADUser
# Disable-ADUser
# Unlock-ADAccount
# Set-ADAccountPassword
# Get-ADGroupMember
# Add-ADGroupMember
# Remove-ADGroupMember
# New-ADGroup
# Set-ADGroup
# Remove-ADGroup
# Get-ADGroupMember

# Get-ADGroup
# Get-ADComputer
# Get-ADOrganizationalUnit
# Get-ADDomain
# Get-ADDomainController
# Get-ADForest
# Get-ADObject
# Get-ADRootDSE
# Get-ADServiceAccount
