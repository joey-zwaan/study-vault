## Fundamentals of WANs and IP Routing


### Leased-line WANs

Om een **leased-line** te realiseren, moet er een fysieke verbinding bestaan tussen twee routers aan beide uiteinden.
De **telecomprovider (Telco)** verzorgt hiervoor een uitgebreid en complex netwerk. Voor de klant lijkt het alsof er simpelweg één kabel rechtstreeks de twee routers verbindt, maar in werkelijkheid loopt de verbinding door een groot netwerk van routers en switches van de provider, die allemaal samenwerken om een stabiele en betrouwbare verbinding tot stand te brengen.

Door de geschiedenis en evolutie van **leased-lines** bestaan er meerdere benamingen voor dit type verbinding.  

| Term               | Uitleg                                                                 |
|--------------------|------------------------------------------------------------------------|
| **Point-to-Point link** | Rechtstreekse verbinding tussen twee locaties                        |
| **Serial link/line**    | Oudere seriële technologie die vaak werd toegepast                   |
| **Leased-circuit**      | Klassieke term die benadrukt dat de lijn gehuurd wordt bij de provider |
| **T1**                  | Standaard in de VS voor een capaciteit van 1.544 Mbps               |
| **WAN link**            | Algemene aanduiding binnen Wide Area Networks                       |
| **Private line**        | Benadrukt exclusief gebruik door de huurder                         |


### Data-link leased-lines

Een leased-line geeft een layer 1 service, het beloofd bits over te dragen tussen apparaten verbonden op deze lijn. De leased-line zelf bepaald geen data-link layer protocol. Dus om deze te kunnen gebruiken moet er aan beide kanten een data-link protocol worden gekozen en geconfigureerd. 
Er is keuze uit deze data-link protocollen:

| Protocol            | Uitleg                                                                 |
|---------------------|------------------------------------------------------------------------|
| **HDLC**            | High-Level Data Link Control, een standaard voor point-to-point verbindingen |
| **PPP**             | Point-to-Point Protocol, biedt authenticatie en compressie               |

HDLC & PPP zijn beide **layer 2 protocollen** die gebruikt worden om data over een point-to-point verbinding (leased-line) te verzenden. Het is minder complex dan Ethernet door de simpele topologie.
HDLC is een oudere standaard, PPP is moderner en biedt extra functies zoals authenticatie en compressie. PPP is daarom de voorkeur voor moderne netwerken.

> Het idee is een beetje als ik lunch heb met mijn vriend Gary. Ik begin niet elke zin met "hey Gary", ik weet dat hij er is. Net zoals bij een point-to-point verbinding, waar de apparaten aan beide uiteinden weten dat ze direct met elkaar verbonden zijn zonder extra adressen of protocollen nodig te hebben.


#### HDCL Framing

## Vergelijking van HDLC/PPP en Ethernet velden

| Field            | HDLC / PPP                                | Ethernet                                |
|------------------|-------------------------------------------|-----------------------------------------|
| **Flag**         | 0x7E (markeert begin/einde frame)         | Preamble + SFD                          |
| **Address**      | Meestal 0xFF (broadcast)                  | MAC-adres (Destination & Source)        |
| **Control**      | Meestal 0x03 (PPP gebruikt dit vast)      | Niet aanwezig                           |
| **Type/Protocol**| PPP: Protocol field HDLC: geen apart veld | EtherType (bijv. IPv4=0x0800)           |
| **FCS**          | 16- of 32-bit CRC                         | 32-bit CRC                              |


Als PC1 data wil versturen naar PC2, wordt het IP-pakket eerst ingekapseld in een Ethernet-frame. Dit frame bevat de MAC-adressen van zowel de zender (PC1) als de ontvanger (PC2). De router ontvangt dit frame, verwijdert de Ethernet-header en -trailer, en bekijkt het IP-pakket om te bepalen waar het naartoe moet. Vervolgens wordt het IP-pakket ingekapseld in een HDLC-frame voor verzending over de leased-line naar de volgende router. Aan de ontvangende kant verwijdert de router de HDLC-header en -trailer, en bekijkt opnieuw het IP-pakket om te bepalen waar het naartoe moet. Nu wordt het IP-pakket weer ingekapseld in een Ethernet-frame voor aflevering aan PC2.

> Merk op dat de Ethernet header niet wordt meegenomen over de HDLC link. De Ethernet header is alleen relevant binnen het lokale netwerk (LAN) tussen PC1 en de eerste router, en tussen de laatste router en PC2. Over de HDLC link tussen de routers is alleen het IP-pakket van belang, ingekapseld in een HDLC-frame.

### Ethernet als WAN technologie

