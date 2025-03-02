# First install AD-Domain services
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
# Installatie forest
Install-ADDSForest -DomainName "nswb.test" -InstallDNSµù
# Toevoegen 2e dc aan domain
Install-ADDSDomainController -InstallDns -DomainName nswb.test -Credential joey-admin
# Rename Domain Controller
Rename-Computer -NewName "DC01" -DomainCredential (Get-Credential) -Restart
