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


## IPV6

Een IPv6 adres is 128 bits en worden geschreven in hexadecimaal. 
voorbeeld:

**2001:0db8:85a3:0000:0000:8a2e:0370:7334**

<img src="/assets/bin-hex.png" alt="Binary to Hexadecimal Conversion">

### IPV6 Adressen


<img src="/assets/RFCipv6.png" alt="IPv6 Addressing" width="600">

Leidende 0s kunnen verwijderd worden.
voorbeeld:

**2001:db8:85a3::8a2e:370:7334**

De :: kan maar één keer in een adres voorkomen. om de leidende nullen te vervangen. Dit komt doordat het anders onduidelijk zou zijn waar de nullen precies vervangen moeten worden. De :: betekent dat er een reeks van 0 blokken is weggelaten.

Het IPv6 adress is in sprongen van 4 bits met 16 bits per blok. In totaal zijn er 128 bits.

#### Global unicast address

48-bit global routing prefix : 
**2001:0db8:85a3::/48** Dit is gegeven door de ISP.

16-bit subnet identifier : **2001:0db8:85a3:***0001*

Dit word gebruikt door een bedrijf om verschillende subnets te maken.
Samen maken deze twee delen het netwerkgedeelte van het IPv6-adress genaamd IPv6 prefix.

**2001:0db8:85a3:0001:0000:0000:0000:0000/64**
**2001:0db8:85a3:1::/64**
De rest van het adres (de laatste 64 bits) is het hostgedeelte en wordt voor **hostidentificatie** gebruikt.

**Thuisnetwerk**

Aanbevolen is dat er een /56 wordt toegewezen door de ISP aan de gebruiker. De gebruiker kan hiermee **256 subnets** maken. Want hij heeft 8 bits over voor subnetting (2^8 = 256).

**Voorbeeld:**
Prefix van ISP:  2001:0DB8:8B00:0000::/56


**Subnets**

- `2001:0DB8:8B00:0000::/64`
- `2001:0DB8:8B00:0001::/64`
- `2001:0DB8:8B00:0002::/64`
- `2001:0DB8:8B00:0003::/64`
- ...
- `2001:0DB8:8B00:00FF::/64`


##### IPv6 prefix vinden

We gaan op zoek naar de prefix van het volgende *address.*

`2001:0DB8:8B00:0001:FB89:017B:0020:0011/93`

- `/93` betekent dat de eerste **93 bits** netwerk zijn.  
- Tot bit **92** zitten we volledig in `017`.  
- De **93e bit** valt in de **`B`** van `017B`.  

**Hex `B` analyseren**
`B` = decimaal 11 = binair `1011`.

| Binair | Betekenis                     |
|--------|--------------------------------|
| `1`    | Hoort nog bij de prefix (/93) |
| `011`  | Wordt hostgedeelte → op nul  |


- `B (1011)` verandert naar `8 (1000)`  
- `017B` wordt daardoor `0178`

Prefix = `2001:DB8:8B00:1:FB89:178::/93`

#### Extended Unique Identifier (EUI-64)

Is een methode om een 48 bits mac adres uit te breiden naar een 64 bits IPv6 adres. Dit wordt gedaan door de MAC-adres in twee delen te splitsen en `FFFE` toe te voegen tussen de twee delen.

**Voorbeeld:**

MAC-adres: `00:1A:2B:3C:4D:5E`

1. Splits het MAC-adres: `00:1A:2B` en `3C:4D:5E`
2. Voeg `FFFE` toe: `00:1A:2B:FF:FE:3C:4D:5E`
3. Verander de 7e bit van het eerste octet: `02:1A:2B:FF:FE:3C:4D:5E`
4. Resultaat: `021A:2BFF:FE3C:4D5E`


**Waarom invert the 7e bit?**

Mac addressen kunnen verdeeld worden in 2 types
**UAA (Universally Administered Address)**
Unique assigned door de fabrikant

**LAA (Locally Administered Address)**
Assigned door de netwerkbeheerder.

Je kan een UAA of LAA identificeren door naar het 7e bit van het eerste octet te kijken(U/L bit). Als het 7e bit een 0 is, is het een UAA. Als het 7e bit een 1 is, is het een LAA.

In de context van IPv6 adressen/EUI-64 is de betekenis omgedraaid. U/L bit 0 betekent nu een LAA en 1 betekent een UAA. 


#### Unique Local Address (ULA)

Dit zijn private IPv6 adressen die alleen binnen een lokaal netwerk gebruikt worden. Ze zijn niet routable op het internet en zijn vergelijkbaar met private IPv4 adressen. Je hoeft ze niet te registreren om ze te gebruiken.

