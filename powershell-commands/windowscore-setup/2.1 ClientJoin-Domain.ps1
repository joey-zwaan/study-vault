# Check adapter information
Get-NetIPInterface

Set-DnsClientServerAddress -InterfaceIndex 13 -ServerAddresses ("192.168.153.200")
# Join domain
Add-Computer -DomainName nswb.test -restart

# Check network connectivity to the domain controller
Test-Connection -ComputerName "dc01.nswb.test"

# Join domain and specify the OU
Add-Computer -DomainName "nswb.test" -OUPath "OU=Computers,DC=nswb,DC=test" -Restart

# Verify domain join status
(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain