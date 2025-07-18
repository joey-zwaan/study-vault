# Network Layer (Layer 3)

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken.  
IP Protocol (Internet Protocol) is het belangrijkste protocol op deze laag en zorgt voor de adressering en routering van pakketten.

---

## Binary

Binaire representatie is een manier om getallen weer te geven met alleen de cijfers 0 en 1.
In binaire notatie wordt elk cijfer (bit) een macht van 2, waarbij de rechterkant de laagste macht is (2^0) en de linkerkant de hoogste macht is.

### Voorbeeld van binaire representatie
Laten we het getal 192 en 168 in binaire vorm bekijken:

<img src="/assets/base2.png" alt="Binary Representation" width="600">

uitleg van binaire representatie aan de hand van het getal 192:
- 192 past in 128, dus eerste bit is 1.
- 64 past niet, dus tweede bit is 0.
- 32 past, derde bit is 1.
- 16 past niet, vierde bit is 0.
- 8 past niet, vijfde bit is 0.
- 4 past, zesde bit is 1.
- 2 past niet, zevende bit is 0.
- 1 past niet, achtste bit is 0.
- Binaire representatie van 192: **11000000**
  

<img src="/assets/base2-2.png" alt="Binary Representation 2" width="600">

Uitleg van binaire representatie aan de hand van het getal 168:
- 168 past in 128, dus eerste bit is 1.
- 40 over, 64 past niet, tweede bit is 0.
- 32 past, derde bit is 1.
- 8 over, 16 past niet, vierde bit is 0.
- 8 past, vijfde bit is 1.
- 0 over, 4/2/1 passen niet, zesde, zevende, achtste bit zijn 0.
- Binaire representatie van 168: **10101000**



### Omrekenen van binaire naar decimale getallen

<img src="/assets/binary1.png" alt="binary1" width="600">

Omgekeerd omrekenen van binaire naar decimale getallen:
- **11000000** = 128 + 64 + 0 + 0 + 0 + 4 + 0 + 0 = 192
- **10101000** = 128 + 0 + 32 + 0 + 8 + 0 + 0 + 0 + 0 = 168
- **01110110** = 0 + 64 + 32 + 16 + 0 + 4 + 2 + 0 = 118 


Een byte bestaat uit 8 bits en kan waarden aannemen van 0 tot 255. In binaire notatie loopt dit van **00000000** (decimaal 0) tot **11111111** (decimaal 255).


## IPv4 Header

De IPv4-header bevat essentiële informatie voor het routeren van IP-pakketten.
De header bestaat uit verschillende velden die informatie bevatten zoals de versie van het IP-protocol, de lengte van de header, het totale pakketlengte, de bron- en bestemmings-IP-adressen, en andere controle-informatie.

### IPv4 Header Format

<img src="/assets/ipv4header.png" alt="IPv4 Header Format" width="600">


**Legenda:**
- **Version:** bits 0-3
- **IHL:** bits 4-7
- **DSCP:** bits 8-13
- **ECN:** bits 14-15
- **Total Length:** bits 16-31
- **Identification:** bits 32-47
- **Flags:** bits 48-50
- **Fragment ffset:** bits 51-63
- **Time To Live:** bits 64-71
- **Protocol:** bits 72-79
- **Header Checksum:** bits 80-95
- **Source IP Address:** bits 96-127
- **Destination IP Address:** bits 128-159
- **Options + Padding:** bits 160-255 (indien IHL > 5)


Version: 4 bits, geeft de versie van het IP-protocol aan (IPv4 = 4, IPv6 = 6).

IHL: 4 bits, de laatste veld van een header (Options) is variabele lengte, dus IHL geeft de lengte van de header in 4 byte incrementen aan.
- IHL = 5 betekent een header van 20 bytes (5 * 4 = 20 bytes)
- IHL = 6 betekent een header van 24 bytes (6 * 4 = 24 bytes)
- minimum waarde is 5 (20 bytes), maximum is 15 (60 bytes)

