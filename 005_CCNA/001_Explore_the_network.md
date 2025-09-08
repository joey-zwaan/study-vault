# DNS

DNS (Domain Name System) is a hierarchical system for naming resources on the internet. It translates human-readable domain names (like www.example.com) into IP addresses (like 192.0.2.1) that computers use to identify each other on the network.

## Werking

1. **DNS Query:** Wanneer een gebruiker een website bezoekt, wordt er een DNS-query verzonden naar een DNS-server.
2. **Recursieve DNS-server:** Deze server zoekt de IP-adresinformatie op, mogelijk door andere DNS-servers te raadplegen.
3. **Caching:** DNS-servers cachen (onthouden) eerder opgevraagde informatie om toekomstige queries te versnellen.
4. **DNS Records:** Verschillende soorten records worden gebruikt, zoals A-records (voor IPv4-adressen), AAAA-records (voor IPv6-adressen), en CNAME-records (voor aliassen).

## DNS-structuur

- **Root Level:** De hoogste laag in de DNS-hiërarchie, aangeduid met een punt (.) en bevat de root DNS-servers.
- **Top-Level Domains (TLDs):** De volgende laag, zoals .com, .org, .net, enz.
- **Second-Level Domains:** De naam die aan de TLD is voorafgegaan, zoals "example" in www.example.com.
- **Subdomains:** Extra niveaus die aan een domein kunnen worden toegevoegd, zoals "www" in www.example.com.


## Qualiteit van Service (QoS)

Hiermee worden de volgende aspecten van netwerkverkeer beheerd:

1. **Bandwith:** QoS kan bandbreedte toewijzen aan bepaalde soorten verkeer, zodat belangrijk verkeer (zoals spraak of video) voorrang krijgt boven minder belangrijk verkeer (zoals bestandsdownloads).

2. **Delay:** QoS kan helpen om de vertraging (latency) te minimaliseren voor tijdgevoelige toepassingen zoals VoIP of online gaming.

3. **Jitter:** QoS kan de variatie in vertraging (jitter) verminderen, wat vooral belangrijk is voor real-time communicatie.

4. **Packet Loss:** QoS kan mechanismen implementeren om pakketverlies te minimaliseren, wat de kwaliteit van de verbinding verbetert.


**Er zijn standaarden voor acceptable interactive audio quality:**

One-way delay: < 150 ms
Jitter: < 30 ms
Packet loss: < 1%

Als de standaarden overschreden worden, kan dit leiden tot een slechte gebruikerservaring, zoals haperende audio of video.


### Queuing 

Als een netwerkapparaat (zoals een router of switch) meer verkeer ontvangt dan het kan verwerken, worden pakketten in een wachtrij geplaatst. QoS kan verschillende wachtrijmechanismen gebruiken om te bepalen welke pakketten als eerste worden verwerkt:

- **FIFO (First In, First Out):** Pakketten worden in de volgorde verwerkt waarin ze aankomen (standaard).

**Tail Drop:** Als de wachtrij vol is, worden nieuwe pakketten gedropt. Dit kan leiden tot TCP global synchronization, waarbij meerdere TCP-verbindingen tegelijkertijd hun snelheid verlagen. Hierna zullen ze weer allemaal tegelijk hun snelheid verhogen, hierdoor herhaalt het proces zich.

**Network congestion --> tail drop --> Global TCP window reduction --> Network underutilization --> TCP window increase --> Network congestion**

**RED (Random Early Detection):** Pakketten worden willekeurig gedropt voordat de wachtrij vol is, om congestie te voorkomen. Dit helpt om TCP global synchronization te voorkomen. Hierdoor blijft de verbinding volledig benut en blijft het netwerk stabieler. Standaard wordt alle traffic gelijkwaardig behandeld.

**WRED (Weighted Random Early Detection):** Vergelijkbaar met RED, maar met gewichten voor verschillende soorten verkeer. Hierdoor kan belangrijk verkeer minder snel gedropt worden dan minder belangrijk verkeer.

Je kan bijv. kiezen om HTTTP verkeer minder snel te droppen dan FTP verkeer. of VOIP verkeer minder snel te droppen dan email verkeer. 


### Classification and Marking
Voordat QoS kan worden toegepast, moet het netwerkverkeer worden geclassificeerd en gemarkeerd. Dit kan op verschillende manieren:

- **Access Control Lists (ACLs):** Hiermee kunnen specifieke soorten verkeer worden geïdentificeerd op basis van IP-adressen, poorten, of protocollen.
- **NBAR (Network-Based Application Recognition):** Deep packet inspection die applicaties kan herkennen op basis van hun gedrag en kenmerken.

