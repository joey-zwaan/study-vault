Introduction to Cisco IOS CLI
## Useful commands

### MAC Address Table

show mac address-table # Displays the MAC address table
show mac address-table dynamic # Displays only dynamic entries in the MAC$
mac address-table static # Displays only static entries in the MAC address table
clear mac-address-table # Clears the MAC address table 
### ARP

arp -n # Displays the ARP table without resolving hostnames
arp -a # Displays the ARP table
arp -d <ip-address> # Deletes an ARP entry
arp -s <ip-address> <mac-address> # Adds a static ARP entry

## Basic device security