# Description: Delete objects in Active Directory
Remove-ADFineGrainedPasswordPolicy -Identity "PolicyName" -Confirm:$false
# --> Remove a fine-grained password policy
Remove-ADUser -Identity "Username" -Confirm:$false
# --> Remove a user from Active Directory
Remove-ADGroup -Identity "GroupName" -Confirm:$false
# --> Remove a group from Active Directory
Remove-ADOrganizationalUnit -Identity "OU=TestOU,DC=example,DC=com" -Confirm:$false
# --> Remove an Organizational Unit from Active Directory
Remove-ADComputer -Identity "ComputerName" -Confirm:$false
# --> Remove a computer from Active Directory
Remove-ADServiceAccount -Identity "ServiceAccountName" -Confirm:$false
# --> Remove a service account from Active Directory
Remove-ADGroupMember -Identity "GroupName" -Members "Username" -Confirm:$false
# --> Remove a user from a group in Active Directory
Remove-ADPrincipalGroupMembership -Identity "Username" -MemberOf "GroupName" -Confirm:$false
# --> Remove a user from a group in Active Directory
Remove-ADReplicationSite -Identity "SiteName" -Confirm:$false
# --> Remove a replication site from Active Directory
Remove-ADTrust -Identity "TrustName" -Confirm:$false
# --> Remove a trust from Active Directory
Remove-GPO -Name "GPOName" -Confirm:$false
# --> Remove a Group Policy Object
Remove-DnsServerResourceRecord -ZoneName "Domain.com" -RRType "A" -Name "RecordName" -Confirm:$false
# --> Remove a DNS resource record

