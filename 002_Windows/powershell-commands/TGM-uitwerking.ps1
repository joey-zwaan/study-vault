# Inschakelen van de Time-based Group Membership feature
Enable-AdOptionalFeature -Identity 'Privileged Access Management Feature' -Scope ForestOrConfigurationSet -Target 'localtest.test' 

# Controleren Forest Function Level
(Get-ADForest).ForestMode

# Toevoegen gebruiker aan Domain Admins voor 60 min
Add-AdgroupMember -Identity "Domain Admins" -Members "TGM-users" 
-MemberTimeToLive (New-TimeSpan -Minutes 60)

# Controleren van de TTL van deze gebruiker
Get-Adgroup 'Domain Admins' -properties member -ShowMemberTimeToLive