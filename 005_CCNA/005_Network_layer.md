# Network Layer (Laag 3)

## Overzicht

De Network Layer is verantwoordelijk voor het routeren van data tussen verschillende netwerken. Het belangrijkste protocol is het Internet Protocol (IP), dat zorgt voor adressering en routering van pakketten. Op deze laag zijn IP-adressen essentieel voor het identificeren van apparaten, en subnetting wordt veel gebruikt om netwerken logisch in te delen.

## IPv4, Adressering & Subnetting

### Adressering en binaire notatie

IPv4-adressen bestaan uit 32 bits en worden genoteerd als vier groepen van 8 bits (octets), gescheiden door punten, bijvoorbeeld: `192.168.1.254`.  
Elk octet varieert van 0 tot 255. In binaire notatie loopt dit van **00000000** (0) tot **11111111** (255).  
Binaire representatie betekent dat elk decimaal getal wordt weergegeven in enen en nullen. Bijvoorbeeld:  
- 192 = **11000000**

Je telt de waarde van elk '1'-bit bij elkaar op om van binair naar decimaal te rekenen.

> Een byte is 8 bits en kent 256 mogelijke waarden.

### IPv4-header en adresstructuur

De IPv4-header bevat de essentiële informatie voor het routeren van IP-pakketten, zoals bron- en bestemmingsadres, fragmentatie, TTL en het protocoltype (bijv. TCP/UDP).  
De header heeft een minimale grootte van 20 bytes en kan tot 60 bytes uitbreiden door opties.

Een IPv4-adres is altijd 32 bits lang, overeenkomend met vier octetten.  
In decimale notatie: `192.168.1.254`  
In binair: `11000000.10101000.00000001.11111110`

### Private IPv4-adressen

Private adressen zijn niet voor het publieke internet, maar voor intern gebruik.  
De drie grote blokken:

| Range                        | Subnetmasker     | CIDR           |
|------------------------------|------------------|----------------|
| 10.0.0.0 – 10.255.255.255    | 255.0.0.0        | 10.0.0.0/8     |
| 172.16.0.0 – 172.31.255.255  | 255.240.0.0      | 172.16.0.0/12  |
| 192.168.0.0 – 192.168.255.255| 255.255.0.0      | 192.168.0.0/16 |

## Subnetting & CIDR

### Praktische uitleg

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

- `/24` betekent 255.255.255.0: 256 adressen waarvan 254 bruikbaar voor hosts
- `/26` betekent 255.255.255.192: 64 adressen waarvan 62 bruikbaar

**Omrekenen subnetmasker naar CIDR:** tel het aantal ‘1’-bits  
- 255.255.240.0 → 20 bits (8+8+4) = `/20`
- 255.255.252.0 → 22 bits (8+8+6) = `/22`

**Aantal adressen per subnet:** `2^(32 - CIDR)`  
- `/24`: 2^8 = 256 adressen, 254 bruikbaar  
- `/28`: 2^4 = 16 adressen, 14 bruikbaar

**Aantal hosts naar CIDR:**  
- Tel 2 bij het gewenste aantal hosts (voor netwerk & broadcast)
- Zoek de eerstvolgende macht van 2 die dit aantal dekt, en trek het aantal benodigde bits van 32 af.

Voorbeeld:  
- 50 hosts nodig → 50+2=52  
- Eerstvolgende macht van 2 is 64 (2^6)  
- 32-6= `/26`

### Sprongberekening

De sprong is het verschil tussen subnetten in een bepaald octet.  
Formule: **Sprong = 256 - waarde van het subnetmasker-octet dat geen 255 is**  
Voorbeeld: 255.255.240.0 → 256-240=16, dus subnetten lopen van .0, .16, .32, enzovoort.

### Veelgebruikte subnetvoorbeelden

| CIDR | Subnet Mask       | Netwerkbits | Hostbits | Total adresses | Usable hosts  |
|------|-------------------|-------------|----------|---------------|--------------|
| /8   | 255.0.0.0         | 8           | 24       | 16.777.216    | 16.777.214   |
| /16  | 255.255.0.0       | 16          | 16       | 65.536        | 65.534       |
| /24  | 255.255.255.0     | 24          | 8        | 256           | 254          |
| /26  | 255.255.255.192   | 26          | 6        | 64            | 62           |

#### Hoe worden de subnetadressen bepaald?

| Subnetbits | Berekening        | Decimaal | Subnetadres        |
|------------|-------------------|----------|--------------------|
|    00      | 0×128 + 0×64      |   0      | 192.168.1.0        |
|    01      | 0×128 + 1×64      |  64      | 192.168.1.64       |
|    10      | 1×128 + 0×64      | 128      | 192.168.1.128      |
|    11      | 1×128 + 1×64      | 192      | 192.168.1.192      |

Elke combinatie van de 2 subnetbits geeft een ander subnet. Je telt de waarde van elk "subnetbit" op als deze bit op 1 staat in het binaire subnetnummer.

#### Complete subnetoverzicht `/26`

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

## Klassen en speciale adressen

Historisch werden IPv4-adressen in klassen ingedeeld (A, B, C). Met CIDR is dat minder relevant, maar goed om te kennen:

| Klasse | Eerste octet | Subnetmasker   | Adressen per netwerk |
|--------|--------------|----------------|---------------------|
| A      | 0-127        | 255.0.0.0 (/8) | 16.777.216          |
| B      | 128-191      | 255.255.0.0    | 65.536              |
| C      | 192-223      | 255.255.255.0  | 256                 |

Speciale adressen:
- **Loopback:** 127.0.0.0 - 127.255.255.255
- **Broadcast:** Hoogste adres binnen een subnet (bijv. 192.168.1.255)
- **Netwerkadres:** Laagste adres binnen een subnet (bijv. 192.168.1.0)

---