# Network Layer (Layer 3)

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken. Het belangrijkste protocol op deze laag is het Internet Protocol (IP), dat zorgt voor adressering en routering van pakketten. Binnen deze laag zijn IP-adressen essentieel voor het identificeren van apparaten, en wordt veel gebruik gemaakt van subnetting om netwerken logisch in te delen.

---

## IPv4, Adressering en Subnetting

### Adressering en Binaire Notatie

IPv4-adressen bestaan uit 32 bits en worden weergegeven als vier groepen van 8 bits (octets), gescheiden door punten, bijvoorbeeld: `192.168.1.254`. Elk octet kan een waarde aannemen van 0 tot 255. In binaire notatie loopt dit van **00000000** (decimaal 0) tot **11111111** (decimaal 255). Binaire representatie betekent dat je elk getal alleen met nullen en enen weergeeft; zo is 192 bijvoorbeeld **11000000**.

<img src="/assets/base2.png" alt="Binary Representation" width="600">

**Voorbeeld:**  
Het getal 192 wordt in binaire notatie als volgt opgebouwd:  
- 192 past in 128, dus eerste bit is 1  
- 64 past niet, tweede bit is 0  
- 32 past, derde bit is 1  
- 16 past niet, vierde bit is 0  
- 8 past niet, vijfde bit is 0  
- 4 past, zesde bit is 0  
- 2 past, zevende bit is 0  
- 1 past niet, achtste bit is 0  
Dus, 192 = **11000000**

Ook andersom kun je van binair naar decimaal rekenen door de waarde van elk '1'-bit bij elkaar op te tellen.

<img src="/assets/base2-2.png" alt="Binary Representation 2" width="600">

Een byte bestaat dus uit 8 bits en kan maximaal 256 verschillende waarden bevatten.

---

### IPv4 Header en Adresstructuur

De IPv4-header bevat de essentiële informatie voor het routeren van IP-pakketten, waaronder het bron- en bestemmingsadres, fragmentatie, controle, TTL en het protocoltype (zoals TCP of UDP). De header heeft een minimale grootte van 20 bytes en kan uitbreiden tot 60 bytes bij gebruik van opties. Het adres zelf is altijd 32 bits lang, wat overeenkomt met vier octetten.

<img src="/assets/ipv4header.png" alt="IPv4 Header Format" width="600">

IPv4-adressen worden meestal in decimale notatie weergegeven, bijvoorbeeld:  
**192.168.1.254**  
In binaire vorm: `11000000.10101000.00000001.11111110`

Private IPv4-adressen zijn adressen die niet op het openbare internet worden gebruikt, maar binnen lokale netwerken. De drie grote blokken private adressen zijn:

| Range                        | Subnetmasker     | CIDR           |
|------------------------------|------------------|----------------|
| 10.0.0.0 – 10.255.255.255    | 255.0.0.0        | 10.0.0.0/8     |
| 172.16.0.0 – 172.31.255.255  | 255.240.0.0      | 172.16.0.0/12  |
| 192.168.0.0 – 192.168.255.255| 255.255.0.0      | 192.168.0.0/16 |

---

### Subnetting en CIDR in de Praktijk

Subnetting betekent het verdelen van een groot netwerk in kleinere subnetten. Dit gebeurt met behulp van een subnetmasker of met CIDR-notatie (Classless Inter-Domain Routing), waarbij je na een schuine streep het aantal netwerkbits aangeeft (zoals `/24`).

CIDR en subnetmaskers helpen bepalen hoeveel hosts in een subnet passen en hoe je een netwerk logisch kunt opdelen. Bijvoorbeeld:
- `/24` betekent 255.255.255.0, oftewel 256 adressen waarvan er 254 bruikbaar zijn voor hosts (de eerste is het netwerkadres, de laatste is broadcast).
- `/26` betekent 255.255.255.192, ofwel 64 adressen waarvan 62 bruikbaar voor hosts.

#### Omrekenen en Voorbeelden

Om van een subnetmasker naar CIDR te gaan tel je het aantal ‘1’-bits in het masker. Bijvoorbeeld:  
- 255.255.240.0 → 8+8+4=**/20**  
- 255.255.252.0 → 8+8+6=**/22**

Om van CIDR naar het aantal adressen te gaan:  
- **Formule:** `2^(32 - CIDR)`  
- `/24`: 2^8 = 256 adressen, 254 bruikbaar  
- `/28`: 2^4 = 16 adressen, 14 bruikbaar

Om van aantal hosts naar CIDR te gaan:  
- Tel 2 bij het gewenste aantal hosts op (voor netwerk en broadcast)
- Zoek de kleinste macht van 2 die dit aantal dekt, en trek het aantal benodigde bits van 32 af.

