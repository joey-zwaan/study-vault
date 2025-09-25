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
   Eerste 24 bits = OUI (Organizationally Unique Identifier), dat de fabrikant aangeeft (bv. `00:1A:2B` = Apple).  
   MAC-adressen adresseren frames binnen een lokaal netwerk.  
   Fysieke adressering: elk apparaat op het netwerk heeft een uniek MAC-adres.  


#### Frame Structure & Types

1. **Frame Structure**  
   Start/Stop indicator flags (L1).  
   Addressing: bron- en bestemmings-MAC.  
   Type/Protocol: welk L3-protocol in de data (bv. IPv4, IPv6).  
   Controle: QoS, prioriteit of vertraging.  
   Data: payload = packet header + segment header + data.  
   Error Detection: foutcontrole (na de data).  

   > Bij elke router-hop verandert het frame, maar het IP-pakket blijft hetzelfde.  

2. **Frame Types**  
   Ethernet, 802.11 Wireless, PPP (Point-to-Point Protocol), HDLC (High-Level Data Link Control), Frame Relay.  

3. **Speciale gevallen**  
   Runts = frames < 64 bytes (fouten of verkeerde configuratie).  
   Giants = frames > 1518 bytes (of > 9000 bij jumbo frames).  


---



## Ethernet LANs

Ethernet is een verzameling netwerkstandaarden die beschrijven hoe apparaten binnen een lokaal netwerk (LAN) met elkaar communiceren. Het omvat zowel de fysieke laag (kabels, signalen) als de data-link laag (frames, MAC-adressering). Je kan Ethernet dus zien als een **familie van protocollen en regels** die samen de basis vormen voor vrijwel alle bekabelde netwerken.

### SOHO LANs 

Small Office/Home Office hebben typisch een eenvoudige netwerkstructuur met een enkele router die fungeert als gateway naar het internet. Deze router bevat meestal ingebouwde functies zoals DHCP-server, NAT (Network Address Translation) , Firewall en Wi-Fi access point. Het is een "All-in-One" apparaat dat alle basisfunctionaliteiten voor een klein netwerk biedt. Het vervangt **de Modem, Router, Switch en Access Point.**

### Enterprise LANs

Enterprise LANs zijn complexer en bestaan uit meerdere lagen en apparaten om schaalbaarheid, prestaties en betrouwbaarheid te waarborgen. Een typische enterprise LAN-architectuur bestaat uit apparaten die elk een specifieke rol vervullen:
**Routers:** verbinden verschillende netwerken en beheren verkeer tussen VLANs en naar externe netwerken.
**Switches:** verbinden apparaten binnen hetzelfde netwerk en zorgen voor efficiënte dataoverdracht.
**Access Points:** bieden draadloze connectiviteit voor mobiele apparaten.
**Firewalls:** beveiligen het netwerk tegen ongeautoriseerde toegang en bedreigingen.


Ethernet is een verzamelterm voor een hele familie van standaarden en protocollen die de fysieke en datalinklagen van het OSI-model definiëren. Het is de meest gebruikte LAN-technologie wereldwijd. Oorspronkelijk ontwikkeld in de jaren 70 door Xerox PARC, werd het later gestandaardiseerd door de IEEE als IEEE 802.3. 

**Voorbeelden van Ethernet standaarden:**

10mbps | Ethernet | 10Base-T | 802.3 | Copper (UTP) | 100 meter
100mbps | Fast Ethernet | 100Base-TX | 802.3u | Copper (UTP) | 100 meter
1000mbps | Gigabit Ethernet | 100BASE-LX | 802.3z | Fiber Optic | 5 km
1000mbps | Gigabit Ethernet | 1000Base-T | 802.3ab | Copper (UTP) | 100 meter
10gbps | 10 Gigabit Ethernet | 10GBase-T | 802.3an | Copper (UTP) | 100 meter


>Fiber optische kabels bevatten glasvezels. De verbonden Ethernet node stuurt lichtpulsen over het glasvezel in de kabel, encodeert de bits als veranderingen in het lichtsignaal


### UTP Ethernet Link

