# Network Layer (Layer 3)

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken.  
Het belangrijkste protocol op deze laag is het Internet Protocol (IP), dat zorgt voor adressering en routering van pakketten.

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

---

### Omrekenen van binaire naar decimale getallen

<img src="/assets/binary1.png" alt="binary1" width="600">

Omgekeerd omrekenen van binaire naar decimale getallen:
- **11000000** = 128 + 64 + 0 + 0 + 0 + 4 + 0 + 0 = 192
- **10101000** = 128 + 0 + 32 + 0 + 8 + 0 + 0 + 0 + 0 = 168
- **01110110** = 0 + 64 + 32 + 16 + 0 + 4 + 2 + 0 = 118 


Een byte bestaat uit 8 bits en kan waarden aannemen van 0 tot 255. In binaire notatie loopt dit van **00000000** (decimaal 0) tot **11111111** (decimaal 255).

---

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
- **Fragment Offset:** bits 51-63
- **Time To Live:** bits 64-71
- **Protocol:** bits 72-79
- **Header Checksum:** bits 80-95
- **Source IP Address:** bits 96-127
- **Destination IP Address:** bits 128-159
- **Options + Padding:** bits 160-255 (indien IHL > 5)

**Uitleg velden:**
- **Version:** 4 bits, geeft de versie van het IP-protocol aan (IPv4 = 4, IPv6 = 6).
- **IHL:** 4 bits, geeft de lengte van de header aan in 4-byte stappen (minimaal 5, maximaal 15).
- **DSCP:** 6 bits, gebruikt voor Quality of Service (QoS).
- **ECN:** 2 bits, geeft netwerkcongestie aan.
- **Total Length:** 16 bits, totale lengte van het IP-pakket in bytes.
- **Identification:** 16 bits, uniek nummer voor fragmentatie.
- **Flags:** 3 bits, fragmentatiecontrole.
- **Fragment Offset:** 13 bits, positie van het fragment.
- **Time To Live (TTL):** 8 bits, maximale levensduur van het pakket.
- **Protocol:** 8 bits, welk protocol in de data (bijv. TCP, UDP).
- **Header Checksum:** 16 bits, foutcontrole van de header.
- **Source IP Address:** 32 bits, bronadres.
- **Destination IP Address:** 32 bits, bestemmingsadres.
- **Options + Padding:** variabele lengte, extra opties.

**Headergrootte:**
- Minimaal: **20 bytes (160 bits)** zonder opties
- Maximaal: **60 bytes (480 bits)** met opties

---

## IPv4 Addresses

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

## Classful Addressing

### Subnetvoorbeelden

**/24 subnet:**
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

**/8 subnet:**
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

_Berekening van het aantal hostadressen in een subnet:_  
Aantal hostadressen = 2^(aantal host bits) - 2
/30 = 2 host bits = 2² = 4 - 2 = 2 hostadressen

<img src="/assets/classes.png" alt="IPv4 classes" width="600">

- **Class A:** Eerste octet 0-127, subnetmasker /8, 128 netwerken, elk met 16.777.216 adressen.
- **Class B:** Eerste octet 128-191, subnetmasker /16, 16.384 netwerken, elk met 65.536 adressen.
- **Class C:** Eerste octet 192-223, subnetmasker /24, 2.097.152 netwerken, elk met 256 adressen.

Het adresbereik 127.0.0.0 - 127.255.255.255 is gereserveerd voor loopback-adressen.  
Broadcast-adressen worden gebruikt om berichten naar alle apparaten in een netwerk te sturen.  
Het hostgedeelte van het netwerkadres is altijd 0, en het hostgedeelte van het broadcast-adres is altijd 255.  
Deze kunnen niet toegewezen worden aan individuele apparaten.