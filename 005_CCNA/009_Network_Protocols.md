# Network Protocols

## NTP (Network Time Protocol)

NTP zorgt ervoor dat alle apparaten in een netwerk dezelfde tijd gebruiken door ze te synchroniseren met een betrouwbare tijdbron, zoals een NTP-server. Dit is essentieel voor:
- **Logbestanden:** Correcte tijdstempels voor troubleshooting.
- **Beveiligingsprotocollen:** Tijdgevoelige verificaties.
- **Tijdgevoelige toepassingen:** Zoals geplande taken en synchronisatie.

### Werking
- **NTP Clients:** Vragen periodiek de tijd op bij een NTP-server.
- **NTP Server:** Een apparaat kan zowel een NTP-server als een client zijn.
- **Stratum:** De afstand van een NTP-server tot de referentieklok (bijv. atoomklok).
  - **Stratum 1:** Direct verbonden met een referentieklok (beste).
  - **Stratum 2:** Synchroniseert met een Stratum 1-server.
  - **Stratum 15+:** Onbruikbaar.
- **NTP Poort:** 123 (UDP).

- **Symmetric Active Mode:** Apparaten kunnen peers zijn en elkaars tijd controleren en corrigeren.

### NTP authenticatie

NTP ondersteunt authenticatie om te voorkomen dat apparaten synchroniseren met een onbetrouwbare of kwaadaardige tijdbron. Dit kan worden gedaan via:

```cisco
ntp authenticate
ntp authentication-key <key-number> md5 <key-string>
ntp trusted-key <key-number>
ntp server <ip-address> key <key-number>
ntp peer <ip-address> key <key-number>
```


## DHCP (Dynamic Host Configuration Protocol)

DHCP automatiseert het toewijzen van IP-adressen en andere netwerkconfiguratie-instellingen aan apparaten in een netwerk. Dit vermindert de kans op IP-conflicten en vereenvoudigt het beheer van netwerkadressen.

### DHCP Discovery Process

1. **DHCP Discover:** Een apparaat (client) dat een IP-adres nodig heeft, stuurt een broadcast-bericht om een DHCP-server te vinden.
2. **DHCP Offer:** Een of meer DHCP-servers reageren met een aanbod van een IP-adres en andere configuratiegegevens.
3. **DHCP Request:** De client kiest een aanbod en stuurt een verzoek terug naar de geselecteerde DHCP-server.
4. **DHCP Acknowledgment:** De DHCP-server bevestigt de toewijzing en de client kan nu het IP-adres en andere instellingen gebruiken.



### DHCP Relay Agent

Wanneer je een centralized DHCP server gebruikt en clients zich in een ander subnet bevinden, kan een DHCP relay agent (meestal een router) worden ingezet. Deze agent ontvangt DHCP-berichten van clients en stuurt ze door naar de DHCP-server in een ander subnet.

```cisco
ip dhcp relay information option
ip helper-address <dhcp-server-ip>
```



## SNMP (Simple Network Management Protocol)

### Overzicht
SNMP is een protocol voor het beheren en monitoren van netwerkapparaten zoals routers, switches, servers en printers. Het maakt gebruik van een **manager-agent model**, waarbij de manager (beheerder) informatie opvraagt van agents (apparaten).

### Belangrijke Componenten
- **SNMP Manager:** Verzamelt en analyseert gegevens van netwerkapparaten.
- **SNMP Agent:** Verzamelt en bewaart informatie over het apparaat en communiceert met de manager.
- **Management Information Base (MIB):** Een database met gestructureerde gegevens over het apparaat. Elke variabele heeft een unieke Object Identifier (OID).

Voorbeelden van OID's:
- Interface status
- CPU-gebruik
- Geheugengebruik
- Netwerkverkeer


| Versie    | Beschrijving                                   |
|-----------|-----------------------------------------------|
| **SNMPv1** | Basisfunctionaliteit, geen beveiliging.       |
| **SNMPv2c**| Verbeterde prestaties, maar geen sterke beveiliging. |
| **SNMPv3** | Ondersteunt sterke beveiliging met authenticatie en encryptie. |


### SNMP Messages

| **Bericht** | **Beschrijving**                                                                 |
|-------------|----------------------------------------------------------------------------------|
| **Get**     | Wordt gebruikt door de manager om informatie op te vragen van de agent.         |
| **GetNext** | Vraagt de volgende OID in de MIB op.                                            |
| **GetBulk** | Efficiënter dan GetNext voor het ophalen van grote hoeveelheden gegevens.        |
| **Set**     | Wordt gebruikt door de manager om een waarde op de agent te wijzigen.           |
| **Trap**    | Bericht van de agent naar de manager om een onverwachte gebeurtenis te melden.  |
| **Inform**  | Vergelijkbaar met Trap, maar vereist een bevestiging van de manager.            |
| **Response**| Antwoord van de agent op een Get, GetNext, GetBulk of Set verzoek.              |