Vandaag de dag bieden veel service-providers WAN-services aan die gebruik maken van Ethernet. Ze hebben verschillende namen maar gebruiken allemaal een gelijkaardig model, met Ethernet tussen de klant & de provider.

Het idee is hetzelfde als met een leased-line, maar in plaats van een seriële verbinding tussen twee routers, wordt er een Ethernet-verbinding gebruikt. Dit kan via glasvezel of koper zijn. De (fiber) Ethernet link verlaat de klantlocatie en verbindt met een SP locatie genoemd **Point of Presence (PoP)**. Hier wordt het verkeer van meerdere klanten samengevoegd en via het netwerk van de provider naar de bestemming gestuurd. 

Basic Ethernet WAN services zijn:
| Service Type       | Uitleg                                                                 |
|--------------------|------------------------------------------------------------------------|
| **E-Line**         | Point-to-Point verbinding tussen twee locaties                         |
| **Ethernet-WAN**   | Algemene term voor Ethernet-gebaseerde WAN-diensten                    |
| **EoMPLS**         | Ethernet over MPLS, Multiprotocol Label Switching                      |

Als je 2 routers hebt is het alsof er een directe Ethernet link is tussen de 2 routers. Ze connecteren met een Ethernet WAN service i.p.v een seriële leased-line.
Fysiek verbind elke router met een Point of Presence (PoP) van de provider via een Ethernet link. Logisch gezien kunnen de 2 routers Ethernet frames naar elkaar sturen over de link.


### Host Forwarding Logic

Wanneer een host data wil versturen, controleert deze eerst of het bestemmings-IP-adres binnen hetzelfde subnet valt.
Als het bestemmings-IP-adres binnen hetzelfde subnet valt, kan de host de data direct naar de bestemmingshost sturen via het lokale netwerk. Als het bestemmings-IP-adres echter niet binnen hetzelfde subnet valt, moet de host de data naar de default-gateway (meestal een router) sturen voor verdere afhandeling.

Alle routers hebben een routing table die ze gebruiken om te bepalen waar ze inkomende IP-pakketten naartoe moeten sturen. Als een router een pakket ontvangt, kijkt deze in de routing table om de beste route naar het bestemmingsnetwerk te vinden. Als er geen specifieke route is, wordt het pakket naar de default-route gestuurd, als die is geconfigureerd. 

#### Network Layer Routing

De **network layer** bepaalt waar een pakket naartoe moet. De **data-link layer** zorgt vervolgens voor de juiste framing en adressering en vraagt de fysieke laag om de bits daadwerkelijk te verzenden.  

- **Network layer**: “breng het pakket van A naar B”  
- **Data-link layer**: “hoe komt het pakket van A naar B”  

De interne routing logic van een router doorloopt de volgende stappen:

1. Controleer het ontvangen frame met de **Frame Check Sequence (FCS)**. Bij fouten wordt het frame gedropt.
2. Verwijder de data-link **header** en **trailer** zodat enkel het IP-pakket overblijft.
3. Vergelijk het **destination IP address** van het pakket met de **routing table** en bepaal de beste match (meest specifieke). Deze route geeft de uitgaande interface en eventueel een next-hop IP-adres.
4. Encapsuleer het IP-pakket in een nieuw **data-link frame** (bijv. Ethernet, HDLC, PPP) en verstuur dit via de gekozen interface.


IP-addressing helpt IP-routing doordat elke router en host een uniek IP-adres heeft binnen het netwerk. Dit maakt het mogelijk om pakketten correct te adresseren en te routeren naar hun bestemming. Routers gebruiken de IP-adressen in de headers van de pakketten om te bepalen waar ze naartoe moeten worden gestuurd, terwijl hosts deze adressen gebruiken om te communiceren binnen hetzelfde subnet of via een gateway voor buiten het subnet.

#### IP Header Fields

| Field                  | Size (bits) | Description                                                                 |
|-------------------------|-------------|-----------------------------------------------------------------------------|
| **Version**            | 4           | IP version number (always 4 for IPv4).                                      |
| **IHL (Header Length)**| 4           | Length of the header in 32-bit words.                                       |
| **DSCP (Differentiated Services Code Point)** | 6 | Used for packet priority/quality of service. |
| **ECN (Explicit Congestion Notification)** | 2 | Used to signal network congestion.             |
| **Total Length**       | 16          | Total length of the IP packet (header + data) in bytes.                     |
| **Identification**     | 16          | Identifies fragments of the same original packet.                           |
| **Flags**              | 3           | Control flags (e.g., Don’t Fragment, More Fragments).                       |
| **Fragment Offset**    | 13          | Position of a fragment relative to the start of the original packet.        |
| **Time To Live (TTL)** | 8           | Limits packet lifetime (decremented by each hop).                           |
| **Protocol**           | 8           | Indicates the next layer protocol (e.g., TCP=6, UDP=17, ICMP=1).            |
| **Header Checksum**    | 16          | Error-checking of the IPv4 header.                                          |
| **Source Address**     | 32          | IPv4 address of the sender.                                                 |
| **Destination Address**| 32          | IPv4 address of the receiver.                                               |
| **Options** (optional) | Variable    | Additional options (rarely used).                                           |
| **Padding**            | Variable    | Extra bits added so header ends on a 32-bit boundary.                       |