Voorbeeld: 50 hosts nodig → 50+2=52 → eerstvolgende macht van 2 is 64 (2^6) → 32-6=**/26**

### Veelgebruikte Subnetvoorbeelden

Hieronder vind je de meest gangbare subnets, met binaire, decimale en rekenvoorbeelden:


**/8 subnet:**

/8: 11111111.00000000.00000000.00000000

**CIDR:** /8  
**Subnet Mask:** 255.0.0.0  
**Network bits:** 8  
**Host bits:** 32 - 8 = 24 bits  
**Total addresses:** 2²⁴ = 16,777,216 = 256 x 256 x 256  
**Usable hosts:** 16,777,216 - 2 = 16,777,214


**/16 subnet:**

/16: 11111111.11111111.00000000.00000000

**CIDR:** /16  
**Subnet Mask:** 255.255.0.0  
**Network bits:** 16  
**Host bits:** 32 - 16 = 16 bits  
**Total addresses:** 2¹⁶ = 65,536 = 256 x 256  
**Usable hosts:** 65,536 - 2 = 65,534


**/24 subnet:**

/24: 11111111.11111111.11111111.00000000

**CIDR:** /24  
**Subnet Mask:** 255.255.255.0  
**Network bits:** 24  
**Host bits:** 32 - 24 = 8 bits  
**Total addresses:** 2⁸ = 256  
**Usable hosts:** 256 - 2 = 254


**/26 subnet:**

/26: 11111111.11111111.11111111.11000000
(255) (255) (255) (192)
|----------- Network ----------|Host|

**CIDR:** /26  
**Subnet Mask:** 255.255.255.192  
**Network bits:** 26  
**Host bits:** 32 - 26 = 6 bits  
**Total addresses:** 2⁶ = 64  
**Usable hosts:** 64 - 2 = 62


#### Sprongberekening

Met de sprongberekening kun je snel subnetgrenzen vinden:  
- **Sprong = 256 - waarde van het octet dat geen 255 is in het subnetmasker**  
- Voorbeeld: 255.255.240.0 → 256-240=16, dus subnetten lopen van .0, .16, .32, enzovoort.

---

### Subnetting Tabellen en Overzicht

| CIDR | Subnetmasker        | Aantal hosts |
|------|---------------------|--------------|
| /24  | 255.255.255.0       | 254          |
| /25  | 255.255.255.128     | 126          |
| /26  | 255.255.255.192     | 62           |
| /27  | 255.255.255.224     | 30           |
| /28  | 255.255.255.240     | 14           |
| /29  | 255.255.255.248     | 6            |
| /30  | 255.255.255.252     | 2            |

**Voorbeeld uitwerking:**  
Netwerk `192.168.1.0/24` opgesplitst in `/26`:
- `192.168.1.0/26`   = 192.168.1.0 – 192.168.1.63 (62 hosts)
- `192.168.1.64/26`  = 192.168.1.64 – 192.168.1.127 (62 hosts)
- `192.168.1.128/26` = 192.168.1.128 – 192.168.1.191 (62 hosts)
- `192.168.1.192/26` = 192.168.1.192 – 192.168.1.255 (62 hosts)

---

### Klassen en Speciale Adressen

Historisch werden IPv4-adressen in klassen ingedeeld (A, B, C), maar dankzij CIDR is dat minder relevant geworden. Toch is het goed de ranges te kennen:

| Klasse | Eerste octet | Subnetmasker   | Adressen per netwerk |
|--------|--------------|----------------|---------------------|
| A      | 0-127        | 255.0.0.0 (/8) | 16.777.216          |
| B      | 128-191      | 255.255.0.0    | 65.536              |
| C      | 192-223      | 255.255.255.0  | 256                 |

Speciale adressen zijn:
- **Loopback:** 127.0.0.0 - 127.255.255.255
- **Broadcast:** Het hoogste adres binnen een subnet (bijv. 192.168.1.255)
- **Netwerkadres:** Het laagste adres binnen een subnet (bijv. 192.168.1.0)

---

## Belangrijkste punten

- De Network Layer verzorgt routering en adressering.
- IPv4-adressen zijn 32 bits, meestal genoteerd als vier decimale getallen.
- Private adressen zijn bedoeld voor intern gebruik, niet publiek routeerbaar.
- Subnetting via CIDR en subnetmaskers is essentieel voor een efficiënte netwerkopbouw.
- Tabellen, sprongberekeningen en binaire notatie maken subnetting inzichtelijk en toepasbaar.

---
