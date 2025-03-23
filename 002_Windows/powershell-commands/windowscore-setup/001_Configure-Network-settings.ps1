# Get network adapter properties
Get-NetAdapter

# Get detailed information about all network interfaces
Get-NetIPInterface

# Set a static IP address on the network interface with index 5
New-NetIPAddress -InterfaceIndex 5 -IPAddress 192.168.153.100 -PrefixLength 24 -DefaultGateway 192.168.153.1

# Disable DHCP on the network interface with index 5
Set-NetIPInterface -InterfaceIndex 5 -Dhcp Disabled

# Disable a network adapter
Disable-NetAdapter -Name "Ethernet" -Confirm:$false

# Remove any existing IP address configuration on the network interface with index 5
Remove-NetIPAddress -InterfaceIndex 5 -Confirm:$false

# Set the DNS server address on the network interface with index 5
Set-DnsClientServerAddress -InterfaceIndex 5 -ServerAddresses ("127.0.0.1, 1.1.1.1")

# Remove a specific IP address from any network interface
Remove-NetIPAddress -IPAddress 192.168.1.100 -Confirm:$false

# Enable a network adapter
Enable-NetAdapter -Name "Ethernet"

# Rename a network adapter
Rename-NetAdapter -Name "Ethernet" -NewName "Local Area Connection"

# Set the network category to Private
Set-NetConnectionProfile -InterfaceAlias "Ethernet" -NetworkCategory Private

# Get detailed IP configuration information
Get-NetIPAddress

# Enable DHCP on a network interface
Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp Enabled