De term **Ethernet link** verwijst naar de fysieke verbinding tussen twee netwerkapparaten via een Ethernet-kabel, meestal een UTP (Unshielded Twisted Pair) kabel. De meeste Ethernet-verbindingen gebruiken RJ45-connectoren aan beide uiteinden van de kabel.

**Straight-through kabel:** wordt gebruikt om verschillende apparaten te verbinden, zoals een computer met een switch of een switch met een router. 

**Crossover kabel:** wordt gebruikt om gelijke apparaten te verbinden, zoals een switch met een andere switch of een computer met een andere computer.

Door te weten of een device als een PC NIC functioneert (**pins 1 & 2 verstuurd**) Of dat het als een switch functioneert (op **pins 3 & 6**) kan je bepalen of je een straight-through of crossover kabel nodig hebt. Als de eindapparaten versturen op **dezelfde pins, heb je een crossover kabel nodig. En als ze op verschillende pins versturen, heb je een straight-through kabel nodig.

Tegenwoordig maken we vooral gebruik van **Auto-MDIX**, waardoor het type kabel (straight-through of crossover) automatisch wordt gedetecteerd en aangepast door de netwerkapparaten. Hierdoor is het meestal niet meer nodig om specifieke kabeltypes te kiezen voor verschillende verbindingen.

> Routers, Wireless Access Points, PC NICS sturen allemaal op pins 1 & 2. Switches, Hubs sturen op pins 3 & 6.

### Fiber Optic Ethernet Link

Fiber optic kabels gebruiken glasvezels om data te verzenden als lichtpulsen. Het sturen van data over fiberglass heeft bescherming en versterking nodig. De drie buitenste lagen van een fiber optic kabel zijn er om de glasvezel te beschermen tegen fysieke schade en om het lichtsignaal binnen de kern te houden. De interne core & cladding werken samen om een omgeving te creëren waarin het lichtsignaal efficiënt kan reizen. 



**Multi-mode fiber:** Heeft als kenmerk dat er meerdere lichtpaden (modes) door de kern kunnen reizen.
**Single-mode fiber:** Heeft een kleinere kern waardoor slechts één lichtpad (mode) door de kern kan reizen. Hierdoor kunnen signalen over langere afstanden worden verzonden met minder signaalverlies en interferentie.
Beiden zijn belangrijk in verschillende netwerktoepassingen, afhankelijk van de afstand en de vereiste bandbreedte.

**Voorbeelden van fiber optic standaarden:**

| Standaard       | Medium            | Max. afstand |
| --------------- | ----------------- | ------------ |
| **10GBASE-S**   | Multi-mode fiber  | 400 m        |
| **10GBASE-LX4** | Multi-mode fiber  | 300 m        |
| **10GBASE-LR**  | Single-mode fiber | 10 km        |
| **10GBASE-E**   | Single-mode fiber | 30 km        |


### Ethernet Data-link protocols

De meest sterke eigenschap van de Ethernet familie van protocollen is dat ze allemaal dezelfde frame structuur gebruiken. Hierdoor kunnen verschillende Ethernet standaarden naadloos samenwerken binnen hetzelfde netwerk.

| Field                           | Grootte           | Functie                                             |
| ------------------------------- | ----------------- | --------------------------------------------------- |
| **Preamble**                    | 7 bytes (56 bits) | Synchronisatie tussen zender en ontvanger           |
| **SFD (Start Frame Delimiter)** | 1 byte (8 bits)   | Markeert het begin van het frame                    |
| **Destination MAC Address**     | 6 bytes           | Adres van de ontvanger                              |
| **Source MAC Address**          | 6 bytes           | Adres van de zender                                 |
| **Type**                        | 2 bytes           | Protocoltype (bijv. IPv4, IPv6, ARP)                |
| **Data & Padding**              | 46–1500 bytes     | Payload (bijv. IP-pakket). Padding indien <46 bytes |
| **FCS (Frame Check Sequence)**  | 4 bytes           | CRC-controle voor foutdetectie                      |


#### Ethernet Addressing