DSCP: 6 bits, Differentiated Services Code Point, gebruikt voor Quality of Service (QoS) om prioriteit aan verkeer toe te kennen.

ESN: 2 bits, Explicit Congestion Notification, gebruikt om congestie in het netwerk aan te geven zonder pakketverlies.
- optioneel en netwerkapparatuur moet dit ondersteunen langs beide kanten van de verbinding.

length: 16 bits, de totale lengte van het IP-pakket (L3 header + L4 segment) in bytes.
- gemeten in bytes en niet in 4-byte incrementen zoals IHL.
- minimum waarde is 20 bytes (als er geen opties zijn), maximum is 65,535 bytes.

Identification: 16 bits, een uniek nummer dat wordt gebruikt om fragmenten van een IP-pakket te identificeren. Dit is belangrijk voor het opnieuw samenstellen van fragmenten bij ontvangst.
- Alle fragmenten van hetzelfde IP-pakket hebben dezelfde identificatie met dezelfde waarde
- Fragmenten worden opnieuw samengevoegd door de ontvanger.
- Dit wordt gebruikt als de MTU overschreden wordt 1500 bytes, waardoor het IP-pakket gefragmenteerd moet worden.

Flags: 3 bits, gebruikt om fragmentatie-informatie aan te geven.
- Bit 0: Reserved (moet altijd 0 zijn)
- Bit 1: Don't Fragment (DF) - geeft aan dat het pakket niet gefragmenteerd mag worden.
- Bit 2: More Fragments (MF) - geeft aan dat er meer fragmenten volgen.
Unfragmented packets hebben de MF bit op 0 staan.

Fragment Offset: 13 bits, geeft de positie van het fragment in het originele IP-pakket aan. Dit is belangrijk voor het correct samenvoegen van fragmenten.

Time To Live (TTL): 8 bits, geeft aan hoe lang een IP-pakket geldig is in het netwerk. Elke router die het pakket doorstuurt (hop count), verlaagt de TTL met 1. Als de TTL 0 bereikt, wordt het pakket weggegooid om oneindige loops te voorkomen.
- De default aanbevolen waarde is 64, maar dit kan variëren afhankelijk van het besturingssysteem of de applicatie die het pakket verzendt.

Protocol: 8 bits, geeft het protocol aan dat wordt gebruikt in de transportlaag .
TCP = 6, UDP = 17, ICMP = 1, OSPF = 89

Header Checksum: 16 bits, een checksum die wordt gebruikt om fouten in de header te detecteren. Het wordt berekend over de header en wordt gecontroleerd door de ontvanger.

Wanneer een router een IP-pakket ontvangt, controleert het de checksum zelf met de checksum die in de header staat.
Als de checksum niet overeenkomt, wordt het pakket weggegooid en wordt er een ICMP bericht gestuurd naar de bron om aan te geven dat er een fout is opgetreden.

Source IP Address: 32 bits, het IP-adres van de zender van het pakket.

Destination IP Address: 32 bits, het IP-adres van de ontvanger van het pakket.

Options + Padding: variabele lengte, dit veld kan extra opties bevatten voor het IP-pakket, zoals beveiligingsopties of timestamp-informatie. Het is optioneel en wordt meestal niet gebruikt.






Hoeveel bytes/bits zijn er in de IPv4 header?

- **Minimaal:** 20 bytes (160 bits) als er geen opties zijn (IHL = 5)
- **Maximaal:** 60 bytes (480 bits) als opties aanwezig zijn (IHL = 15)

---

### IPv4 Addresses

IPv4-adressen zijn **32-bits getallen**, meestal weergegeven in decimale notatie als vier groepen van 8 bits (octets), gescheiden door punten. 
Een octet is een groep van 8 bits, wat betekent dat elk octet een waarde kan hebben van 0 tot 255.

**Voorbeeld:** `192.168.1.254`
192.168.1.254

is een IPv4-adres dat bestaat uit vier octets:
- **192** (11000000 in binaire vorm)
- **168** (10101000 in binaire vorm)
- **1** (00000001 in binaire vorm)
- **254** (11111110 in binaire vorm)
- In binaire notatie is dit adres: `11000000.10101000.00000001.11111110`

