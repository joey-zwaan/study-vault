New-ADFineGrainedPasswordPolicy -Name "IT_PasswordPolicy" -Precedence 20 `
-MinPasswordLength 14 -PasswordHistoryCount 15 -MaxPasswordAge 60.00:00:00 `
-MinPasswordAge 1.00:00:00 -LockoutThreshold 5 -LockoutDuration 00:30:00 `
-ReversibleEncryptionEnabled $false -ComplexityEnabled $true
# --> Create a new fine-grained password policy
Add-ADFineGrainedPasswordPolicySubject -Identity "IT_PasswordPolicy" -Subjects "IT-Group"
# --> Add a group to a fine-grained password policy
Get-ADFineGrainedPasswordPolicy -Filter {Name -eq "IT"}
# --> Get a fine-grained password policy