<img src="/assets/ipv4header.png" alt="IPv4 Header" width="600">


### Arp (Address Resolution Protocol)

IP logic verwacht dat elk device een uniek IP-adres heeft. Maar om data te kunnen versturen over een netwerk, is ook een uniek MAC-adres nodig. ARP (Address Resolution Protocol) wordt gebruikt om het MAC-adres van een apparaat te vinden op basis van zijn IP-adres. Het protocol werkt op de Data Link Layer (Layer 2).
Op een LAN netwerk wanneer een host of router packet moet encapsuleren in een nieuwe Ethernet-frame, De host of router weet alle belangrijke informatie om een header te maken behalve het MAC-adres van de bestemming. Een router weet welke IP-adres het pakket moet afleveren, maar niet het MAC-adres van de volgende hop (de host of router waar het pakket naartoe moet). Hiervoor wordt ARP gebruikt.

TCP/IP definieert ARP als een methode waarbij elke host of router op een LAN dynamisch het MAC Address van een andere IP host of router kan vinden. Het ARP protocol gebruikt 2 soorten berichten: ARP Request en ARP Reply.

**ARP Request**: Een broadcast bericht dat vraagt "Wie heeft dit IP-adres? Stuur me je MAC-adres." 
**ARP Reply**: Een unicast bericht dat antwoordt "Ik heb dat IP-adres, mijn MAC-adres is [MAC-adres]."  

Host & routers onthouden de ARP responses in een ARP cache, zodat ze niet telkens opnieuw een ARP request hoeven te sturen voor hetzelfde IP-adres. Host & routers sturen periodiek ARP requests om de cache up-to-date te houden. Elke keer als een host of router een packet encapsuleert in een Ethernet-frame, controleert het eerst de ARP cache voor het MAC-adres van de bestemming. Als het MAC-adres niet in de cache staat, stuurt het een ARP request. Zodra het een ARP reply ontvangt, kan het het MAC-adres gebruiken om de Ethernet-header te maken en het frame te verzenden.

## Key Terms

| Term                        | Uitleg                                                                 |
|-----------------------------|-------------------------------------------------------------------------|
| **ARP**                     | Address Resolution Protocol; vertaalt IP-adressen naar MAC-adressen.    |
| **Default router / gateway**| Router waar een host pakketten heen stuurt die buiten het lokale subnet gaan. |
| **DNS**                     | Domain Name System; vertaalt hostnames naar IP-adressen.                |
| **Ethernet Line Service (E-line)** | Point-to-point Ethernet WAN service geleverd door een provider.  |
| **Ethernet WAN**            | WAN-verbinding die gebruikmaakt van Ethernet-technologie.               |
| **HDLC**                    | High-Level Data Link Control; WAN-encapsulatieprotocol.                 |
| **Hostname**                | Naam die aan een netwerkapparaat of host is toegekend.                  |
| **IP address**              | Uniek adres dat een host identificeert binnen een netwerk.              |
| **IP network**              | Groep IP-adressen die hetzelfde netwerkprefix delen.                    |
| **IP packet**               | Eenheden van data op de network layer, met bron- en bestemmingsadres.   |
| **IP subnet**               | Een deel van een IP-netwerk, gedefinieerd door een subnetmask.          |
| **Leased line**             | Dedicated point-to-point verbinding gehuurd van een telecomprovider.    |
| **Ping**                    | Netwerktool die ICMP echo-verzoeken gebruikt om bereikbaarheid te testen. |
| **Routing protocol**        | Protocol waarmee routers route-informatie uitwisselen (bijv. OSPF, RIP).|
| **Serial interface**        | Routerinterface voor seriële WAN-verbindingen.                          |
| **Subnetting**              | Het opdelen van een IP-netwerk in kleinere subnetwerken.                |
| **Telco**                   | Telecomprovider die netwerkdiensten levert.                             |
| **WAN (Wide Area Network)** | Netwerk dat geografisch verspreide locaties met elkaar verbindt.        |