ULA's beginnen altijd met de prefix **FC00::/7**. Dit betekent dat het bereik van ULA's loopt van **FC00:0000:0000:0000:0000:0000:0000:0000** tot **FDFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF**.

Een latere update aan de standaard specificeert dat ULA's moeten beginnen met **FD** in plaats van **FC**. Dit betekent dat de meeste ULA's die je zult tegenkomen, beginnen met **FD**.


#### Link-local address

Altijd automatisch aanwezig op elke interface (fe80::/10)
Geldig alleen binnen één link = één Layer-2 broadcastdomein / VLAN
Niet routeerbaar: routers gebruiken ze wel voor buur-ontdekking en routingprotocollen, maar forwarden ze nooit naar andere links


Link-local adressen beginnen altijd met de prefix **FE80::/10**. Dit betekent dat het bereik van link-local adressen loopt van **FE80:0000:0000:0000:0000:0000:0000:0000** tot **FEBF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF**.

Gebruik van link-local adressen:

- routing protocol peering (OSPFv3 gebruikt link-local voor neighbor adjacencies)
- next-hop addresses voor static routes
- Neighbor discovery protocol(NDP, IPv6 vervanging voor ARP) gebruikt link-local adressen om te functioneren.


#### Communicatietypes

**Unicast**
- **Beschrijving:** Eén bron communiceert met één specifieke bestemming.
- **Voorbeeld:** Een computer stuurt een e-mail naar een andere computer.

**Broadcast**
- **Beschrijving:** Eén bron communiceert met alle apparaten binnen hetzelfde subnet.
- **Voorbeeld:** ARP-verzoeken (Address Resolution Protocol).

**Multicast**
- **Beschrijving:** Eén bron communiceert met meerdere bestemmingen binnen een specifieke groep (multicast group).
- **IPv6 Multicast Range:** FF00::/8
- **Opmerking:** IPv6 gebruikt geen broadcast.

<img src="/assets/multicast.png" alt="Multicast" >

All nodes FF02::1
All routers FF02::2
All OSPF FF02::5
All OSPF DRs/BDR FF02::6
All RIPv6 FF02::9
All EIGRP routers FF02::A

IPPv6 heeft meerdere multicast "scopes" die aangeven hoever een pakket kan reizen binnen een netwerk. De voorbeelden hierboven zijn allemaal link-local scope (FF02) en blijven in lokale link.

**Anycast**
- **Beschrijving:** "1 naar de dichtstbijzijnde" communicatie.
- **Werking:** Meerdere routers zijn geconfigureerd met hetzelfde Anycast-adres, waardoor verkeer naar de dichtstbijzijnde router wordt geleid.
- **IPv6 Specificatie:**
  - Geen specifieke range voor Anycast-adressen.
  - Een unicast-adres (bijv. global unicast of unique local unicast) wordt gebruikt en gespecificeerd als Anycast-adres.


**Scopes en Beschrijvingen**

- **Interface-local (FF01::/16):**
  - Pakket verlaat het apparaat niet.
  - Wordt gebruikt om verkeer naar een service op hetzelfde apparaat te sturen.

- **Link-local (FF02::/16):**
  - Pakket verlaat de lokale link (bijv. VLAN) niet.
  - Wordt gebruikt voor communicatie tussen apparaten op hetzelfde subnet.

- **Site-local (FF05::/16):**
  - Pakket verlaat de site (organisatie) niet.
  - Wordt gebruikt voor communicatie binnen dezelfde organisatie, niet over een WAN.

- **Organisation-local (FF08::/16):**
  - Voor een grotere scope dan site-local, zoals een heel bedrijf met meerdere locaties.

- **Global (FF0E::/16):**
  - Geen grenzen; kan over het internet worden gerouteerd.


| Adres         | Beschrijving                          |
|---------------|---------------------------------------|
| `::1/128`     | Loopback-adres                       |
| `::/128`      | Unspecified-adres                    |
| `::/0`        | Default route                        |
| `::1`         | Loopback-adres (alternatieve notatie) |


#### IPv6 header

<img src="/assets/ipv6header.png" alt="IPv6 Header Format" width="600">

De header is altijd 40 bytes lang. Bij Pv4 is de header meestal 20 bytes, maar kan groter zijn door opties en hierdoor heb je geen veld header in IPv6.

De **version field** is altijd 4 bits lang en geeft de versie van het IP-protocol aan. Voor IPv6 is deze waarde altijd 6.

De **Traffic Class field** is ook 8 bits lang en wordt gebruikt om het verkeer te classificeren voor Quality of Service (QoS) doeleinden.

De **Next Header field** is 8 bits lang en geeft aan welk type header direct volgt op de IPv6-header. Dit kan bijvoorbeeld een TCP- of UDP-header zijn.

