# Network Protocols

## Inleiding

Dit document behandelt netwerkprotocollen, communicatie, OSI- en TCP/IP-modellen, protocol data units, en de werking van de Data Link Layer. 

## Communicatieregels

Voordat apparaten kunnen communiceren, moeten ze afspraken maken over hoe die communicatie verloopt. Dit gebeurt aan de hand van standaarden en protocollen, zoals:

- Een bekende zender en ontvanger
- Een afgesproken taal & grammatica
- Snelheid & timing van aflevering
- Bevestiging van ontvangst

Belangrijke aspecten van communicatie zijn onder andere **message encoding** (hoe data wordt gecodeerd, zoals ASCII of UTF-8), **message formatting** (structuur van berichten, bijvoorbeeld JSON of XML), **message size** (maximale grootte), **message timing** (wanneer berichten worden verzonden, toegangsmethode, flow control, responstijd) en **message acknowledgment** (bevestiging van ontvangst).

### Message Delivery-opties

- **Unicast:** Eén zender naar één ontvanger.
- **Multicast:** Eén zender naar meerdere specifieke ontvangers.
- **Broadcast:** Eén zender naar alle ontvangers in het netwerk.
- **Anycast:** Eén zender naar de dichtstbijzijnde ontvanger in een groep.

## Netwerkmodellen: OSI vs TCP/IP

Netwerkmodellen helpen bij het structureren van communicatieprotocollen en standaarden. De twee bekendste modellen zijn het OSI-model en het TCP/IP-model.

| OSI-laag         | Voorbeelden                                  | TCP/IP-laag      | Voorbeelden                                          |
|------------------|----------------------------------------------|------------------|------------------------------------------------------|
| 7. Application   | HTTP, FTP, SMTP, DNS, POP3, IMAP             | Application      | HTTP, FTP, SMTP, DNS, POP3, IMAP                     |
| 6. Presentation  | SSL/TLS, JPEG, MPEG, ASCII, GIF              | Application      | SSL/TLS, JPEG, MPEG, ASCII, GIF                      |
| 5. Session       | NetBIOS, RPC, PPTP, SMB                      | Application      | NetBIOS, RPC, PPTP, SMB                              |
| 4. Transport     | TCP, UDP                                     | Transport        | TCP, UDP                                             |
| 3. Network       | IP, ICMP, ARP, IPsec, IGMP                   | Internet         | IP, ICMP, ARP, IPsec, IGMP                           |
| 2. Data Link     | Ethernet, PPP, Frame Relay, VLAN, MAC, Wi-Fi | Network Access   | Ethernet, PPP, Frame Relay, VLAN, MAC, Wi-Fi         |
| 1. Physical      | UTP, Fiber, Hubs, Repeaters, Voltage, BT     | Network Access   | UTP, Fiber, Hubs, Repeaters, Voltage, Bluetooth      |

*De bovenste drie OSI-lagen (Application, Presentation, Session) zijn samengevoegd tot de Application-laag in het TCP/IP-model. De onderste twee OSI-lagen (Data Link, Physical) zijn samengevoegd tot de Network Access-laag in het TCP/IP-model.*

#### Ezelbruggetjes
- OSI: "All people seem to need data processing"
- TCP/IP: "All Turtles In New York"

### Functies van de OSI-lagen

- **Application:** process-to-process communicatie
- **Presentation:** representatie van data tussen application layer services, zoals codering en compressie
- **Session:** organisatie van communicatie
- **Transport:** applicatie-tot-applicatie communicatie
- **Network:** host-to-host communicatie, routering
- **Data Link:** node-to-node communicatie, framing, MAC-adressen
- **Physical:** fysieke verbindingen, elektrische signalen

## Protocol Data Units (PDU's) en Encapsulation

### PDU's per laag

- Application/Presentation/Session: data
- Transport: segment = L4 header + data
- Network: packet = L3 header + segment (L4 header + data)
- Data Link: frame = L2 header + packet (L3 + L4 + data) + L2 trailer
- Physical: bits → het frame wordt verzonden als elektrische/optische signalen

