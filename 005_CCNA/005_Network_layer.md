# Network Layer (Layer 3)

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken.  
Het **Internet Protocol (IP)** is het belangrijkste protocol op deze laag en zorgt voor de adressering en routering van pakketten.

---

## Binary

Binaire representatie is een manier om getallen weer te geven met alleen de cijfers 0 en 1.  
In binaire notatie wordt elk cijfer (bit) een macht van 2, waarbij de rechterkant de laagste macht is (2⁰) en de linkerkant de hoogste macht is.

### Voorbeeld van binaire representatie

Laten we het getal 192 en 168 in binaire vorm bekijken:

<img src="/assets/base2.png" alt="Binary Representation" width="600">

**Uitleg van binaire representatie aan de hand van het getal 192:**
- 192 past in 128 → eerste bit is 1
- 64 past niet → tweede bit is 0
- 32 past → derde bit is 1
- 16 past niet → vierde bit is 0
- 8 past niet → vijfde bit is 0
- 4 past → zesde bit is 1
- 2 past niet → zevende bit is 0
- 1 past niet → achtste bit is 0  
→ Binaire representatie van 192: **11000000**

<img src="/assets/base2-2.png" alt="Binary Representation 2" width="600">

**Uitleg van binaire representatie aan de hand van het getal 168:**
- 168 past in 128 → eerste bit is 1
- 40 over, 64 past niet → tweede bit is 0
- 32 past → derde bit is 1
- 8 over, 16 past niet → vierde bit is 0
- 8 past → vijfde bit is 1
- 0 over, 4/2/1 passen niet → zesde, zevende, achtste bit zijn 0  
→ Binaire representatie van 168: **10101000**

### Omrekenen van binaire naar decimale getallen

<img src="/assets/binary1.png" alt="binary1" width="600">

Omgekeerd omrekenen van binaire naar decimale getallen:
- **11000000** = 128 + 64 + 0 + 0 + 0 + 0 + 0 + 0 = **192**
- **10101000** = 128 + 0 + 32 + 0 + 8 + 0 + 0 + 0 = **168**
- **01110110** = 0 + 64 + 32 + 16 + 0 + 4 + 2 + 0 = **118**

Een **byte bestaat uit 8 bits** en kan waarden aannemen van 0 tot 255.  
In binaire notatie loopt dit van **00000000** (decimaal 0) tot **11111111** (decimaal 255).

---

## IPv4 Header

De IPv4-header bevat essentiële informatie voor het routeren van IP-pakketten.  
De header bestaat uit velden zoals versie, lengte, bron/bestemmingsadressen en controle-informatie.

### IPv4 Header Format

<img src="/assets/ipv4header.png" alt="IPv4 Header Format" width="600">

**Legenda:**
- **Version:** bits 0–3  
- **IHL:** bits 4–7  
- **DSCP:** bits 8–13  
- **ECN:** bits 14–15  
- **Total Length:** bits 16–31  
- **Identification:** bits 32–47  
- **Flags:** bits 48–50  
- **Fragment Offset:** bits 51–63  
- **Time To Live:** bits 64–71  
- **Protocol:** bits 72–79  
- **Header Checksum:** bits 80–95  
- **Source IP Address:** bits 96–127  
- **Destination IP Address:** bits 128–159  
- **Options + Padding:** bits 160–255 (indien IHL > 5)

### Uitleg van IPv4 Header Velden

- **Version** (4 bits): Geeft aan of het IPv4 (4) of IPv6 (6) is.
- **IHL** (4 bits): Lengte van de header in blokken van 4 bytes.  
  - IHL = 5 → 20 bytes  
  - IHL = 6 → 24 bytes  
  - Minimum = 5 (20 bytes), Maximum = 15 (60 bytes)

- **DSCP** (6 bits): Differentiated Services Code Point. Wordt gebruikt voor QoS (Quality of Service).
- **ECN** (2 bits): Explicit Congestion Notification. Optioneel, geeft netwerkcongestie aan zonder pakketverlies.
- **Total Length** (16 bits): Totale lengte van IP-pakket (header + payload), in bytes.  
  - Minimum = 20 bytes, Maximum = 65.535 bytes
- **Identification** (16 bits): Uniek nummer om fragmenten van hetzelfde IP-pakket te herkennen.
- **Flags** (3 bits): Fragmentatiecontrole  
  - Bit 0: gereserveerd (altijd 0)  
  - Bit 1: Don't Fragment (DF)  
  - Bit 2: More Fragments (MF)
