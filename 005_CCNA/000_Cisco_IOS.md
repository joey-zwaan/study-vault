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



### Configuring interfaces

interface <interface-name> # Enters interface configuration mode
no shutdown # Enables the interface
shutdown # Disables the interface
description <description> # Adds a description to the interface


## Routing

### Routing static routes

ip route <destination-network> <subnet-mask> <next-hop-ip-address> # Adds a static route
ip route <destination-network> <subnet-mask> <exit-interface> # Adds a static route using an exit interface
ip route <destination-network> <subnet-mask> <next-hop-ip-address> <administrative-distance> # Adds a static route with an administrative distance

ip route <destination-network> <subnet-mask> <exit-interface> <next-hop-ip-address> # Adds a static route with an administrative distance using an exit interface

ip route <destination-network> <subnet-mask> <exit-interface> <next-hop-ip-address> <administrative-distance> # Adds a static route with an administrative distance using an exit interface

Gateway of last resort is used when no other routes match the destination network.

ip route 0.0.0.0 0.0.0.0 <next-hop-ip-address> # Sets the default route