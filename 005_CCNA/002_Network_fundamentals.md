## Network Fundamentals

1. **Afspraken voor communicatie**  
   Voordat apparaten kunnen communiceren, moeten ze afspraken maken over hoe dat verloopt: een bekende zender en ontvanger, een afgesproken taal en grammatica, snelheid en timing van aflevering, en bevestiging van ontvangst.  

2. **Belangrijke aspecten**  
   Message encoding: hoe data wordt gecodeerd (bv. ASCII of UTF-8).  
   Message formatting: structuur van berichten (bv. JSON of XML).  
   Message size: maximale grootte van een bericht.  
   Message timing: wanneer berichten worden verzonden (toegangsmethode, flow control, responstijd).  
   Message acknowledgment: bevestiging van ontvangst.  

3. **Message Delivery-opties**  
   Unicast: één zender naar één ontvanger.  
   Multicast: één zender naar meerdere specifieke ontvangers.  
   Broadcast: één zender naar alle ontvangers in het netwerk.  
   Anycast: één zender naar de dichtstbijzijnde ontvanger in een groep.  


#### Netwerkmodellen: OSI vs TCP/IP

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

> OSI: "All people seem to need data processing"
> TCP/IP: "All Turtles In New York"

#### Functies van de OSI-lagen

1. **Application**  
   Process-to-process communicatie. Zorgt voor netwerkservices richting de gebruiker.  
   *Voorbeeld:* webbrowser die HTTP gebruikt of e-mail via SMTP.  

2. **Presentation**  
   Zorgt voor representatie van data, codering, compressie en versleuteling.  
   *Voorbeeld:* TLS/SSL versleutelt HTTPS-verkeer, JPEG/MP3 comprimeren bestanden.  

3. **Session**  
   Organiseert de communicatie tussen applicaties: sessies opbouwen, beheren en afsluiten.  
   *Voorbeeld:* inloggen op een server en je sessie actief houden, of een VoIP-gesprek beheren.  

4. **Transport**  
   Applicatie-tot-applicatie communicatie, segmentatie, error control en flow control.  
   *Voorbeeld:* TCP (betrouwbare levering van webpagina’s), UDP (snelle levering bij DNS of streaming).  

5. **Network**  
   Host-to-host communicatie, logische adressen en routering.  
   *Voorbeeld:* een router gebruikt het IP-adres om pakketten naar de juiste bestemming te sturen.  

6. **Data Link**  
   Node-to-node communicatie, framing en foutdetectie op basis van MAC-adressen.  
   *Voorbeeld:* een switch gebruikt MAC-adressen om frames naar de juiste poort te sturen (Ethernet).  

7. **Physical**  
   De fysieke laag: media en signalen die bits transporteren.  
   *Voorbeeld:* een UTP-kabel, glasvezel of Wi-Fi-radio die elektrische/optische signalen verstuurt.  


#### Protocol Data Units (PDU's) en Encapsulation

1. **Application/Presentation/Session**  
   Data.  

2. **Transport**  
   Segment = L4-header + data.  

3. **Network**  
   Packet = L3-header + segment (L4-header + data).  

4. **Data Link**  
   Frame = L2-header + packet (L3 + L4 + data) + L2-trailer.  

5. **Physical**  
   Bits → het frame wordt verzonden als elektrische of optische signalen.  

> **Encapsulation:** bij verzending worden headers en trailers toegevoegd. Van boven naar beneden: data → segment → packet → frame → bits.  
> **Decapsulation:** bij ontvangst worden headers en trailers verwijderd. Van beneden naar boven: bits → frame → packet → segment → data.  


#### TCP/IP Protocol Suite

De TCP/IP protocol suite vormt de basis voor internetcommunicatie en bestaat uit vier lagen:

| Laag           | Functie                                                        | Protocollen/Technologieën             |
|----------------|----------------------------------------------------------------|---------------------------------------|
| Application    | Datavoorstelling, codering, dialoogbeheer voor de gebruiker    | HTTP, FTP, SMTP, DNS, DHCP, SNMP      |
| Transport      | Application-to-application communicatie tussen hosts           | TCP (betrouwbaar), UDP (snel)         |
| Internet       | Host-to-host communicatie over verschillende netwerken         | IPv4, IPv6, ICMP, ARP                 |
| Network Access | Node-to-node communicatie via fysieke media                    | Ethernet, Wi-Fi, MAC-adressen         |


| Laag           | PDU     |
|----------------|---------|
| Application    | Data    |
| Transport      | Segment |
| Internet       | Packet  |
| Network Access | Frame   |


#### Data Link Layer (Layer 2)

De Data Link Layer (L2) zorgt voor communicatie tussen directe buren in een netwerk.  
Het ontvangt Layer 3 packets en voegt een L2-header en -trailer toe om een frame te creëren.  
De header bevat o.a. bron- en bestemmings-MAC-adressen, de trailer bevat vaak een FCS (Frame Check Sequence) voor foutdetectie.  

#### Sublayers

1. **Logical Link Control (LLC)**  
   Zorgt voor de communicatie tussen L3 en L2. Geeft aan welk L3-protocol wordt gebruikt (bv. IPv4 of IPv6) en maakt samenwerking van meerdere L3-protocollen op dezelfde L2 mogelijk.  

2. **Media Access Control (MAC)**  
   Definieert hoe apparaten toegang krijgen tot het fysieke medium. Zorgt voor adressering via unieke MAC-adressen (48-bit hex, bv. `00:1A:2B:3C:4D:5E`).  
   - Eerste 24 bits = **OUI (Organizationally Unique Identifier)** → fabrikant (bv. `00:1A:2B` = Apple).  
   - MAC-adressen adresseren frames binnen een lokaal netwerk.
   - Fysieke adressering: MAC-adressen zijn uniek voor elk apparaat op het netwerk.
 
#### Frame Structure & Types

1. **Frame Structure**
   - Start/Stop indicator flags (L1)  
   - Addressing: bron- en bestemmings-MAC  
   - Type/Protocol: welk L3-protocol in de data (bv. IPv4, IPv6)  
   - Controle: QoS, prioriteit of vertraging  
   - Data: payload = packet header + segment header + data  
   - Error Detection: foutcontrole (na de data)  

   > Bij elke router-hop verandert het frame, maar het IP-pakket blijft hetzelfde.  

2. **Frame Types**
   - Ethernet  
   - 802.11 Wireless  
   - PPP (Point-to-Point Protocol)  
   - HDLC (High-Level Data Link Control)  
   - Frame Relay  

3. **Speciale gevallen**
   - Runts = frames < 64 bytes (fouten of verkeerde configuratie).  
   - Giants = frames > 1518 bytes (of > 9000 bij jumbo frames).  

---




