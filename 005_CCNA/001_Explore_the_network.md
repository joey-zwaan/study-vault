## DNS

DNS (Domain Name System) is a hierarchical system for naming resources on the internet. It translates human-readable domain names (like www.example.com) into IP addresses (like 192.0.2.1) that computers use to identify each other on the network.

**Werking**

1. **DNS Query:** Wanneer een gebruiker een website bezoekt, wordt er een DNS-query verzonden naar een DNS-server.
2. **Recursieve DNS-server:** Deze server zoekt de IP-adresinformatie op, mogelijk door andere DNS-servers te raadplegen.
3. **Caching:** DNS-servers cachen (onthouden) eerder opgevraagde informatie om toekomstige queries te versnellen.
4. **DNS Records:** Verschillende soorten records worden gebruikt, zoals A-records (voor IPv4-adressen), AAAA-records (voor IPv6-adressen), en CNAME-records (voor aliassen).

#### DNS-structuur

- **Root Level:** De hoogste laag in de DNS-hiërarchie, aangeduid met een punt (.) en bevat de root DNS-servers.
- **Top-Level Domains (TLDs):** De volgende laag, zoals .com, .org, .net, enz.
- **Second-Level Domains:** De naam die aan de TLD is voorafgegaan, zoals "example" in www.example.com.
- **Subdomains:** Extra niveaus die aan een domein kunnen worden toegevoegd, zoals "www" in www.example.com.

---

## Qualiteit van Service (QoS)

Hiermee worden de volgende aspecten van netwerkverkeer beheerd:

1. **Bandbreedte** – zorgt dat cruciaal verkeer (spraak/video) voorrang krijgt.  
2. **Vertraging (Delay)** – minimaliseert latency voor real-time toepassingen.  
3. **Jitter** – vermindert variatie in vertraging, belangrijk voor spraak/video.  
4. **Pakketverlies** – beperkt verlies voor een stabiele verbinding. 

Standaarden voor QoS in netwerken:
1. **One-way delay:** < 150 ms
2. **Jitter:** < 30 ms
3. **Packet loss:** < 1%
Als de standaarden overschreden worden, kan dit leiden tot een slechte gebruikerservaring, zoals haperende audio of video.

#### Queuing Mechanisms

1. **FIFO (First In, First Out)**  
   - Pakketten worden verwerkt in volgorde van aankomst.  
   - Dit is het standaardmechanisme.  

2. **Tail Drop**  
   - Nieuwe pakketten worden gedropt zodra de wachtrij vol is.  
   - Kan leiden tot **TCP global synchronization**:  
     - Netwerkcongestie → Tail drop → TCP window reduction → Onderbenutting → TCP window increase → Nieuwe congestie.  

3. **RED (Random Early Detection)**  
   - Dropt willekeurig pakketten voordat de wachtrij vol is.  
   - Voorkomt TCP global synchronization.  
   - Alle soorten verkeer worden gelijk behandeld.  

4. **WRED (Weighted Random Early Detection)**  
   - Zelfde principe als RED, maar met prioriteit voor belangrijk verkeer.  
   - Voorbeelden:  
     - **HTTP** minder snel droppen dan **FTP**.  
     - **VoIP** minder snel droppen dan **e-mail**.  



#### Verkeer classificeren en markeren voor QoS

1. **Classificatie-methoden**  
   - **ACLs (Access Control Lists):** Identificeer verkeer op basis van IP, poorten of protocol.  
   - **NBAR (Network-Based Application Recognition):** Herkent applicaties via deep packet inspection.  

2. **Markering in headers**  
   - **PCP (Priority Code Point) in VLAN-tag (Layer 2)**  
     - Class of Service (IEEE 802.1p) — 8 waarden (0–7).  
     - Voorbeelden:  
       - `0` = Best Effort  
       - `3` = Critical Applications  
       - `5` = Voice  

3. **Toepassing van markering**  
   - PCP-waarden worden toegevoegd door switches of IP-phones met QoS-ondersteuning.  
   - Kan alleen gebruikt worden over:  
     - **Trunk links** (tussen switches).  
     - **Access links** (tussen switch en IP-phone, waarbij de IP-phone de VLAN-tag toevoegt).  