In de Layer 3 & 4 headers zijn er specifieke velden die gebruikt kunnen worden voor QoS marking:

**PCP (Priority Code Point) in de VLAN tag (Layer 2)**
Class of Service IEEE 802.1p (Layer 2)
Er zijn 8 mogelijkheden (0-7), waarbij 0 de laagste prioriteit heeft en 7 de hoogste.

0 - Best Effort
3 - Critical Applications
5 - Voice

Mark traffic betekent dat je PCP waarden toevoegt aan de VLAN tag van een frame. Dit kan gedaan worden door switches of IP-phones die QoS ondersteunen.

Dit kan enkel gebruikt worden over 
- Trunk links (tussen switches)
- Access links (tussen switch en IP-phone, waarbij de IP-phone de VLAN tag toevoegt)


**DSCP (Differentiated Services Code Point) in de IP header (Layer 3)**

In de IP header zijn er DSCP en ECN velden die gebruikt kunnen worden voor QoS marking.

**DF (Default Forwarding) - 0**

Best-effort traffic

**AF (Assured Forwarding) - 10-46**

Het gebruikt 4 classes. Alle pakketen in dezelfde class krijgen dezelfde behandeling. Binnen elke class zijn er 3 drop precedence niveaus (laag, medium, hoog). Pakketten met een hogere drop precedence worden eerder gedropt bij congestie.

**EF (Expedited Forwarding) - 46**
Traffic that requires low loss, low latency, and low jitter (bijv. voice traffic)

**CS (Class Selector) - 8, 16, 24, 32, 40, 48, 56**
Deze waarden zijn achterwaarts compatibel met de oude IP Precedence waarden. Ze worden gebruikt voor eenvoudige prioriteitsmarkering.

**RFC 4594** definieert de standaard DSCP waarden voor verschillende soorten verkeer.

Voice: EF (46)
Interactive Video: AF41 (34)
Signaling: CS3 (24)
High Priority Data: AF31 (26)
Best Effort: DF (0)

**Trust boundaries**

QoS marking moet worden vertrouwd op specifieke punten in het netwerk, anders zal het andere netwerkapparaat dit verkeer niet vertrouwen en de marking overschrijven. Dit wordt een trust boundary genoemd.

Het beste is om je trust boundaries zo dicht mogelijk bij de bron van het verkeer te plaatsen, bijvoorbeeld op de access switch waar de end devices (zoals computers en IP-phones) zijn aangesloten.


### Queuing/congestion management

Een veelgebruikte methode is **round-robin**; hierbij wordt elk pakket in de wachtrij gelijkmatig behandeld, ongeacht het type verkeer.
**Weighted** wordt meer data van een hogere prioriteit queue verstuurd dan van een lagere prioriteit queue.

**CBWFQ (Class-Based Weighted Fair Queuing)** is een veelgebruikte vorm van scheduling. Weighted rounding-robin wordt gebruikt om pakketten uit verschillende klassen te versturen op basis van hun toegewezen gewicht. Hierdoor krijgt ieder type verkeer een eerlijk deel van de bandbreedte, afhankelijk van de prioriteit die eraan is toegekend.


**LLQ (Low Latency Queuing)** is ontwikkeld als stricte priority queues. Dit betekent dat wanneer er verkeer in de LLQ wachtrij zit, dit verkeer altijd wordt genomen van deze wachtrij totdat deze leeg is.

Dit is handig om delay & jitter te voorkomen op voice/video traffic.

**Nadeel**  is dat het andere verkeer (zoals data) kan verhongeren als er constant voice/video traffic is.

### Shaping and Policing

Traffic shaping en policing worden gebruikt om de hoeveelheid netwerkverkeer te beheersen. Traffic shaping buffert en verspreidt verkeer gelijkmatig over de tijd om pieken af te vlakken, terwijl policing verkeer dat de ingestelde limieten overschrijdt direct afwijst of markeert.


## Lan Architectures

**Star Topology**

Alle apparaten zijn direct verbonden met een centrale switch of hub. Dit maakt het eenvoudig om apparaten toe te voegen of te verwijderen zonder het hele netwerk te beïnvloeden.


**Full Mesh Topology**

In een full mesh-topologie is elk apparaat direct verbonden met elk ander apparaat in het netwerk. Dit biedt maximale redundantie en betrouwbaarheid, omdat er meerdere paden zijn voor gegevensoverdracht. Echter, het is duur en complex om te implementeren en te onderhouden, vooral in grote netwerken.

