# Introduction to Cisco IOS CLI

This document provides a quick overview of essential Cisco IOS commands, focusing on MAC address tables, ARP, interface configuration, and basic routing.

---

## Useful Commands

### MAC Address Table

| Command                                      | Description                                             |
|-----------------------------------------------|---------------------------------------------------------|
| `show mac address-table`                      | Displays the MAC address table                          |
| `show mac address-table dynamic`              | Shows only dynamic entries in the MAC address table     |
| `show mac address-table static`               | Shows only static entries in the MAC address table      |
| `clear mac address-table`                     | Clears the MAC address table                            |

---

### ARP (Address Resolution Protocol)

| Command                               | Description                           |
|----------------------------------------|---------------------------------------|
| `arp -n`                              | Displays the ARP table (no hostnames) |
| `arp -a`                              | Displays the ARP table                |
| `arp -d <ip-address>`                  | Deletes an ARP entry                  |
| `arp -s <ip-address> <mac-address>`    | Adds a static ARP entry               |

---

## Interface Configuration

| Command                              | Description                               |
|---------------------------------------|-------------------------------------------|
| `interface <interface-name>`          | Enters interface configuration mode       |
| `no shutdown`                        | Enables the interface                     |
| `shutdown`                           | Disables the interface                    |
| `description <description>`           | Adds a description to the interface       |

---

## Basic Device Security

> _Tip: For detailed security hardening, refer to Cisco’s official guides. Start by securing unused ports, setting passwords, and enabling logging._

---

## Routing

### Static Route Configuration

| Command                                                                                         | Description                                           |
|--------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| `ip route <dest-net> <mask> <next-hop>`                                                         | Adds a static route                                   |
| `ip route <dest-net> <mask> <exit-interface>`                                                   | Adds a static route using an exit interface           |
| `ip route <dest-net> <mask> <next-hop> <admin-distance>`                                        | Adds a static route with an admin distance            |
| `ip route <dest-net> <mask> <exit-interface> <next-hop>`                                        | Adds a static route with both exit int. & next hop    |
| `ip route <dest-net> <mask> <exit-interface> <next-hop> <admin-distance>`                       | Adds a static route with both exit int. & admin dist. |

#### Default Route

| Command                                 | Description                  |
|------------------------------------------|------------------------------|
| `ip route 0.0.0.0 0.0.0.0 <next-hop>`   | Sets the default route       |

> **Note:**  
> The "gateway of last resort" (default route) is used when no other routes match the destination network.

---

## Summary

- Use `show` commands to verify MAC and ARP tables.
- Configure interfaces with `interface`, `shutdown`/`no shutdown`, and descriptions.
- Add static routes using the `ip route` command in its various forms.
- Always set a default route for internet connectivity.

---
