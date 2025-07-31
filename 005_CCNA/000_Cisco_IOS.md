# Inleiding tot Cisco IOS CLI

## Nuttige Commando’s

### MAC-adrestabel

| Commando                              | Beschrijving                                   |
|----------------------------------------|------------------------------------------------|
| `show mac address-table`               | Toont de MAC-adrestabel                        |
| `show mac address-table dynamic`       | Toont alleen dynamische vermeldingen           |
| `show mac address-table static`        | Toont alleen statische vermeldingen            |
| `clear mac address-table`              | Leegt de MAC-adrestabel                        |

### ARP (Address Resolution Protocol)

| Commando                                | Beschrijving                                   |
|------------------------------------------|------------------------------------------------|
| `arp -n`                                | Toont de ARP-tabel (zonder hostnamen)          |
| `arp -a`                                | Toont de ARP-tabel                             |
| `arp -d <ip-adres>`                      | Verwijdert een ARP-vermelding                  |
| `arp -s <ip-adres> <mac-adres>`          | Voegt een statische ARP-vermelding toe         |

## Interfaceconfiguratie

### Inleiding

Commando’s voor het configureren van fysieke en virtuele interfaces op Cisco-apparatuur.

| Commando                                 | Beschrijving                                   |
|-------------------------------------------|------------------------------------------------|
| `interface <interface-naam>`              | Gaat naar interfaceconfiguratiemodus           |
| `no shutdown`                            | Zet de interface aan                           |
| `shutdown`                               | Zet de interface uit                           |
| `description <beschrijving>`              | Voegt een beschrijving toe aan de interface    |

## Basisapparaatbeveiliging

### Inleiding

Raadpleeg voor uitgebreide hardening de officiële Cisco-beveiligingsgidsen. Beveilig minimaal ongebruikte poorten, stel wachtwoorden in en activeer logging.

## Routing

### Configuratie van statische routes

| Commando                                                           | Beschrijving                                     |
|--------------------------------------------------------------------|--------------------------------------------------|
| `ip route <best-net> <masker> <next-hop>`                          | Voegt een statische route toe                    |
| `ip route <best-net> <masker> <exit-interface>`                    | Statische route via een exit-interface           |
| `ip route <best-net> <masker> <next-hop> <admin-afstand>`          | Statische route met administratieve afstand      |
| `ip route <best-net> <masker> <exit-interface> <next-hop>`         | Route met exit-interface én next-hop             |
| `ip route <best-net> <masker> <exit-interface> <next-hop> <admin-afstand>` | Route met exit-interface, next-hop én admin-afstand |

#### Standaardroute

| Commando                                   | Beschrijving                        |
|---------------------------------------------|-------------------------------------|
| `ip route 0.0.0.0 0.0.0.0 <next-hop>`      | Stelt de standaardroute in          |

> **Let op:**  
> De "gateway of last resort" (standaardroute) wordt gebruikt wanneer geen andere routes overeenkomen met het bestemmingsnetwerk.

## VLAN-configuratie

### Inleiding

Dit hoofdstuk geeft de belangrijkste commando’s voor het aanmaken, bekijken en beheren van VLANs op Cisco-switches. De commando’s zijn gegroepeerd per doel.

### VLAN-overzicht

| Commando                                 | Beschrijving                                    |
|-------------------------------------------|-------------------------------------------------|
| `show vlan brief`                        | Overzicht van alle VLANs, namen en toegewezen poorten   |
| `show vlan id <vlan-id>`                  | Details van een specifieke VLAN op ID           |
| `show vlan name <vlan-naam>`              | Details van een specifieke VLAN op naam         |
| `show interfaces switchport`              | Toont modus en VLAN-toewijzing per interface    |
| `show interfaces trunk`                   | Lijst met trunkpoorten en hun toegestane VLANs  |

### VLAN aanmaken en naam toewijzen

| Commando                                 | Beschrijving                                    |
|-------------------------------------------|-------------------------------------------------|
| `vlan <vlan-id> name <vlan-naam>`         | Maakt een VLAN aan en geeft een naam            |

### Access-poortconfiguratie

| Commando                                 | Beschrijving                                    |
|-------------------------------------------|-------------------------------------------------|
| `interface <type> <slot/poort>`           | Gaat naar interfaceconfiguratie                 |
| `switchport mode access`                  | Zet de poort in access-modus                    |
| `switchport access vlan <vlan-id>`        | Wijs de poort toe aan een specifieke VLAN       |

### Trunk-poortconfiguratie

| Commando                                    | Beschrijving                                   |
|----------------------------------------------|------------------------------------------------|
| `interface <type> <slot/poort>`              | Gaat naar interfaceconfiguratie                |
| `switchport mode trunk`                      | Zet de poort in trunk-modus                    |
| `switchport trunk encapsulation dot1q`       | Zet de trunk encapsulatie op 802.1Q            |
| `switchport trunk allowed vlan <vlan-lijst>` | Geeft op welke VLANs over de trunk mogen gaan  |
| `switchport trunk native vlan <vlan-id>`     | Stelt de native (untagged) VLAN voor de trunk in|
| `switchport nonegotiate`                     | Zet DTP-onderhandeling uit op de interface     |



## ROAS (Router-on-a-Stick)

**Router Configuratie**

```cisco
interface g0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0
```

```cisco
interface g0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0
```

```cisco
interface g0/0.30
 encapsulation dot1Q 30
 ip address 192.168.30.1 255.255.255.0
```

**Switch Configuratie**

```cisco
interface g0/1
 switchport trunk encapsulation dot1q
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30
```

**Opmerkingen**

- De router moet **802.1Q** trunking ondersteunen
- Elke VLAN moet zich in een uniek **IP-subnet** bevinden




---


### Intervlan routing met SVI
```cisco
interface Vlan10
no switchport
ip routing
ip address 192.168.10.1 255.255.255.0 
```
Hier gebruiken we geen encapsulation omdat de switch dit automatisch afhandelt.
