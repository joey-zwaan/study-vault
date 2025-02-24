# First install AD-Domain services
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
# Installatie forest
Install-ADDSForest -DomainName "nswb.test" -InstallDNS