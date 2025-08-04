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


### Spanning Tree Protocol (RSTP)

| Commando                                 | Beschrijving                                              |
|-------------------------------------------|----------------------------------------------------------|
| `show spanning-tree`                      | Toont algemene STP/RSTP-status en -topologie             |
| `show spanning-tree vlan <vlan-id>`       | Toont STP/RSTP-informatie specifiek voor een VLAN        |
| `show spanning-tree interface <if>`       | Laat de STP/RSTP-status van een specifieke interface zien|
| `show spanning-tree detail`               | Meer gedetailleerde info over STP/RSTP-topologie         |
| `show spanning-tree summary`              | Samenvatting van de STP/RSTP-instanties                  |
| `show spanning-tree root`                 | Overzicht van root bridge per VLAN                       |
| `show spanning-tree bridge`               | Toont bridge-ID info van de eigen switch                 |

***STP/RSTP configureren**

| Commando                                  | Beschrijving                                              |
|--------------------------------------------|----------------------------------------------------------|
| `spanning-tree mode rapid-pvst`           | Zet de switch in Rapid PVST+ (Cisco RSTP) mode           |
| `spanning-tree mode pvst`                 | Zet de switch in PVST+ (Cisco STP) mode                  |
| `spanning-tree vlan <vlan-id> priority <waarde>` | Wijzigt de bridge priority voor STP/RSTP voor een VLAN   |
| `spanning-tree vlan <vlan-id> root primary`     | Maakt de switch root bridge voor opgegeven VLAN          |
| `spanning-tree vlan <vlan-id> root secondary`   | Maakt de switch backup root bridge voor opgegeven VLAN   |
| `spanning-tree portfast`                        | Zet PortFast aan op een interface (voor snelle activatie)|
| `spanning-tree bpduguard enable`                | Zet BPDU Guard aan op een PortFast interface             |

**Portrollen en states bekijken**

| Commando                                 | Beschrijving                                              |
|-------------------------------------------|----------------------------------------------------------|
| `show spanning-tree interface <if>`       | Toont de huidige role (Root, Designated, Alternate, Backup) en state van de poort |
| `show spanning-tree active`               | Overzicht van actieve spanning-tree instanties            |



 **Let op:**  
  Cisco gebruikt voor snelle STP meestal *rapid-pvst* (Rapid Per VLAN Spanning Tree Plus), gebaseerd op RSTP (802.1w).


### EtherChannel

EtherChannel bundelt meerdere fysieke poorten tot één logische link voor bandbreedte en redundantie.

- Poorten moeten identieke configuratie hebben (snelheid, duplex, VLAN)
- Beide switches gebruiken zelfde protocol en channel-group nummer


#### Protocollen

| Protocol | Mode Options | Description |
|----------|--------------|-------------|
| LACP     | active, passive | IEEE 802.3ad standaard |
| PAgP     | desirable, auto | Cisco proprietary protocol |
| Static   | on | Geen negotiatie |

#### Basisconfiguratie

| Commando | Beschrijving |
|----------|--------------|
| `interface range g0/1-2` | Selecteer interfaces voor EtherChannel |
| `channel-group 1 mode active` | LACP active mode |
| `channel-group 1 mode passive` | LACP passive mode |
| `channel-group 1 mode desirable` | PAgP desirable mode |
| `channel-group 1 mode auto` | PAgP auto mode |
| `channel-group 1 mode on` | Static EtherChannel |

#### Port-channel Interface

| Commando | Beschrijving |
|----------|--------------|
| `interface port-channel 1` | Configureer port-channel interface |
| `switchport mode trunk` | Zet interface in trunk mode |
| `switchport trunk allowed vlan 10,20` | Sta specifieke VLANs toe |

#### Load-Balancing

| Commando | Beschrijving |
|----------|--------------|
| `port-channel load-balance src-mac` | Source MAC based |
| `port-channel load-balance dst-mac` | Destination MAC based |
| `port-channel load-balance src-dst-mac` | Source-destination MAC based |
| `port-channel load-balance src-ip` | Source IP based |
| `port-channel load-balance dst-ip` | Destination IP based |
| `port-channel load-balance src-dst-ip` | Source-destination IP based |

#### Verificatie

| Commando | Beschrijving |
|----------|--------------|
| `show etherchannel summary` | Overzicht van alle EtherChannels |
| `show interfaces port-channel 1` | Details van specifieke port-channel |
| `show etherchannel load-balance` | Huidige load-balancing methode |
| `show etherchannel port-group` | Poort groep informatie |
| `show etherchannel protocol` | Protocol status |

> **Let op:**  
> - Maximum 8 interfaces per EtherChannel
> - Alle poorten moeten identieke configuratie hebben
> - LACP ondersteunt standby links (max 16)


