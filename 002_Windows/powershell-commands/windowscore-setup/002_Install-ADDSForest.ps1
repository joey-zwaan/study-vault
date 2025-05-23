# First install AD-Domain services
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
# Installatie forest
Install-ADDSForest -DomainName "nswb.test" -InstallDNS
# Toevoegen 2e dc aan domain
Install-ADDSDomainController -InstallDns -DomainName nswb.test -Credential (Get-Credential) joey-admin
# Rename Domain Controller
Rename-Computer -NewName "DC01" -DomainCredential (Get-Credential) -Restart