**Partial Mesh Topology**

In een partial mesh-topologie zijn sommige apparaten direct met elkaar verbonden, terwijl andere apparaten via tussenliggende apparaten communiceren. Dit biedt een balans tussen redundantie en kosten, waardoor het geschikt is voor grotere netwerken waar volledige mesh niet haalbaar is.

**Access Layer**

De access layer is de laag waar eindgebruikers en apparaten verbinding maken met het netwerk. Dit omvat switches, access points, en andere netwerkapparaten die directe toegang bieden tot het netwerk.

**Distribution Layer**

Distribution layer fungeert als een brug tussen de access layer en de core layer. Het is verantwoordelijk voor het aggregeren van verkeer van meerdere access switches en het toepassen van beleidsregels zoals QoS, filtering, en routing.
Typisch is het de grens tussen Layer 2 en Layer 3. Meestal multi-layer switches die zowel Layer 2 switching als Layer 3 routing kunnen uitvoeren.

### 2 tier & 3 tier architectures

**collapsed core architecture**

In een collapsed core-architectuur zijn de core- en distributie-laag samengevoegd in één laag. Dit vereenvoudigt het ontwerp en vermindert de kosten, maar kan ook leiden tot prestatieproblemen en een gebrek aan schaalbaarheid.

**3 tier architecture**

In een 3-tier architectuur zijn er drie lagen: access, distribution, en core. De core layer is verantwoordelijk voor het snelle transport van gegevens tussen verschillende distributie-lagen. Dit ontwerp biedt betere schaalbaarheid, prestaties, en redundantie.
Dit wordt vooral gebruikt in Datacenters. Dit werkt goed als er veel verkeer tussen noord-zuid is (tussen clients en servers).
Met de introductie van virtualisatie is er veel meer oost-west verkeer (tussen servers onderling). Dit kan leiden tot bottlenecks in de core layer.


### Spine-leaf architecture

**Spine-leaf architecture** is een netwerkontwerp dat bestaat uit twee lagen: spine en leaf. In dit ontwerp zijn alle leaf switches verbonden met alle spine switches, waardoor er meerdere paden zijn voor gegevensoverdracht. Dit biedt hoge beschikbaarheid, lage latentie, en schaalbaarheid, waardoor het ideaal is voor moderne datacenters met veel oost-west verkeer.

Elke spine switch is verbonden met elke leaf switch, maar spine switches zijn niet met elkaar verbonden en leaf switches zijn ook niet met elkaar verbonden. Dit vermindert de complexiteit en verbetert de prestaties. End devices (zoals servers en opslag) zijn verbonden met de leaf switches.


## Wireless LAN (WLAN)

De standaarden die we gebruiken voor WLAN zijn gedefinieerd door de IEEE 802.11 groep.
De term Wi-fi is een merknaam die wordt beheerd door de Wi-Fi Alliance, een organisatie die certificering en promotie van draadloze netwerktechnologieën verzorgt. Het gebruik van de term "Wi-Fi" impliceert dat een apparaat voldoet aan bepaalde interoperabiliteitsnormen die zijn vastgesteld door deze organisatie.


Alle apparaten in range ontvangen alle frames; zoals devices bij een hub. Het is de taak van het ontvangende apparaat om te bepalen of het frame voor hem bedoeld is (aan de hand van het MAC-adres).
Bij draadloze netwerken encrypteer je de frames om te voorkomen dat anderen ze kunnen lezen.
We gebruiken CSMA/CA (Collision Avoidance) in plaats van CSMA/CD (Collision Detection) omdat het moeilijk is om te detecteren of er een collision is op een draadloos medium. In plaats daarvan proberen apparaten te voorkomen dat ze tegelijkertijd zenden door eerst te luisteren of het kanaal vrij is.

verklaring van de termen die te maken hebben met golven:

