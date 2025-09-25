## IOS

Cisco IOS (Internetwork Operating System) is het besturingssysteem dat wordt gebruikt op Cisco netwerkapparaten zoals routers en switches. Het biedt een command-line interface (CLI) voor configuratie, beheer en troubleshooting van netwerkfuncties. Cisco IOSXE is een meer geavanceerde versie van IOS, ontworpen voor grotere en complexere netwerken, met verbeterde schaalbaarheid en prestaties.

**SUPER TIP:** `no ip domain-lookup ` commando ingeven om te voorkomen dat de router probeert onbestaande hostnames te vertalen naar IP-adressen, wat vertraging kan veroorzaken bij het invoeren van onjuiste commando's.
**SUPER TIP:** `Logging synchronous` op console & vty lines zorgt ervoor dat console output (zoals syslog berichten) niet de command prompt overschrijft tijdens het typen van commando's.
**SUPER TIP:** `Exec-timeout 0 0` zorgt ervoor dat de console of vty sessie nooit automatisch wordt verbroken door inactiviteit.


### Common switch config modes

| **Modus**                 | **Prompt**               | **Toegang via**                      | **Voorbeeldcommando's**                               |
| ------------------------- | ------------------------ | ------------------------------------ | ----------------------------------------------------- |
| **Privileged EXEC Mode**  | `hostname#`              | `enable`                             | `show running-config`, `copy startup-config`          |
| **Global Config Mode**    | `hostname(config)#`      | `configure terminal`                 | `hostname R1`, `enable secret cisco`                  |
| **Line Config Mode**      | `hostname(config-line)#` | `line console 0``line vty 0 4`       | `password cisco`, `login`                             |
| **Interface Config Mode** | `hostname(config-if)#`   | `interface g0/0``interface g0/1`     | `ip address 192.168.1.1 255.255.255.0`, `no shutdown` |
| **VLAN Config Mode**      | `hostname(config-vlan)#` | `vlan 10``vlan 20`                   | `name Finance`, `exit`                                |


### Terminologie

**RAM**: Tijdelijke opslag voor lopende processen en configuraties. Verlies van stroom betekent verlies van RAM-gegevens.
**NVRAM**: Niet-vluchtige opslag voor de startup-configuratie. Blijft behouden bij stroomuitval.
**Flash memory**: Opslag voor het IOS-besturingssysteem en andere bestanden. Behoudt gegevens bij stroomuitval.
**ROM**: Bevat de bootloader en diagnostische software. Verlies van stroom heeft geen effect.
**Reload**: Herstart van het apparaat, waarbij de configuratie opnieuw wordt geladen.

> startup-configuratie wordt opgeslagen in NVRAM en geladen in RAM bij het opstarten van het apparaat. Lopende configuratie wordt bewaard in RAM en gaat verloren bij herstart, tenzij opgeslagen naar NVRAM.

> Do commands zorgt ervoor dat je een commando kan uitvoeren zonder de huidige modus te verlaten. Bijvoorbeeld in interface config mode kan je met `do show running-config` de lopende configuratie bekijken zonder eerst naar privileged EXEC mode te moeten gaan.

### Password Security (Cisco)

- `enable secret <password>` → Stelt een versleuteld wachtwoord in voor privileged EXEC mode.
- `service password-encryption` → Versleutelt alle wachtwoorden in de configuratie.

#### Line password configuration

line console 0
 password <password>
 login

line vty 0 4
  password <password>
  login
  transport input all

Als we de console een gebruikersnaam + wachtwoordt moet vragen moeten we deze aanmaken in user mode. We moeten ook de line console & vty lines aanpassen naar login local. Dit zorgt ervoor dat de console & vty lines de lokale gebruikersdatabase gebruiken voor authenticatie.

**username <username> secret <password>**

line console 0
  login local

line vty 0 4
  login local


- `Level 0 = User EXEC Mode (Prompt: `Router>`)`
- `Level 15 = Privileged EXEC Mode (Prompt: `Router#`)
- `username <username> privilege <level> secret <password>` → Maakt een gebruiker aan met een specifiek privilege level (0-15).

#### Remote access met SSH

- `ip domain-name <domain>` → Stelt de domeinnaam in voor het apparaat.
- `crypto key generate rsa` → Genereert een RSA-sleutelpaar voor SSH.
- `ip ssh version 2` → Stelt SSH versie 2 in (aanbevolen).
- `line vty 0 15` → Gaat naar de VTY lijnen.
- `transport input ssh` → Staat alleen SSH-toegang toe (geen Telnet).
- `login local` → Gebruikt lokale gebruikersdatabase voor authenticatie.
- `username <username> secret <password>` → Maakt een lokale gebruiker aan met wachtwoord.