- **Fragment Offset** (13 bits): Positie van een fragment binnen het originele IP-pakket.
- **TTL** (8 bits): Time To Live. Vermindert per hop. Bij 0 wordt het pakket gedropt.
- **Protocol** (8 bits): Welk protocol op L4 wordt gebruikt.  
  - TCP = 6, UDP = 17, ICMP = 1, OSPF = 89
- **Header Checksum** (16 bits): Controleert fouten in de header.  
  - Routers controleren dit bij ontvangst.
- **Source IP Address** (32 bits): IP van de verzender.
- **Destination IP Address** (32 bits): IP van de ontvanger.
- **Options + Padding**: Extra veld voor o.a. timestamps of beveiliging (optioneel).

### Grootte van IPv4 Header

- **Minimaal:** 20 bytes (160 bits) als er geen opties zijn (IHL = 5)  
- **Maximaal:** 60 bytes (480 bits) als opties aanwezig zijn (IHL = 15)

---

## IPv4 Addresses

IPv4-adressen zijn **32-bits getallen**, meestal weergegeven in vier octets gescheiden door punten.

### Voorbeeld

`192.168.1.254` bestaat uit:
- 192 → `11000000`
- 168 → `10101000`
- 1 → `00000001`
- 254 → `11111110`

→ Binaire vorm: `11000000.10101000.00000001.11111110`

---

## Classful Addressing

### /24 subnet

```
/24: 11111111.11111111.11111111.00000000
       (255)   (255)   (255)     (0)
       |--------- Network --------| Host |
```

- **CIDR:** /24  
- **Subnet Mask:** 255.255.255.0  
- **Network bits:** 24  
- **Host bits:** 8  
- **Total addresses:** 256  
- **Usable hosts:** 254

### /26 subnet

```
/26: 11111111.11111111.11111111.11000000
       (255)   (255)   (255)    (192)
       |----------- Network ----------|Host|
```

- **CIDR:** /26  
- **Subnet Mask:** 255.255.255.192  
- **Host bits:** 6  
- **Usable hosts:** 2⁶ − 2 = 62

### /16 subnet

```
/16: 11111111.11111111.00000000.00000000
       (255)   (255)   (0)     (0)
       |-------------- Network --------------| Host |
```

- **CIDR:** /16  
- **Subnet Mask:** 255.255.0.0  
- **Host bits:** 16  
- **Usable hosts:** 65.536 − 2 = 65.534

### /8 subnet

```
/8: 11111111.00000000.00000000.00000000
      (255)    (0)     (0)     (0)
      |-------------------- Network --------------------| Host |
```

- **CIDR:** /8  
- **Subnet Mask:** 255.0.0.0  
- **Host bits:** 24  
- **Usable hosts:** 2²⁴ − 2 = 16.777.214

### Berekening hostadressen

Formule:
```
Aantal hostadressen = 2^(aantal host bits) − 2
```

Voorbeeld:
- `/30` → 2 host bits → 2² = 4 → 4 − 2 = 2 usable hosts

Subnetinformatie voor `192.168.1.0/26`:

- Subnet: `192.168.1.0/26`
- Subnetmasker: 255.255.255.192 (26 netwerkbits)

Binaire representatie:
- Netwerkadres (alle hostbits 0):  
  `192.168.1.0` → `11000000.10101000.00000001.00000000`
- Broadcastadres (alle hostbits 1):  
  `192.168.1.63` → `11000000.10101000.00000001.00111111`

Hostbereik en berekeningen:
- Aantal hostbits: 32 - 26 = 6 bits
- Totaal aantal adressen: 2⁶ = 64
- Bruikbare hostrange: `192.168.1.1` t/m `192.168.1.62`
- Netwerkadres: `192.168.1.0`
- Broadcastadres: `192.168.1.63`




<img src="/assets/classes.png" alt="IPv4 classes" width="600">

### Class A, B, C, D, E

- **Class A**
  - Eerste bit = 0
  - Eerste octet: 0–127
  - Subnetmasker: /8
  - 128 netwerken van elk 16.777.216 adressen

- **Class B**
  - Eerste bit = 1, tweede = 0
  - Eerste octet: 128–191
  - Subnetmasker: /16
  - 16.384 netwerken van elk 65.536 adressen

- **Class C**
  - Eerste bit = 1, tweede = 1, derde = 0
  - Eerste octet: 192–223
  - Subnetmasker: /24
  - 2.097.152 netwerken van elk 256 adressen

### Speciale adressen

- **127.0.0.0 – 127.255.255.255:** Loopback-adressen (localhost/testing)
- **Broadcast-adres:** hostgedeelte = alle bits op 1 (bijv. `.255`)
- **Netwerkadres:** hostgedeelte = alle bits op 0 (bijv. `.0`)  
Deze kunnen **niet** worden toegewezen aan individuele apparaten.