**Hop limit field** is 8 bits lang en geeft aan hoeveel hops (routers) een pakket mag passeren voordat het wordt verworpen. Dit is vergelijkbaar met het TTL (Time to Live) veld in IPv4.

**Source Address field** is 128 bits lang en geeft het IPv6-adres van de zender aan.

**Destination Address field** is 128 bits lang en geeft het IPv6-adres van de bestemming aan.



### NDP (Neighbor Discovery Protocol)

**Solicited-node multicast address:** 

FF02::1:FFXX:XXXX
- Wordt gebruikt voor het bereiken van een specifieke host binnen een link-local scope.
- De laatste 24 bits (6 hexadecimale cijfers) van het adres zijn afgeleid van het IPv6-adres van de host.

<img src="/assets/sollicited-node.png" alt="Solicited-node multicast address">

Neighbor Discovery Protocol is een protocol binnen IPv6 dat je kunt vergelijken met ARP (Address Resolution Protocol) in IPv4. 

Gebruikt ICMPv6 & sollicited-node multicast addressen om de MAC-adressen van andere hosts te ontdekken.


Neighbor Solicitation (NS) = ICMPv6 type 135
Neighbor Advertisement (NA) = ICMPv6 type 136

#### Neighbor Solicitation (NS)

R1 stuurt een Neighbor Solicitation (NS) bericht naar de solicited-node multicast address van R2 om het MAC-adres van R2 te achterhalen. "Wat is je MAC-adres?"

Source IP: R1's IPv6-adres
Destination IP: FF02::1:FFXX:XXXX (R2's solicited-node multicast address)
Source MAC: R1's MAC-adres
Destination MAC: Multicast MAC gebaseerd op R2's solicited-node multicast address

Let op: Dit is multicast & geen broadcast! Broadcast bestaat niet in IPv6.


#### Neighbor Advertisement (NA)

R2 ontvangt het Neighbor Solicitation (NS) bericht van R1 en reageert met een Neighbor Advertisement (NA) bericht om zijn MAC-adres bekend te maken.

Source IP: R2's IPv6-adres
Destination IP: R1's IPv6-adres
Source MAC: R2's MAC-adres
Destination MAC: R1's MAC-adres

R2 weet deze informatie door het ontvangen van het Neighbor Solicitation (NS) bericht van R1.


**IPV6 Neighbor Table**

IPv6 Neighbor Table van R1

  **IPv6 Address**         **MAC Address**   **Interface**
  ------------------------ ----------------- ---------------
  Global IPv6 van R2       MAC van R2        Gig0/0
  Link-local IPv6 van R2   MAC van R2        Gig0/0
------------------------------------------------------------------------

IPv6 Neighbor Table van R2

  **IPv6 Address**         **MAC Address**   **Interface**
  ------------------------ ----------------- ---------------
  Global IPv6 van R1       MAC van R1        Gig0/1
  Link-local IPv6 van R1   MAC van R1        Gig0/1
------------------------------------------------------------------------

#### Router Solicitation (RS)

Een Router Solicitation (RS) bericht wordt verzonden door een host om routers op het lokale netwerk te ontdekken. Dit gebeurt meestal wanneer een apparaat voor het eerst op het netwerk wordt aangesloten of wanneer het zijn netwerkconfiguratie opnieuw wil ophalen.

**Router Solicitation = ICMPv6 type 133**

Verstuurd naar multicast adres FF02::2 (all routers)
Vraagt alle routers op de lokale link om zichzelf bekend te maken.
Wordt verstuurt wanneer een interface wordt enabled of een host wordt geconnecteerd aan het netwerk.


Routers die het RS-bericht ontvangen, reageren met een Router Advertisement (RA) bericht om hun aanwezigheid en configuratie-informatie bekend te maken.

**Router Advertisement = ICMPv6 type 134**

Verstuurt naar multicast adres FF02::1 (all nodes)
De router maakt zijn aanwezigheid en configuratie-informatie bekend aan alle hosts op de lokale link.
Deze wordt verstuurt als antwoord op een Router Solicitation (RS) bericht.
Ze worden ook regelmatig verzonden zonder een RS-bericht.

#### SLAAC (Stateless Adress Auto-configuration)

Hosts gebruiken RS/RA berichten om de IPv6 prefix van de lokale link te leren en op basis hiervan automatisch een IPv6-adres te genereren. Meestal zal het gebruik maken van EUI-64.


**Duplicate Address Detection (DAD)**

Staat hosts toe om te checken of er andere devices op de lokale link zijn die hetzelfde IP address gebruiken. Dit gebeurt door het verzenden van een Neighbor Solicitation (NS) bericht met het te controleren IP-adres als doel. Als er geen antwoord komt, is het IP-adres uniek en kan het worden gebruikt.

**Routes for link local adressen gaan niet in de routing table.**

