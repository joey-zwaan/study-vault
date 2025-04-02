Get-Verb
# --> List of verbs that can be used in powershell
# --> powershell uses a verb-noun pair to name cmdlets
Get-Verb | Measure-Object
# --> Use of a pipe to carry over the output of one command to another command
Get-Command
# --> List of all the commands available in powershell
Get-command -Name *a
# --> Gives all the commands that end with a
Get-command -Name a*    
# --> Gives all the commands that start with a
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
# --> Get all the Organizational Units in the Active Directory
Get-ADOrganizationalUnit -Filter * -SearchBase "DC=example,DC=com" | 
    Sort-Object DistinguishedName | 
    ForEach-Object { $_.DistinguishedName -replace "^CN=|^OU=", "" } | 
    Format-Table -AutoSize
# --> Get all the Organizational Units in the Active Directory and format the output
Get-ADGroup
# --> Get all the groups in the Active Directory
Get-ADGroup -Filter * | Select-Object Name, DistinguishedName
# --> Get all the groups in the Active Directory

Get-ADRootDSE
# --> Get the root of the Active Directory
Get-ADRootDSE | Select-Object dnsHostName, namingcontext
Get-ADRootDSE -Server dc1.zjlocal.test
# --> Get the root of the Active Directory on a specific server

# Get the distinguished name and oter attributes of user accounts       
Get-ADUser -Filter * | Select-Object Name, DistinguishedName, SamAccountName, UserPrincipalName