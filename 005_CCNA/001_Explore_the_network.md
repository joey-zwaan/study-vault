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

**Bandbreedte** – zorgt dat cruciaal verkeer (spraak/video) voorrang krijgt.  
**Vertraging (Delay)** – minimaliseert latency voor real-time toepassingen.  
**Jitter** – vermindert variatie in vertraging, belangrijk voor spraak/video.  
**Pakketverlies** – beperkt verlies voor een stabiele verbinding. 

Standaarden voor QoS in netwerken:
**One-way delay:** < 150 ms
**Jitter:** < 30 ms
**Packet loss:** < 1%
Als de standaarden overschreden worden, kan dit leiden tot een slechte gebruikerservaring, zoals haperende audio of video.

#### Queuing Mechanisms

1. **FIFO (First In, First Out)**  
   Pakketten worden verwerkt in volgorde van aankomst. Dit is het standaardmechanisme.  

2. **Tail Drop**  
   Nieuwe pakketten worden gedropt zodra de wachtrij vol is. Kan leiden tot **TCP global synchronization**:  
   Netwerkcongestie → Tail drop → TCP window reduction → Onderbenutting → TCP window increase → Nieuwe congestie.  

3. **RED (Random Early Detection)**  
   Dropt willekeurig pakketten voordat de wachtrij vol is. Voorkomt TCP global synchronization. Alle soorten verkeer worden gelijk behandeld.  

4. **WRED (Weighted Random Early Detection)**  
   Zelfde principe als RED, maar met prioriteit voor belangrijk verkeer.  
   Voorbeelden: **HTTP** minder snel droppen dan **FTP**, **VoIP** minder snel droppen dan **e-mail**.  




#### Verkeer classificeren en markeren voor QoS
1. **Classificatie-methoden**  
   ACLs (Access Control Lists): identificeren verkeer op basis van IP, poorten of protocol.  
   NBAR (Network-Based Application Recognition): herkent applicaties via deep packet inspection.  

2. **Markering in headers**  
   PCP (Priority Code Point) in VLAN-tag (Layer 2), ook wel Class of Service (IEEE 802.1p).  
   Er zijn 8 waarden (0–7). Voorbeelden:  
   0 = Best Effort, 3 = Critical Applications, 5 = Voice.  

3. **Toepassing van markering**  
   PCP-waarden kunnen worden toegevoegd door switches of IP-phones die QoS ondersteunen.  
   Dit werkt alleen over trunk links (tussen switches) of access links (tussen switch en IP-phone, waarbij de IP-phone de VLAN-tag toevoegt).  


#### QoS-markering met DSCP (Layer 3)

1. **DSCP- en ECN-velden in de IP-header**  
   Worden gebruikt voor QoS-markering en congestion notification.  

2. **Belangrijkste DSCP-waarden**  
   DF (Default Forwarding, 0): best-effort traffic.  
   AF (Assured Forwarding, 10–46): 4 klassen, elk met 3 drop-precedence niveaus (laag, medium, hoog). Hogere drop-precedence → eerder droppen bij congestie.  
   EF (Expedited Forwarding, 46): voor verkeer met lage latency, jitter en verlies (bv. voice).  
   CS (Class Selector, 8–56): compatibel met oude IP Precedence, gebruikt voor eenvoudige prioriteitsmarkering.  

3. **RFC 4594 standaardtoewijzingen**  
   Voice = EF (46)  
   Interactive Video = AF41 (34)  
   Signaling = CS3 (24)  
   High Priority Data = AF31 (26)  
   Best Effort = DF (0)  

4. **Trust Boundaries**  
   QoS-marking moet vertrouwd worden op specifieke punten in het netwerk. Apparaten buiten de trust boundary kunnen markeringen overschrijven. Best practice: trust boundary zo dicht mogelijk bij de bron (bv. access switch bij end devices zoals computers of IP-phones).  


#### QoS Scheduling & Traffic Conditioning

1. **Round-Robin**  
   Alle pakketten worden gelijk behandeld, ongeacht type verkeer.  

2. **Weighted Round-Robin**  
   Hoger geprioriteerd verkeer krijgt meer bandbreedte dan lager verkeer.  

3. **CBWFQ (Class-Based Weighted Fair Queuing)**  
   Weighted round-robin toegepast op verschillende klassen. Verkeer krijgt bandbreedte naar verhouding van toegewezen gewicht. Zorgt voor een eerlijk deel voor elk type verkeer.  

4. **LLQ (Low Latency Queuing)**  
   Strict priority queue voor delay-gevoelig verkeer zoals voice en video. Alle pakketten uit LLQ worden eerst verstuurd → minimale delay en jitter. Nadeel: ander verkeer kan verhongeren bij constante voice/video load.  

5. **Shaping & Policing**  
   Traffic Shaping buffert en spreidt verkeer om pieken af te vlakken. Policing dropt of markeert verkeer dat ingestelde limieten overschrijdt.  

---

## LAN Architectures

1. **Topologieën**  
   Star Topology: alle apparaten verbinden naar een centrale switch of hub. Voordeel: makkelijk uitbreidbaar.  
   Full Mesh Topology: elk apparaat is direct verbonden met elk ander apparaat. Voordeel: maximale redundantie en betrouwbaarheid. Nadeel: duur en complex, vooral in grote netwerken.  
   Partial Mesh Topology: sommige apparaten zijn direct verbonden, anderen via tussenliggende apparaten. Dit biedt een balans tussen redundantie en kosten.  