#### QoS-markering met DSCP (Layer 3)

1. **DSCP- en ECN-velden in de IP-header**  
   - Worden gebruikt voor QoS-markering en congestion notification.  

2. **Belangrijkste DSCP-waarden**  
   - **DF (Default Forwarding, 0):** Best-effort traffic.  
   - **AF (Assured Forwarding, 10–46):**  
     - 4 klassen, elk met 3 drop-precedence niveaus (laag, medium, hoog).  
     - Hogere drop-precedence → eerder droppen bij congestie.  
   - **EF (Expedited Forwarding, 46):** Voor verkeer met lage latency/jitter/verlies (bv. voice).  
   - **CS (Class Selector, 8–56):** Compatibel met oude IP Precedence, voor eenvoudige prioriteitsmarkering.  

3. **RFC 4594 standaardtoewijzingen**  
   - Voice: **EF (46)**  
   - Interactive Video: **AF41 (34)**  
   - Signaling: **CS3 (24)**  
   - High Priority Data: **AF31 (26)**  
   - Best Effort: **DF (0)**  

4. **Trust Boundaries**  
   - QoS-marking moet vertrouwd worden op specifieke punten in het netwerk.  
   - Apparaten buiten de trust boundary kunnen markeringen overschrijven.  
   - Best practice: trust boundary zo dicht mogelijk bij de bron (bv. access switch bij end devices zoals computers of IP-phones).  

#### QoS Scheduling & Traffic Conditioning

1. **Round-Robin**  
   - Alle pakketten worden gelijk behandeld, ongeacht type verkeer.  

2. **Weighted Round-Robin**  
   - Hoger geprioriteerd verkeer krijgt meer bandbreedte dan lager verkeer.  

3. **CBWFQ (Class-Based Weighted Fair Queuing)**  
   - Weighted round-robin toegepast op verschillende klassen.  
   - Verkeer krijgt bandbreedte naar verhouding van toegewezen gewicht.  
   - Zorgt voor een eerlijk deel voor elk type verkeer.  

4. **LLQ (Low Latency Queuing)**  
   - Strict priority queue voor delay-gevoelig verkeer (voice/video).  
   - Alle pakketten uit LLQ worden eerst verstuurd → minimale delay & jitter.  
   - **Nadeel**: ander verkeer kan verhongeren bij constante voice/video load.  

5. **Shaping & Policing**  
   - **Traffic Shaping**: buffert & spreidt verkeer om pieken af te vlakken.  
   - **Policing**: overschrijdend verkeer wordt direct gedropt of gemarkeerd.  

---

## LAN Architectures

1. **Topologieën**
   - **Star Topology**  
     - Alle apparaten verbinden naar een centrale switch of hub.  
     - Voordeel: makkelijk uitbreidbaar.  
   - **Full Mesh Topology**  
     - Elk apparaat is direct verbonden met elk ander apparaat.  
     - Voordeel: maximale redundantie en betrouwbaarheid.  
     - Nadeel: duur en complex, vooral in grote netwerken.  
   - **Partial Mesh Topology**  
     - Sommige apparaten zijn direct verbonden, anderen via tussenliggende apparaten.  
     - Balans tussen redundantie en kosten.  

2. **Netwerk Lagen**
   - **Access Layer**  
     - Verbinding voor eindgebruikers en apparaten (switches, APs).  
   - **Distribution Layer**  
     - Brug tussen access en core.  
     - Aggregatie van verkeer, toepassen van QoS, filtering en routing.  
     - Typisch multi-layer switches (L2 + L3).  
   - **Core Layer (in 3-tier model)**  
     - Snelle data forwarding tussen distribution lagen.  