**Signal absorption:** Materialen zoals beton, hout, en metaal kunnen draadloze signalen absorberen, waardoor de signaalsterkte afneemt.
**Reflection:** Draadloze signalen kunnen reflecteren op oppervlakken zoals muren en meubels, wat kan leiden tot slechte receptie.
**Refraction:** Waneer een golf gebogen wordt als het door verschillende media gaat waar het signaal andere snelheden heeft. Een voorbeeld met glas water: licht gaat langzamer door water dan door lucht, waardoor het licht gebogen wordt als het door het water gaat.
**Diffraction:** Gebeurt wanneer een golf een obstakel tegenkomt en daardoor eromheen gaat. Dit kan zorgen voor blind spots achter het obstakel.
**Scattering:** Wanneer een golf op kleine deeltjes botst en in verschillende richtingen wordt verspreid. Dit kan leiden tot een zwakker signaal.
**Interference:** Andere elektronische apparaten, zoals magnetrons en draadloze telefoons, kunnen interferentie veroorzaken met draadloze signalen.
Voorbeeld: 2.4 GHz is een veelgebruikt frequentiebereik voor draadloze netwerken, maar het wordt ook gebruikt door andere apparaten zoals Bluetooth-apparaten, babyfoons, en magnetrons. Dit kan leiden tot interferentie en verminderde prestaties van het draadloze netwerk.


### Radio Frequencies

De radio frequentie range is van 30Hz tot 300GHz en wordt voor verschillende toepassingen gebruikt.

**Amplitude:** De sterkte van het signaal, gemeten in dBm (decibel milliwatt). Een hoger dBm-waarde betekent een sterker signaal.
**Frequency:** De snelheid van de golf, gemeten in Hz (Hertz). Hogere frequenties kunnen meer data overdragen, maar hebben een korter bereik.
**Wavelength:** De afstand tussen twee opeenvolgende pieken van de golf, gemeten in meters. Kortere golflengtes (hogere frequenties) hebben een korter bereik en zijn gevoeliger voor obstakels.
**Period:** De tijd die het kost voor één volledige cyclus van de golf, gemeten in seconden. Kortere periodes komen overeen met

Wifi gebruikt 3 hoofdfrequentiebanden:
- 2.4 GHz: Langere golflengte, beter bereik, maar meer interferentie (bijv. van andere apparaten).
- 5 GHz: Kortere golflengte, minder interferentie, maar korter bereik.
- 6 GHz: Nieuwere band met nog minder interferentie en hogere snelheden, maar nog korter bereik.

In 2.4GHz is het aanbevolen om de channels 1, 6 en 11 te gebruiken omdat deze kanalen elkaar niet overlappen. In 5GHz zijn er meer niet-overlappende kanalen beschikbaar, waardoor interferentie minder een probleem is.

### 802.11 Standaarden

De 802.11-standaarden definiëren de specificaties voor draadloze netwerken (Wi-Fi). Hieronder een overzicht van de belangrijkste standaarden:

| **Standaard**  | **Frequentie** | **Max Snelheid** | **Bereik (binnen)** | **Bereik (buiten)** | **Opmerking**                          |
|----------------|----------------|------------------|---------------------|---------------------|----------------------------------------|
| 802.11b        | 2.4 GHz        | 11 Mbps          | 35 m                | 140 m               | Oudere standaard, nu zelden gebruikt   |
| 802.11a        | 5 GHz          | 54 Mbps          | 35 m                | 120 m               | Hogere snelheid, korter bereik         |
| 802.11g        | 2.4 GHz        | 54 Mbps          | 38 m                | 140 m               | Combinatie van b en a.                 |
| 802.11n        | 2.4/5 GHz      | 600 Mbps         | 70 m                | 250 m               | Ondersteunt MIMO, veel gebruikt        |
| 802.11ac       | 5 GHz          | 6,93 Gbps        | 35 m                | 120 m               | Hogere snelheden, veel gebruikt        |
| 802.11ax       | 2.4/5 GHz      | 9.6 Gbps         | 35 m                | 120 m               | Wi-Fi 6, verbeterde efficiëntie        |

## Service Set Identifier (SSID)

De SSID is de naam van een draadloos netwerk. Het is een unieke identifier die wordt gebruikt om verschillende draadloze netwerken te onderscheiden. Apparaten gebruiken de SSID om verbinding te maken met het juiste netwerk.

**IBSS (Independent Basic Service Set):** Een ad-hoc netwerk waarbij apparaten direct met elkaar communiceren zonder een access point. Iphones kunnen dit gebruiken voor AirDrop. 
**BSS (Basic Service Set):** Een netwerk waarbij apparaten verbinding maken via een access point. Dit is de meest voorkomende vorm van een draadloos netwerk. Basic service set ID (BSSID) is het MAC-adres van het access point.
**BSA (Basic Service Area):** Het gebied dat wordt gedekt door een enkel access point.
**ESS (Extended Service Set):** Een netwerk dat bestaat uit meerdere access points die dezelfde SSID gebruiken, waardoor apparaten naadloos kunnen schakelen tussen access points binnen hetzelfde netwerk. 

