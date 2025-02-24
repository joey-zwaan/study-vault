# Rename the computer and restart it
Rename-Computer -NewName "Server01" -Restart

# Rename the computer and specify the local credentials
Rename-Computer -NewName "Server02" -LocalCredential (Get-Credential) -Restart

# Rename the computer and specify the domain credentials
Rename-Computer -NewName "Server03" -DomainCredential (Get-Credential) -Restart

# Rename the computer without restarting
Rename-Computer -NewName "Server04"

# Rename the computer and force the operation without c