### Encapsulation

Toevoegen van headers en trailers aan PDU's bij elke laag.  
- Van boven naar beneden: data → segment → packet → frame → bit

### Decapsulation

Verwijderen van headers en trailers bij ontvangst.  
- Van beneden naar boven: bit → frame → packet → segment → data

## TCP/IP Protocol Suite

De TCP/IP protocol suite vormt de basis voor internetcommunicatie en bestaat uit vier lagen:

| Laag           | Functie                                                        | Protocollen/Technologieën             |
|----------------|----------------------------------------------------------------|---------------------------------------|
| Application    | Datavoorstelling, codering, dialoogbeheer voor de gebruiker    | HTTP, FTP, SMTP, DNS, DHCP, SNMP      |
| Transport      | Application-to-application communicatie tussen hosts           | TCP (betrouwbaar), UDP (snel)         |
| Internet       | Host-to-host communicatie over verschillende netwerken         | IPv4, IPv6, ICMP, ARP                 |
| Network Access | Node-to-node communicatie via fysieke media                    | Ethernet, Wi-Fi, MAC-adressen         |

### PDU's in TCP/IP

| Laag           | PDU     |
|----------------|---------|
| Application    | Data    |
| Transport      | Segment |
| Internet       | Packet  |
| Network Access | Frame   |

## Data Link Layer (Layer 2)

De Data Link Layer (L2) is verantwoordelijk voor communicatie tussen directe buren in een netwerk. Het zorgt voor betrouwbare overdracht van frames over fysieke verbindingen en bevat protocollen zoals Ethernet, Wi-Fi en PPP.

Accepteert Layer 3 packets en voegt een Layer 2 header en trailer toe om een frame te creëren. De header bevat informatie zoals bron- en bestemmings-MAC-adressen, terwijl de trailer vaak een Frame Check Sequence (FCS) bevat voor foutdetectie.

### Sublayers van de Data Link Layer

#### Logical Link Control (LLC)

- Beheert communicatie tussen de netwerklaag en de datalinklaag.
- Plaatst informatie in het frame dat duidelijk maakt welk layer 3 protocol wordt gebruikt (bijvoorbeeld IPv4 of IPv6).
- Maakt samenwerking mogelijk van verschillende layer 3 protocollen op dezelfde datalinklaag.

#### Media Access Control (MAC)

- Definieert hoe apparaten toegang krijgen tot het fysieke medium.
- Zorgt voor data link layer adressing via unieke MAC-adressen voor netwerkinterfaces.
- MAC-adressen zijn 48-bits en vaak in hex weergegeven (bijv. `00:1A:2B:3C:4D:5E`).
- MAC-adressen adresseren frames binnen een lokaal netwerk.
- OUI (Organizationally Unique Identifier) = eerste 24 bits van een MAC-adres (fabrikant).

Voorbeeld: `00:1A:2B` (OUI) wijst op fabrikant Apple.

### Frame Structure

**Generieke structuur van een frame:**
- Start en stop indicator flags (L1)
- Addressing: bron en bestemming MAC-adressen
- Type/Protocol: welk Layer 3 protocol in de data field (bijv. IPv4, IPv6)
- Controle: quality of service (QOS), prioriteit of vertraging
- Data: frame payload, packet header, segment header, daadwerkelijke data
- Error Detection: foutdetectie (na de data)

> Elke keer als je een router passeert, verandert het frame maar het IP-pakket blijft hetzelfde.

#### Frame Types

- Ethernet
- 802.11 Wireless
- PPP (Point-to-Point Protocol)
- HDLC (High-Level Data Link Control)
- Frame Relay

**Runts** zijn frames < 64 bytes (vaak fouten of verkeerde config).  
**Giants** zijn > 1518 bytes (of 9000 bytes voor jumbo frames).

---