## Syslog

Syslog is een standaardprotocol voor het verzenden van log- en gebeurtenisberichten in een netwerk. Het wordt gebruikt om systeemmeldingen van verschillende apparaten te verzamelen en te centraliseren voor monitoring en probleemoplossing.


Syslog message Format

**seq:time stamp: %facility-severity:-mnemonic:description**

Severity Levels:
| Level | Naam        | Beschrijving                       |
|-------|-------------|------------------------------------|    
| 0     | Emergency   | Systeem is onbruikbaar             |
| 1     | Alert       | Directe actie vereist              |
| 2     | Critical    | Kritieke omstandigheden            |
| 3     | Error       | Foutconditie                       |
| 4     | Warning     | Waarschuwing                       |
| 5     | Notice      | Normalebelangrijke gebeurtenis     |
| 6     | Information | Informatieve berichten             |
| 7     | Debug       | Gedetailleerde debug-informatie    |

**Every Awesome Cisco Engineer Will Need Ice cream Daily**


**Cisco Logging Locations**

Console line: Syslog berichten worden weergeven in de CLI wanneer je geconnect met de console poort.
VTY line: Syslog berichten worden weergeven in de CLI wanneer je geconnect met een VTY sessie (SSH/Telnet).
Buffer: Syslog berichten worden opgeslagen in het RAM geheugen van de router/switch. (niet persistent na reboot)
External server: Syslog berichten worden verstuurd naar een externe syslog server. (aanbevolen)


Syslog vs SNMP

Beide worden gebruikt voor netwerkbeheer, maar op verschillende manieren:
- **Syslog:** Gebruikt voor het loggen van gebeurtenissen en fouten. Het is passief en stuurt berichten wanneer gebeurtenissen zich voordoen.
- **SNMP:** Gebruikt voor het actief monitoren en beheren van netwerkapparaten. Het maakt gebruik van een manager-agent model om gegevens op te vragen en te wijzigen.
- Syslog is eenvoudiger en richt zich op logboekregistratie, terwijl SNMP complexer is en uitgebreide beheerfuncties biedt.


## FTP & TFTP (File Transfer Protocol & Trivial File Transfer Protocol)

FTP en TFTP zijn protocollen voor het overbrengen van bestanden tussen computers in een netwerk. FTP is uitgebreider en veiliger, terwijl TFTP eenvoudiger is en minder overhead heeft.

Ze gebruiken beiden het client-server model
Clients kunnen FTP of TFTP gebruiken om files te copiëren van of naar een FTP/TFTP server.
Clients kunnen FTP of TFTP gebruiken om files op de server te plaatsen.

TFTP luistert op **UDP-poort 69**
FTP luistert op **TCP-poort 21** (besturing) en **TCP-poort 20** (gegevensoverdracht)


### TFTP connectie proces

Als de client bestanden stuurt naar de server, stuurt de server een **ACK** terug voor elk ontvangen blok gegevens.
Als de server bestanden stuurt naar de client, stuurt de client een **ACK** terug voor elk ontvangen blok gegevens.
Als de **ACK** niet binnen een bepaalde tijd wordt ontvangen, wordt het blok opnieuw verzonden.

TFTP file transfers hebben 3 fasen
1. **Connectie:** De client stuurt een Read Request (RRQ) of Write Request (WRQ) naar de server.
2. **Data Transfer:** Bestanden worden in blokken van 512 bytes verzonden, elk gevolgd door een **ACK**.
3. **Connection Termination:** De overdracht eindigt wanneer een blok kleiner dan 512 bytes wordt verzonden, gevolgd door een laatste **ACK**.


### FTP connectie proces

In FTP kan een client niet enkel bestanden downloaden (RETR) of uploaden (STOR), maar ook directory's beheren en bestandsinformatie opvragen of wijzigen.

FTP gebruikt twee kanalen:
1. **Control Channel (TCP-poort 21):** Voor het verzenden van commando's en reacties tussen client en server.
2. **Data Channel (TCP-poort 20):** Voor de daadwerkelijke overdracht van bestanden

FTP passive mode wordt gebruikt wanneer de client zich achter een firewall bevindt die inkomende verbindingen blokkeert. In passive mode opent de server een willekeurige hoge poort (boven 1023) en stuurt deze naar de client, die vervolgens een verbinding maakt met die poort voor de gegevensoverdracht.

**Power over Ethernet (PoE)**
PoE (Type 1) 802.3af 15.4W
PoE+ (Type 2) 802.3at 30W


