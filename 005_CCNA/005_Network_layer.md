# Network Layer (Layer 3)

## Overzicht

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken. Het belangrijkste protocol is het Internet Protocol (IP), dat zorgt voor adressering en routering van pakketten. Op deze laag zijn IP-adressen essentieel voor het identificeren van apparaten, en subnetting wordt veel gebruikt om netwerken logisch in te delen.

## IPv4-adressering & binaire representatie

### Wat is binaire representatie?

Binaire representatie is een manier om getallen weer te geven met alleen de cijfers 0 en 1. In binaire notatie wordt elk cijfer (bit) een macht van 2, waarbij de rechterkant de laagste macht is (2⁰) en de linkerkant de hoogste macht is.

### Voorbeeld: decimaal naar binair

Laten we het getal 192 en 168 in binaire vorm bekijken:

<img src="/assets/base2.png" alt="Binary Representation" width="600">

**Uitleg binaire representatie van 192:**
- 192 past in 128 → eerste bit is 1
- 64 past niet → tweede bit is 0
- 32 past → derde bit is 1
- 16 past niet → vierde bit is 0
- 8 past niet → vijfde bit is 0
- 4 past → zesde bit is 1
- 2 past niet → zevende bit is 0
- 1 past niet → achtste bit is 0  
→ **11000000**

<img src="/assets/base2-2.png" alt="Binary Representation 2" width="600">

**Uitleg binaire representatie van 168:**
- 168 past in 128 → eerste bit is 1
- 40 over, 64 past niet → tweede bit is 0
- 32 past → derde bit is 1
- 8 over, 16 past niet → vierde bit is 0
- 8 past → vijfde bit is 1
- 0 over, 4/2/1 passen niet → zesde, zevende, achtste bit zijn 0  
→ **10101000**

### Voorbeeld: binair naar decimaal

<img src="/assets/binary1.png" alt="binary1" width="600">

- **11000000** = 128 + 64 = **192**
- **10101000** = 128 + 32 + 8 = **168**
- **01110110** = 64 + 32 + 16 + 4 + 2 = **118**

> Een **byte bestaat uit 8 bits** en kan waarden aannemen van 0 tot 255 (00000000–11111111).

---

## IPv4: structuur, header & private adressen

### IPv4-adressen en binaire notatie

IPv4-adressen bestaan uit 32 bits en worden genoteerd als vier groepen van 8 bits (octets), gescheiden door punten, bijvoorbeeld: `192.168.1.254`.  
Elk octet varieert van 0 tot 255 (00000000–11111111).  
Voorbeeld:  
- Decimaal: `192.168.1.254`  
- Binair: `11000000.10101000.00000001.11111110`

### IPv4-header en adresstructuur

De IPv4-header bevat essentiële informatie voor het routeren van IP-pakketten, zoals bron- en bestemmingsadres, fragmentatie, TTL en het protocoltype (bijv. TCP/UDP).  
- Minimaal: 20 bytes, maximaal 60 bytes.

#### IPv4 Header Format

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

#### Uitleg van IPv4-header velden

- **Version** (4 bits): IPv4 (4) of IPv6 (6)
- **IHL** (4 bits): Headerlengte (min. 5 = 20 bytes, max. 15 = 60 bytes)
- **DSCP** (6 bits): Quality of Service
- **ECN** (2 bits): Congestie-aanduiding
- **Total Length** (16 bits): Totale lengte (header + payload)
- **Identification** (16 bits): Nummer voor fragmentatieherkenning
- **Flags** (3 bits): Fragmentatiecontrole
- **Fragment Offset** (13 bits): Positie fragment
- **TTL** (8 bits): Time To Live
- **Protocol** (8 bits): L4-protocol (TCP=6, UDP=17, ICMP=1, OSPF=89)
- **Header Checksum** (16 bits): Foutcontrole header
- **Source/Destination Address** (32 bits + 32 bits): Afzender/ontvanger IP
- **Options + Padding**: Optioneel

#### Grootte van IPv4-header

- **Minimaal:** 20 bytes (IHL = 5)  
- **Maximaal:** 60 bytes (IHL = 15)

### Private IPv4-adressen

Private adressen zijn niet voor het publieke internet, maar voor intern gebruik.

| Range                        | Subnetmasker     | CIDR           |
|------------------------------|------------------|----------------|
| 10.0.0.0 – 10.255.255.255    | 255.0.0.0        | 10.0.0.0/8     |
| 172.16.0.0 – 172.31.255.255  | 255.240.0.0      | 172.16.0.0/12  |
| 192.168.0.0 – 192.168.255.255| 255.255.0.0      | 192.168.0.0/16 |

---

## Subnetting & CIDR

### Basis subnetting