Ethernet-adressering gebeurt via unieke MAC-adressen die aan elke netwerkinterfacekaart (NIC) zijn toegewezen.
Een MAC-adres is een 48-bits hexadecimaal getal, meestal weergegeven in het formaat 00:1A:2B:3C:4D:5E.

Wanneer data naar een unicast MAC-adres wordt gestuurd, bereikt dit enkel de bedoelde ontvanger. Dit principe werkt correct zolang alle MAC-adressen uniek zijn binnen het netwerk. Moesten twee apparaten hetzelfde MAC-adres hebben, zou dit leiden tot conflicten en communicatieproblemen. Ethernet lost dit probleem op door een administratief process te hanteren waarbij fabrikanten unieke MAC-adressen toewijzen aan elke NIC die ze produceren. Dit wordt gedaan door een Organizationally Unique Identifier (OUI) toe te kennen aan elke fabrikant, die de eerste 24 bits van het MAC-adres vormt. De fabrikant gebruikt vervolgens de resterende 24 bits om unieke adressen voor hun apparaten te genereren.

Naast Unicast gebruikt Ethernet ook groep adressering. Groep adressering identificeert meerdere apparaten die deel uitmaken van een specifieke groep. Er zijn twee hoofdtypen groep adressering:
- **Broadcast:** Een frame met een broadcast MAC-adres (FF:FF:FF:FF:FF:FF) wordt naar alle apparaten in het lokale netwerk gestuurd. Dit is handig voor situaties waarin een apparaat informatie moet delen met alle andere apparaten, zoals bij ARP-verzoeken.
- **Multicast:** Een frame met een multicast MAC-adres wordt naar een specifieke groep apparaten gestuurd die zich hebben aangemeld voor die groep. Multicast-adressen beginnen meestal met een specifiek patroon, zoals 01:00:5E voor IPv4 multicast. Dit is nuttig voor toepassingen zoals videostreaming, waarbij dezelfde data naar meerdere ontvangers moet worden gestuurd zonder het hele netwerk te belasten.

#### MAC Adress Terminology
## Ethernet MAC-adressering

| Term                          | Beschrijving                                                                                                     |
|-------------------------------|------------------------------------------------------------------------------------------------------------------|
| **MAC Address**               | Media Access Control-adres. Gedefinieerd in IEEE 802.3 als onderdeel van de MAC-sublayer. Bestaat uit **6 bytes (48 bits)**. |
| **Ethernet Address / NIC Address / LAN Address** | Alternatieve benamingen voor een MAC-adres. Verwijzen allemaal naar het 6-byte adres van de netwerkinterfacekaart. |
| **Burned-In Address (BIA)**   | Het **fabrieksmatig geprogrammeerde** MAC-adres dat permanent in de hardware van de NIC staat.                   |
| **Unicast Address**           | Een **uniek MAC-adres** dat verwijst naar één enkele NIC. Frames worden uitsluitend naar dit ene apparaat gestuurd. |
| **Multicast Address**         | Een MAC-adres dat toegewezen is aan een **groep NICs**. Frames worden afgeleverd aan alle apparaten die lid zijn van de groep. |
| **Broadcast Address**         | Het speciale adres **FF:FF:FF:FF:FF:FF**. Wordt gebruikt om frames naar **alle NICs** in hetzelfde lokale netwerk te sturen. |


#### EtherType Field

Het EtherType-veld in een Ethernet-frame is een 2-byte veld dat aangeeft welk protocol in de payload van het frame wordt gebruikt. Dit veld helpt de ontvangende host te bepalen hoe de gegevens in het frame moeten worden verwerkt. Enkele veelvoorkomende EtherType-waarden zijn:
| EtherType-waarde | Protocol        | Beschrijving                               |
|------------------|-----------------|-------------------------------------------|
| 0x0800           | IPv4            | Internet Protocol versie 4                |
| 0x86DD           | IPv6            | Internet Protocol versie 6                |
| 0x0806           | ARP             | Address Resolution Protocol               |
| 0x8100           | VLAN-tagging    | Gebruikt voor IEEE 802.1Q VLAN-tagging    |

Aan de hand van deze waarden kan de ontvangende host het juiste protocolstack laden om de gegevens correct te verwerken.