3. **Architecturen**
   - **2-Tier (Collapsed Core Architecture)**  
     - Distribution + Core samengevoegd.  
     - Voordeel: eenvoud en lagere kosten.  
     - Nadeel: minder schaalbaar, risico op prestatieproblemen.  
   - **3-Tier Architecture**  
     - Bestaat uit Access, Distribution en Core.  
     - Voordeel: schaalbaarheid, redundantie en prestaties.  
     - Gebruikt in datacenters (goed bij veel noord-zuid verkeer).  
     - Nadeel: kan bottlenecks creëren bij veel oost-west verkeer (servers ↔ servers).  
   - **Spine-Leaf Architecture**  
     - Bestaat uit spine en leaf lagen.  
     - Elke leaf ↔ elke spine verbonden.  
     - Geen verbindingen tussen spine-switches of leaf-switches.  
     - Voordeel: hoge beschikbaarheid, lage latentie, schaalbaar.  
     - Geschikt voor moderne datacenters met veel oost-west verkeer.  
     - End devices (servers, storage) verbinden aan leaf switches.  

---

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


#### WLAN Radio Frequencies

1. **Basisbegrippen**  
   - **Amplitude**: Sterkte van het signaal (gemeten in dBm). Hoger = sterker.  
   - **Frequentie**: Snelheid van de golf (Hz). Hogere frequentie = meer data, korter bereik.  
   - **Wavelength (golflengte)**: Afstand tussen twee pieken. Korter = gevoeliger voor obstakels.  
   - **Period**: Tijd voor één volledige cyclus (s). Kortere periode = hogere frequentie.  

2. **Wi-Fi Frequentiebanden**  
   - **2.4 GHz**: Lang bereik, veel interferentie (bv. andere apparaten).  
   - **5 GHz**: Korter bereik, minder interferentie, hogere snelheid.  
   - **6 GHz**: Nieuwste band, hoogste snelheid, laagste bereik, zeer weinig interferentie.  

3. **Kanaalgebruik**  
   - **2.4 GHz**: Gebruik kanalen **1, 6 en 11** → overlappen niet.  
   - **5 GHz**: Meer niet-overlappende kanalen beschikbaar → minder kans op storing.  


#### 802.11 Standaarden

De 802.11-standaarden definiëren de specificaties voor draadloze netwerken (Wi-Fi). Hieronder een overzicht van de belangrijkste standaarden:

| **Standaard**  | **Frequentie** | **Max Snelheid** | **Bereik (binnen)** | **Bereik (buiten)** | **Opmerking**                          |
|----------------|----------------|------------------|---------------------|---------------------|----------------------------------------|
| 802.11b        | 2.4 GHz        | 11 Mbps          | 35 m                | 140 m               | Oudere standaard, nu zelden gebruikt   |
| 802.11a        | 5 GHz          | 54 Mbps          | 35 m                | 120 m               | Hogere snelheid, korter bereik         |
| 802.11g        | 2.4 GHz        | 54 Mbps          | 38 m                | 140 m               | Combinatie van b en a.                 |
| 802.11n        | 2.4/5 GHz      | 600 Mbps         | 70 m                | 250 m               | Ondersteunt MIMO, veel gebruikt        |
| 802.11ac       | 5 GHz          | 6,93 Gbps        | 35 m                | 120 m               | Hogere snelheden, veel gebruikt        |
| 802.11ax       | 2.4/5 GHz      | 9.6 Gbps         | 35 m                | 120 m               | Wi-Fi 6, verbeterde efficiëntie        |

**WLAN Begrippen: SSID en Service Sets**

1. **SSID (Service Set Identifier)**  
   - Naam van een draadloos netwerk.  
   - Wordt gebruikt door apparaten om het juiste netwerk te selecteren.  

2. **Soorten Service Sets**  
   - **IBSS (Independent Basic Service Set)**  
     - Ad-hoc netwerk zonder access point.  
     - Apparaten communiceren direct (bv. AirDrop).  
   - **BSS (Basic Service Set)**  
     - Apparaten verbinden via een access point.  
     - **BSSID** = MAC-adres van het AP.  
   - **BSA (Basic Service Area)**  
     - Het dekkingsgebied van één access point.  
   - **ESS (Extended Service Set)**  
     - Meerdere AP’s met dezelfde SSID.  
     - Maakt naadloos roaming mogelijk binnen hetzelfde netwerk.  


---