Best Practices
- Gebruik altijd **`enable secret`** i.p.v. `enable password` (versleuteld).
- Zet **`service password-encryption`** aan om wachtwoorden in de config te verbergen.
- Gebruik bij voorkeur **local usernames met secrets** i.p.v. plain-text passwords.



### Autonegotiate & duplex

- `no negotiate auto` → Schakelt autonegotiatie uit op de interface.
- `speed 10, 100, 1000, auto` → Stelt de snelheid van de interface in.
- `duplex half, full, auto` → Stelt de duplex-modus in.
- `description <text>` → Voegt een beschrijving toe aan de interface.
- `no mdix auto` → Schakelt Auto-MDIX uit op de interface.
- `mdix auto` → Schakelt Auto-MDIX in op de interface (standaard).


### VLAN & Switchport configuration

- `vlan <vlan-id>` → Creëer of ga naar VLAN-configuratiemodus.
- `name <vlan-name>` → Geef een naam aan het VLAN.
- `interface vlan <vlan-id>` → Ga naar de VLAN-interface voor Layer 3-configuratie.
- `switchport mode access` → Zet de poort in access mode (voor eindapparaten).
- `switchport mode trunk` → Zet de poort in trunk mode (voor switch-to-switch links).
- `switchport access vlan <vlan-id>` → Wijs een VLAN toe aan een access-poort.
- `switchport trunk allowed vlan <vlan-list>` → Beperk toegestane VLANs op een trunk-poort.
- `switchport trunk native vlan <vlan-id>` → Stel het native VLAN in op een trunk-poort.
- `switchport trunk allowed vlan except <vlan-id>` → Sta alle VLANs toe behalve de opgegeven vlan.
- `switchport trunk allowed vlan add <vlan-id>` → Voeg een VLAN toe aan de lijst van toegestane VLANs op een trunk-poort.
- `switchport trunk encapsulation dot1q` → Stelt 802.1Q encapsulatie in op een trunk-poort (indien ondersteund).
- `switchport nonegotiate` → Schakelt DTP uit op een trunk-poort.
- `switchport mode trunk dynamic auto` → Stelt de poort in op dynamische auto mode (standaard).
- `switchport mode trunk dynamic desirable` → Stelt de poort in op dynamische gewenste mode.


### STP & RSTP configuration
- `spanning-tree mode rapid-pvst` → Zet Rapid PVST+ in als STP-modus.
- `spanning-tree vlan <vlan-id> priority <value>` → Stelt de prioriteit van de switch in voor een specifiek VLAN (waarde tussen 0-61440, in stappen van 4096).
- `spanning-tree vlan <vlan-id> root primary` → Maakt de switch de primaire root switch voor het opgegeven VLAN.
- `spanning-tree vlan <vlan-id> root secondary` → Maakt de switch de secundaire root switch voor het opgegeven VLAN.
- `spanning-tree bpduguard enable` → Schakelt BPDU Guard in op de interface.
- `spanning-tree bpdufilter enable` → Schakelt BPDU-filtering in op de interface. --> Dit betekent dat de switch geen BPDU's zal verzenden of ontvangen op die poort. feitelijk wordt de poort uitgeschakeld voor STP.
- `spanning-tree root guard` → Schakelt Root Guard in op de interface. 
- `spanning-tree portfast` → Schakelt PortFast in op de interface.
- `spanning-tree portfast bpduguard default` → Schakelt BPDU Guard in op alle PortFast-poorten. --> Global config mode
- `spanning-tree portfast default` → Schakelt PortFast in op alle niet-trunk poorten. --> Global config mode
- `spanning-tree loopguard default` → Schakelt Loop Guard in op alle niet-trunk poorten. --> Global config mode
- `spanning-tree guard loop` → Schakelt Loop Guard in op de interface.

### EtherChannel / PortChannel configuration