Subnetting is het opdelen van een groot netwerk in kleinere subnetten. Dit gebeurt via een subnetmasker of CIDR-notatie (Classless Inter-Domain Routing).  
Bij CIDR geeft het getal achter de schuine streep het aantal netwerkbits aan, bijvoorbeeld `/24`.

| CIDR | Subnetmasker        | Aantal hosts |
|------|---------------------|--------------|
| /24  | 255.255.255.0       | 254          |
| /25  | 255.255.255.128     | 126          |
| /26  | 255.255.255.192     | 62           |
| /27  | 255.255.255.224     | 30           |
| /28  | 255.255.255.240     | 14           |
| /29  | 255.255.255.248     | 6            |
| /30  | 255.255.255.252     | 2            |

- `/24`: 256 adressen, 254 bruikbaar voor hosts  
- `/26`: 64 adressen, 62 bruikbaar

#### Subnetmasker ↔ CIDR omrekenen

- 255.255.240.0 → 20 bits (8+8+4) = `/20`
- 255.255.252.0 → 22 bits (8+8+6) = `/22`

#### Aantal adressen/hosts per subnet

- **Adressen per subnet:** `2^(32 - CIDR)`  
- **Hosts per subnet:** adressen - 2 (netwerk + broadcast)

**Voorbeeld:**  
- 50 hosts nodig → 50+2=52  
- Eerstvolgende macht van 2 is 64 (2^6)  
- 32-6= `/26`

255.255.255.0
### Sprongberekening

De sprong is het verschil tussen subnetten in een bepaald octet.  
**Sprong = 256 - waarde van het subnetmasker-octet dat geen 255 is**  
Voorbeeld: 255.255.240.0 → 256-240=16, dus subnetten lopen van .0, .16, .32, enzovoort.

### Veelgebruikte subnetvoorbeelden

| CIDR | Subnet Mask       | Netwerkbits | Hostbits | Total adresses | Usable hosts  |
|------|-------------------|-------------|----------|---------------|--------------|
| /8   | 255.0.0.0         | 8           | 24       | 16.777.216    | 16.777.214   |
| /16  | 255.255.0.0       | 16          | 16       | 65.536        | 65.534       |
| /24  | 255.255.255.0     | 24          | 8        | 256           | 254          |
| /26  | 255.255.255.192   | 26          | 6        | 64            | 62           |

### Hoe worden subnetadressen bepaald?

| Subnetbits | Berekening        | Decimaal | Subnetadres        |
|------------|-------------------|----------|--------------------|
|    00      | 0×128 + 0×64      |   0      | 192.168.1.0        |
|    01      | 0×128 + 1×64      |  64      | 192.168.1.64       |
|    10      | 1×128 + 0×64      | 128      | 192.168.1.128      |
|    11      | 1×128 + 1×64      | 192      | 192.168.1.192      |

Elke combinatie van de 2 subnetbits geeft een ander subnet. Je telt de waarde van elk "subnetbit" op als deze bit op 1 staat in het binaire subnetnummer.

#### Subnetoverzicht `/26`

| Subnet            | Netwerkadres     | Eerste host      | Laatste host     | Broadcastadres    |
|-------------------|------------------|------------------|------------------|-------------------|
| 192.168.1.0/26    | 192.168.1.0      | 192.168.1.1      | 192.168.1.62     | 192.168.1.63      |
| 192.168.1.64/26   | 192.168.1.64     | 192.168.1.65     | 192.168.1.126    | 192.168.1.127     |
| 192.168.1.128/26  | 192.168.1.128    | 192.168.1.129    | 192.168.1.190    | 192.168.1.191     |
| 192.168.1.192/26  | 192.168.1.192    | 192.168.1.193    | 192.168.1.254    | 192.168.1.255     |

#### Broadcastadressen in binair

| Subnet            | Broadcastadres    | Binair (laatste octet) |
|-------------------|------------------|------------------------|
| 192.168.1.0/26    | 192.168.1.63     | `00111111`             |
| 192.168.1.64/26   | 192.168.1.127    | `01111111`             |
| 192.168.1.128/26  | 192.168.1.191    | `10111111`             |
| 192.168.1.192/26  | 192.168.1.255    | `11111111`             |

---

## Klassen & speciale adressen

### IP-klassen (historisch)

| Klasse | Eerste octet | Subnetmasker   | Adressen per netwerk |
|--------|--------------|----------------|---------------------|
| A      | 0-127        | 255.0.0.0 (/8) | 16.777.216          |
| B      | 128-191      | 255.255.0.0    | 65.536              |
| C      | 192-223      | 255.255.255.0  | 256                 |

### Speciale adressen

- **Loopback:** 127.0.0.0 - 127.255.255.255
- **Broadcast:** Hoogste adres binnen een subnet (bijv. 192.168.1.255)
- **Netwerkadres:** Laagste adres binnen een subnet (bijv. 192.168.1.0)