#### Error Detection (FCS)

Ethernet gebruikt een Frame Check Sequence (FCS) voor foutdetectie. De FCS is een 4-byte veld in de Ethernet-trailer dat een CRC (Cyclic Redundancy Check) waarde bevat.
Het geeft de ontvanger de mogelijkheid om te controleren of het frame tijdens de overdracht is beschadigd. Als de berekende CRC-waarde niet overeenkomt met de ontvangen FCS, wordt het frame als beschadigd beschouwd en meestal gedropt. 

> Error detectie betekent **NIET** Error recovery. Ethernet definieert dat een beschadigd frame wordt gedropt, en probeert het niet te herstellen.

#### Sturen van Ethernet Frames 

In moderne ethernet netwerken wordt meestal gebruik gemaakt van **full-duplex** communicatie, waarbij apparaten gelijktijdig kunnen zenden en ontvangen. Dit elimineert de noodzaak voor CSMA/CD (Carrier Sense Multiple Access with Collision Detection), dat werd gebruikt in half-duplex netwerken om botsingen te detecteren en te beheren. In full-duplex hoeft het apparaat niet te wachten voordat hij verzend. Hij kan tegelijkertijd verzenden en ontvangen.  In oudere half-duplex netwerken, zoals die met hubs, was CSMA/CD essentieel om ervoor te zorgen dat apparaten niet tegelijkertijd zonden, wat tot botsingen zou leiden.

**CSMA/CD** werkt als volgt:

Een device die wil zenden luistert of de lijn vrij is (Carrier Sense).
Als de lijn vrij is, begint het device met zenden (Multiple Access).
De zender blijft luisteren tijdens het zenden om te detecteren of er een botsing optreedt (Collision Detection).
Als een botsing wordt gedetecteerd, stopt de zender onmiddellijk met zenden en stuurt een jamming-signaal om andere apparaten te informeren over de botsing. Vervolgens wacht het device een willekeurige tijd (backoff) voordat het opnieuw probeert te zenden.


Te kennen termen voor CCNA:

| Term                                   | Beschrijving                                                                       |
| -------------------------------------- | ---------------------------------------------------------------------------------- |
| **10BASE-T**                           | Ethernet-standaard: 10 Mbps, twisted pair koperkabels.                             |
| **100BASE-T**                          | Fast Ethernet-standaard: 100 Mbps, twisted pair koperkabels.                       |
| **1000BASE-T**                         | Gigabit Ethernet-standaard: 1 Gbps, twisted pair koperkabels.                      |
| **auto-MDIX**                          | Automatische detectie en configuratie van straight-through of crossover kabels.    |
| **Broadcast Address**                  | MAC-adres **FF:FF:FF:FF:FF:FF**, verstuurt frames naar alle hosts in een LAN. |
| **Cladding**                           | Buitenlaag rond de glasvezelkern die zorgt voor totale interne reflectie.          |
| **Core**                               | Binnenste deel van een glasvezel waar het licht doorheen gaat.                     |
| **Crossover Cable**                    | Twisted pair kabel waarbij zend- en ontvangstdraden gekruist zijn.                 |
| **EMI (Electromagnetic Interference)** | Storingen door elektromagnetische straling die datatransmissie kan beïnvloeden.    |
| **Ethernet**                           | Verzamelnaam voor de IEEE 802.3-standaarden voor bekabelde LAN-verbindingen.       |
| **Ethernet Address**                   | Zie **MAC Address**, het unieke adres van een NIC.                                 |
| **Ethernet Frame**                     | Het basisdatapakket in Ethernet, met headers, payload en FCS.                      |
| **Ethernet Link**                      | Een fysieke of logische verbinding tussen twee Ethernet-apparaten.                 |
| **Ethernet Port**                      | Netwerkpoort (RJ45 of fiber) waar Ethernet-kabels worden aangesloten.              |
| **Fast Ethernet**                      | Ethernet met een snelheid van 100 Mbps (100BASE-T).                                |
| **Fiber Optic Cable**                  | Kabel die data via lichtsignalen door glas- of k                                   |