---

### Classful Addressing

**/24** is een notatie die aangeeft dat de eerste 24 bits van het IPv4-adres het netwerkadres vormen, terwijl de resterende 8 bits gebruikt worden voor hostadressen binnen dat netwerk.  
Dit betekent dat er **256 mogelijke hostadressen** zijn in dit subnet (0-255), maar meestal zijn 2 adressen gereserveerd (netwerk- en broadcastadres), waardoor er effectief **254 hostadressen** beschikbaar zijn.

```
/24: 11111111.11111111.11111111.00000000
      (255)    (255)    (255)     (0)
      |--------- Network --------| Host |
```

**CIDR:** /24  
**Subnet Mask:** 255.255.255.0  
**Network bits:** 24  
**Host bits:** 32 - 24 = 8 bits  
**Total addresses:** 2⁸ = 256  
**Usable hosts:** 256 - 2 = 254

---

**/26** subnet:

```
/26: 11111111.11111111.11111111.11000000
      (255)    (255)    (255)    (192)
      |----------- Network ----------|Host|
```

**CIDR:** /26  
**Subnet Mask:** 255.255.255.192  
**Network bits:** 26  
**Host bits:** 32 - 26 = 6 bits  
**Total addresses:** 2⁶ = 64  
**Usable hosts:** 64 - 2 = 62


**/16** subnet:

```
/16: 11111111.11111111.00000000.00000000
      (255)    (255)    (0)      (0)
      |---------------- Network ----------------| Host |
```
**CIDR:** /16
**Subnet Mask:** 255.255.0.0
**Network bits:** 16
**Host bits:** 32 - 16 = 16 bits
**Total addresses:** 2¹⁶ = 65,536 = 256 x 256
**Usable hosts:** 65,536 - 2 = 65,534

**/8** subnet:

```
/8: 11111111.00000000.00000000.00000000
      (255)    (0)      (0)      (0)
      |---------------------- Network ----------------------| Host |
```
**CIDR:** /8
**Subnet Mask:** 255.0.0.0
**Network bits:** 8
**Host bits:** 32 - 8 = 24 bits
**Total addresses:** 2²⁴ = 16,777,216 = 256 x 256 x 256
**Usable hosts:** 16,777,216 - 2 = 16,777214

Berekening van het aantal hostadressen in een subnet:
Aantal hostadressen = 2^(aantal host bits) - 2
/30 = 2 host bits = 2² = 4 - 2 = 2 hostadressen

<img src="/assets/classes.png" alt="IPv4 classes" width="600">

Class A, B, C, D en E zijn de verschillende klassen van IPv4-adressen:
- **Class A:**
  - Eerste bit van het eerste octet is 0
  - Eerste octet: 0-127
  - Subnetmasker: /8 (
  - 128 netwerken, elk met 16.777.216 ip-adressen)
- **Class B:**
  - Eerste bit van het eerste octet is 1 en tweede bit is 0 2 ** 14 = 16.384 netwerken
  - Eerste octet: 128-191
  - Subnetmasker: /16
  - 16,384 netwerken, elk met 65.536 ip-adressen
  - 
- **Class C:**
  - Eerste bit van het eerste octet is 1, tweede bit is 1 en derde bit is 0
  - Eerste octet: 192-223
  - Subnetmasker: /24
  - 2,097,152 netwerken, elk met 256 ip-adressen

address range 127.0.0.0 - 127.255.255.255 is voorbehouden voor loopback-adressen.
Dit wordt gebruikt om netwerksoftware te testen zonder een fysiek netwerk te gebruiken.

Broadcast-adressen zijn speciale adressen die worden gebruikt om berichten naar alle apparaten in een netwerk te sturen.

Host portion van het netwerkadres is altijd 0, en de host portion van het broadcast-adres is altijd 255.
Deze kunnen niet toegewezen worden aan individuele apparaten.