2. **Netwerk Lagen**  
   Access Layer: verbinding voor eindgebruikers en apparaten (switches, APs).  
   Distribution Layer: brug tussen access en core. Aggregatie van verkeer, toepassen van QoS, filtering en routing. Typisch multi-layer switches (L2 + L3).  
   Core Layer (in 3-tier model): snelle data forwarding tussen distribution lagen.  

3. **Architecturen**  
   2-Tier (Collapsed Core Architecture): distribution en core samengevoegd. Voordeel: eenvoud en lagere kosten. Nadeel: minder schaalbaar, risico op prestatieproblemen.  
   3-Tier Architecture: bestaat uit access, distribution en core. Voordeel: schaalbaarheid, redundantie en prestaties. Gebruikt in datacenters (goed bij veel noord-zuid verkeer). Nadeel: kan bottlenecks creëren bij veel oost-west verkeer (servers ↔ servers).  
   Spine-Leaf Architecture: bestaat uit spine en leaf lagen. Elke leaf is verbonden met elke spine. Geen verbindingen tussen spine-switches of leaf-switches. Voordeel: hoge beschikbaarheid, lage latentie, schaalbaar. Geschikt voor moderne datacenters met veel oost-west verkeer. End devices (servers, storage) verbinden aan leaf switches.  


---

## Wireless LAN (WLAN)

De standaarden die we gebruiken voor WLAN zijn gedefinieerd door de IEEE 802.11 groep.
De term Wi-fi is een merknaam die wordt beheerd door de Wi-Fi Alliance, een organisatie die certificering en promotie van draadloze netwerktechnologieën verzorgt. Het gebruik van de term "Wi-Fi" impliceert dat een apparaat voldoet aan bepaalde interoperabiliteitsnormen die zijn vastgesteld door deze organisatie.


Alle apparaten in range ontvangen alle frames; zoals devices bij een hub. Het is de taak van het ontvangende apparaat om te bepalen of het frame voor hem bedoeld is (aan de hand van het MAC-adres).
Bij draadloze netwerken encrypteer je de frames om te voorkomen dat anderen ze kunnen lezen.
We gebruiken CSMA/CA (Collision Avoidance) in plaats van CSMA/CD (Collision Detection) omdat het moeilijk is om te detecteren of er een collision is op een draadloos medium. In plaats daarvan proberen apparaten te voorkomen dat ze tegelijkertijd zenden door eerst te luisteren of het kanaal 

1. **Signal absorption**  
   Materialen zoals beton, hout en metaal kunnen draadloze signalen absorberen, waardoor de signaalsterkte afneemt.  

2. **Reflection**  
   Draadloze signalen kunnen reflecteren op oppervlakken zoals muren en meubels, wat kan leiden tot slechte receptie.  

3. **Refraction**  
   Een golf buigt af als het door verschillende media gaat waar het signaal een andere snelheid heeft. Voorbeeld: licht gaat langzamer door water dan door lucht, waardoor het buigt als het door water gaat.  

4. **Diffraction**  
   Gebeurt wanneer een golf een obstakel tegenkomt en eromheen buigt. Dit kan zorgen voor blind spots achter het obstakel.  

5. **Scattering**  
   Wanneer een golf op kleine deeltjes botst en in verschillende richtingen wordt verspreid, wat leidt tot een zwakker signaal.  

6. **Interference**  
   Andere elektronische apparaten zoals magnetrons, babyfoons en Bluetooth-apparaten kunnen storing veroorzaken. Voorbeeld: 2.4 GHz is druk bezet en daardoor gevoeliger voor interferentie en prestatieverlies.  

#### WLAN Radio Frequencies
1. **Basisbegrippen**  
   Amplitude: sterkte van het signaal (gemeten in dBm). Hoger = sterker.  
   Frequentie: snelheid van de golf (Hz). Hogere frequentie = meer data, korter bereik.  
   Wavelength (golflengte): afstand tussen twee pieken. Kortere golflengte = gevoeliger voor obstakels.  
   Period: tijd voor één volledige cyclus (s). Kortere periode = hogere frequentie.  

2. **Wi-Fi Frequentiebanden**  
   2.4 GHz: lang bereik, veel interferentie (bv. andere apparaten).  
   5 GHz: korter bereik, minder interferentie, hogere snelheid.  
   6 GHz: nieuwste band, hoogste snelheid, laagste bereik, zeer weinig interferentie.  

3. **Kanaalgebruik**  
   2.4 GHz: gebruik kanalen 1, 6 en 11 → overlappen niet.  
   5 GHz: meer niet-overlappende kanalen beschikbaar → minder kans op storing.  



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
   Naam van een draadloos netwerk. Wordt gebruikt door apparaten om het juiste netwerk te selecteren.  

2. **Soorten Service Sets**  
   IBSS (Independent Basic Service Set): ad-hoc netwerk zonder access point, apparaten communiceren direct (bv. AirDrop).  
   BSS (Basic Service Set): apparaten verbinden via een access point. BSSID = MAC-adres van het AP.  
   BSA (Basic Service Area): het dekkingsgebied van één access point.  
   ESS (Extended Service Set): meerdere AP’s met dezelfde SSID, ondersteunt naadloos roaming binnen hetzelfde netwerk.  


---