- `interface range <type/nummer> - <type/nummer>` → Selecteer meerdere interfaces.
- `shutdown` → Schakel de interfaces uit (indien nodig).
- `channel-group <number> mode active` → Voeg de interfaces toe aan een EtherChannel in actieve LACP-modus.
- `channel-group <number> mode passive` → Voeg de interfaces toe aan een EtherChannel in passieve LACP-modus.
- `channel-group <number> mode on` → Voeg de interfaces toe aan een statische EtherChannel (geen LACP of PAgP).
- `no shutdown` → Schakel de interfaces weer in.
- `interface port-channel <number>` → Ga naar de PortChannel-interface voor verdere configuratie.
- `show etherchannel summary` → Toont een overzicht van alle EtherChannels en hun status.
- `show interfaces port-channel <number>` → Toont gedetailleerde informatie over een specifieke PortChannel.




### Cli help functies

Cisco IOS biedt verschillende help-functies in de command-line interface (CLI) om gebruikers te ondersteunen bij het invoeren van commando's en het navigeren door de configuratie. Hier zijn enkele van de belangrijkste help-functies:

? : Toont contextspecifieke hulp en beschikbare commando's.
command? : Toont hulp voor een specifiek commando.
com? : Toont alle commando's die beginnen met "com".
command parm? : Toont hulp voor een specifiek commando met een parameter.


### Cisco Show Commands

#### Show Commands – Interfaces & MAC Addresses

- `show ip interface brief` → Overzicht interfaces, IP-adres, status (up/down).
- `show interface [type/nummer]` → Detail van één interface.
- `show interfaces` → Detail van alle interfaces.
- `show interfaces status` → Status, snelheid, duplex, err-disabled.
- `show interfaces counters errors` → Foutentellers per interface.
- `show interfaces description` → Beschrijvingen + status.


- `show mac address-table` -> Volledige MAC-address table van de switch.
- `show mac address-table dynamic` -> Dynamisch geleerde MAC-adressen.
- `show mac address-table static` -> Statisch geconfigureerde MAC-adressen.
- `show mac address-table aging-time` -> Huidige aging time voor MAC-adressen.
- `show mac address-table count` -> Aantal MAC-adressen in de tabel.
- `show mac address-table interface [type/nummer]` -> MAC-adressen op een specifieke interface.
- `show mac address-table vlan [vlan-id]` -> MAC-adressen in een specifiek VLAN.

#### Show Commands – Routing

- `show ip route` → Toont de IP-routingtabel.
- `show ip route static` → Toont alleen statische routes.
- `show ip route connected` → Toont alleen connected routes.
- `show ip route ospf` → Toont OSPF-routes.
- `show ip default-gateway` → Toont de default gateway op een switch.
- `show ip route eigrp` → Toont EIGRP-routes.


#### Show Commands – Configuratie

- `show running-config` → Toont de huidige configuratie.
- `show startup-config` → Toont de opgeslagen configuratie.
- `show version` → Toont IOS-versie, uptime, geheugen.
- `show crypto key mypubkey rsa` → Toont de gegenereerde RSA-sleutels voor SSH.
- `show ssh` → Toont actieve SSH-sessies.
- `show users` → Toont actieve gebruikerssessies.
- `show history` → Toont de commandogeschiedenis van de huidige sessie.


#### Show Commands - Switchport & VLANs


- `show interfaces switchport` → Toont switchport-informatie voor alle interfaces.
- `show interfaces [type/nummer] switchport` → Toont switchport-informatie voor een specifieke interface.
- `show vlan brief` → Toont een overzicht van alle VLANs en hun toegewezen poorten.
- `show vlan id [vlan-id]` → Toont gedetailleerde informatie over een specifiek VLAN.
- `show interfaces status` → Toont de status van alle interfaces, inclusief snelheid en duplex-instellingen.
- `show interfaces trunk` → Toont informatie over alle trunk-poorten.
- `show interfaces [type/nummer] trunk` → Toont trunk-informatie voor een specifieke interface.
- `show spanning-tree vlan [vlan-id]` → Toont STP-informatie voor een specifiek VLAN.



#### Show Commands - STP & RSTP

- `show spanning-tree` → Toont de STP-status voor alle VLANs.
- `show spanning-tree detail` → Toont gedetailleerde STP-informatie.
- `show spanning-tree vlan [vlan-id]` → Toont STP-informatie voor een specifiek VLAN.
- `show spanning-tree interface [type/nummer]` → Toont STP-informatie voor een specifieke interface.
- `show spanning-tree vlan [vlan-id] detail` → Toont gedetailleerde STP-informatie voor een specifiek VLAN.
- `show spanning-tree summary` → Toont een samenvatting van de STP-configuratie en status.
- 

