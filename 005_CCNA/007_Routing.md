# Routing

**Inleiding**

Routing is het proces waarbij routers bepalen welke route IP-pakketten moeten volgen om hun bestemming te bereiken. Routers bewaren routes van bekende netwerken in hun routing table en kiezen op basis daarvan de beste route voor elk ontvangen pakket.

## Soorten Routing

Er zijn twee hoofdtypen routing:

- **Statische routing:** Handmatig geconfigureerd door een beheerder.
- **Dynamische routing:** Automatisch beheerd door routingprotocollen, waarbij routers informatie uitwisselen en hun routing tables aanpassen bij netwerkveranderingen.

Een route vertelt de router waar een pakket naartoe moet: naar een next-hop router of, als het netwerk direct verbonden is, naar de juiste interface. Is de bestemming het eigen IP-adres van de router, dan wordt het pakket direct afgeleverd aan de router zelf.

***Routing Details**

- **Local route:** Het specifieke IP-adres van de router op een interface.
- **Connected route:** Een netwerk dat direct verbonden is met de router via een interface.

Voorbeeld:  
Bij een connected route naar `192.168.1.0/24` worden alle adressen binnen dat netwerk doorgestuurd, andere adressen worden gedropt.

```
192.168.1.2   → match, wordt verstuurd
192.168.1.7   → match, wordt verstuurd
192.168.1.89  → match, wordt verstuurd
192.168.2.1   → geen match, wordt gedropt
```

Als een pakket op meerdere routes matcht, kiest de router altijd de meest specifieke (langste prefix).  
Bijvoorbeeld:

- `192.168.1.0/24`
- `192.168.1.1/32`

Voor bestemming `192.168.1.1` kiest de router de `/32` route.

Routers flooden nooit zoals switches. Als een router geen route kent naar de bestemming, wordt het pakket altijd gedropt.

**Default Gateway**

End hosts gebruiken een default gateway om adressen buiten hun eigen netwerk te bereiken. De default route (`0.0.0.0/0`) geeft aan waar pakketten naartoe moeten als er geen specifieke route bekend is.

**Point-to-Point Verbindingen**

Bij een point-to-point verbinding, zoals tussen twee routers, kun je een `/31` subnet gebruiken omdat je geen broadcast of netwerkadres nodig hebt. Dit geeft je precies twee bruikbare IP-adressen voor de twee routers.


### ROAS (Router-on-a-Stick)

**Router-on-a-Stick (ROAS)** is een methode waarbij één enkele fysieke routerinterface gebruikt wordt om verkeer tussen meerdere VLANs te routeren. Dit gebeurt door op die interface meerdere **subinterfaces** te configureren. Elke subinterface is gekoppeld aan een specifieke VLAN via **802.1Q VLAN-tagging**.

Deze aanpak is nodig omdat switches standaard geen verkeer tussen VLANs doorlaten (layer 2-beperking). Door een router toe te voegen (layer 3), wordt **inter-VLAN-communicatie** mogelijk. In plaats van voor elke VLAN een aparte fysieke verbinding te voorzien, wordt met ROAS alles via één trunkverbinding afgehandeld.

De switch stuurt getagd verkeer naar de router via een **trunkpoort**. De router herkent aan de hand van de tag tot welke VLAN het verkeer behoort, en stuurt het via de juiste subinterface naar het bijhorende subnet. Als verkeer van VLAN 10 naar VLAN 20 moet, verloopt dit via de router die beide subnets kent en daartussen kan routeren.

**Waarom gebruiken?**

- Bespaart fysieke interfaces
- Eenvoudig te beheren in kleine tot middelgrote netwerken
- Maakt VLAN-segmentatie mogelijk met centrale routing

Deze techniek is ideaal in omgevingen waar meerdere VLANs actief zijn, maar slechts één routerinterface beschikbaar is.

```cisco
interface g0/0.10
 encapsulation dot1Q 10
 ip address 192.168.1.1 255.255.255.0
```

- `g0/0.10`: Subinterface voor VLAN 10  
- `encapsulation dot1Q 10`: VLAN 10 tagging inschakelen  
- `ip address`: Default gateway voor VLAN 10 clients

### Intervlan Routing L3 Switch

Een L3 switch kan ook intervlan routing doen zonder een router. Dit wordt vaak gebruikt in grotere netwerken waar meerdere VLANs zijn en routing tussen deze VLANs nodig is. De L3 switch heeft interfaces die geconfigureerd zijn voor elk VLAN, en kan verkeer tussen deze VLANs routeren zonder dat een aparte router nodig is.


Dit gebeurd door middel van SVI (Switched Virtual Interface).

SVI's zijn virtuele interfaces die aan een VLAN zijn gekoppeld en fungeren als de default gateway voor dat VLAN. 
Als het VLAN niet bestaat op de switch, dan gaat de interface down blijven ookal heb je het no-shutdown commando gebruikt.


```cisco
interface Vlan10
 ip address 192.168.1.1 255.255.255.0
```

### Dynamic Routing Protocols

Routers maken gebruik van dynamische routingprotocollen zoals OSPF, RIP, EIGRP of BGP om informatie te adverteren over routes naar netwerken die ze kennen.
Ze vormen "adjacencies" met andere routers en wisselen informatie uit over hun routes naar andere netwerken.

Als meerdere routes naar een netwerk beschikbaar zijn, kiest de router de beste route op basis van de metric die superior is aan de andere route (lagere metric = superior).

Dynamic routing protocollen kunnen verdeld worden in twee categorieën:
- **Interior Gateway Protocols (IGP):** Gebruikt binnen een autonoom systeem (bijv. OSPF, EIGRP, RIP) Dit is bijvoorbeeld een enkele organisatie (een bedrijf).

- **Exterior Gateway Protocols (EGP):** Gebruikt om informatie uit te wisselen tussen verschillende autonome systemen (bijv. BGP) bijvoorbeeld tussen verschillende providers of organisaties.
> Enkel BGP wordt gebruikt in moderne netwerken.

**We kunnen dit verder onderverdelen in algoritmes:**

- **Distance Vector:** Routers sturen hun volledige routing table naar directe buren (RIP & EIGRP). Ze weten alleen de afstand tot een netwerk, niet de route ernaartoe.
> IGP zoals RIP en EIGRP gebruiken distance vector algoritmes.

- **Link State:** Routers sturen updates over de status van hun directe verbindingen (OSPF & IS-IS). Ze kennen de volledige topologie van het netwerk en kunnen de beste route berekenen op basis van die informatie.
> IGP zoals OSPF en IS-IS gebruiken link state algoritmes.

- **Path Vector:** Routers houden bij welke paden ze hebben genomen om een netwerk te bereiken (bijv. BGP). Ze kunnen complexe beslissingen nemen op basis van beleidsregels en padinformatie.
> EGP zoals BGP gebruikt path vector algoritmes.

<img src="/assets/dynamic-routing.png" alt="Dynamic Routing Protocols" width="600">


#### Distance Vector Protocols

Distance vector protocollen werden ontwikkeld vóór de introductie van link-state protocollen.  
Voorbeelden hiervan zijn **RIPv1** en **IGRP**, die later werden verbeterd naar **RIPv2** en **EIGRP**.

**Werking**

- Elke router deelt op vaste tijdsintervallen zijn volledige routingtabel met directe buren  
- De ontvangen informatie bevat:
  - Netwerken die de router kent  
  - De bijbehorende **metrics** (bijv. hopcount bij RIP, samengestelde metric bij EIGRP)  

**Extra kenmerken**

- Dit mechanisme wordt ook wel *routing by rumor* genoemd:  
  Routers weten alleen wat hun buren hen vertellen, zonder volledig beeld van de netwerktopologie.  
- **Distance Vector** verwijst naar:
  - **Distance:** de afstand tot een netwerk, gemeten in hops of andere metrics  
  - **Vector:** de richting (volgende hop) naar dat netwerk  
- Routers delen dus **afstand en richting**, maar niet het volledige pad ernaartoe  


#### Link State Protocols

- Elke router verzamelt informatie over zijn **direct verbonden interfaces (links)**  
- Die informatie wordt in de vorm van **link-state updates (LSAs)** verzonden naar **alle routers binnen hetzelfde gebied** (niet enkel buren)  
- Zo bouwen alle routers onafhankelijk een **identieke topologische kaart** van het netwerk op

**Routeberekening**

- Elke router gebruikt zijn eigen kopie van de netwerktopologie om via het **Dijkstra-algoritme (SPF – Shortest Path First)** de beste routes naar elk netwerk te berekenen  
- Dit gebeurt **lokaal en onafhankelijk**, zonder extra communicatie, wat zorgt voor snellere convergentie  
- Omdat elke router de volledige kaart heeft, zijn de berekende routes consistent en efficiënt

**Extra kenmerken**

- Link-state protocollen vereisen meer **CPU**, **RAM** en **bandbreedte** dan distance vector protocollen, zeker bij grote netwerken  
- Ze reageren echter veel sneller op topologieveranderingen doordat LSAs onmiddellijk worden doorgestuurd  
- Ondersteunen **Equal-Cost Multi-Path (ECMP)**:  
  - Wanneer er meerdere routes naar een bestemming zijn met exact dezelfde metric, kan de router deze routes **gelijktijdig gebruiken**  
  - Dit verdeelt het verkeer over meerdere paden en verhoogt de efficiëntie van de netwerkdoorvoer  

#### Metrics 

**RIP:**

- Gebruikt hopcount als metric (maximaal 15 hops, 16 is onbereikbaar)  
- Eenvoudig te implementeren, maar niet schaalbaar voor grote netwerken  

**EIGRP:**

- Gebruikt een samengestelde metric gebaseerd op bandbreedte, vertraging, belasting en MTU
- De EIGRP metric is primair gebaseerd op de laagste bandbreedte van het pad en de som van de vertragingen over alle links in het pad.
- Ondersteunt **Equal-Cost Multi-Path (ECMP)** voor load balancing over meerdere gelijke paden
- Ondersteunt **unequal-cost load balancing**:  
  - Kan verkeer over paden met verschillende metrics verdelen, afhankelijk van configuratie  
  - Dit maakt het mogelijk om suboptimale paden te gebruiken zonder ze volledig uit te schakelen

**OSPF:**

- Gebruikt **cost** als metric, gebaseerd op de bandbreedte van de links
- De cost wordt berekend als 100.000.000 / bandbreedte in bps (bijv. 100 Mbps link heeft cost 1)
- Ondersteunt **Equal-Cost Multi-Path (ECMP)** voor load balancing over meerdere gelijke paden
- Ondersteunt **unequal-cost load balancing**:  
  - Kan verkeer over paden met verschillende kosten verdelen, afhankelijk van configuratie  
  - Dit maakt het mogelijk om suboptimale paden te gebruiken zonder ze volledig uit te schakelen



**IS-IS:**
- Gebruikt **cost** als metric, vergelijkbaar met OSPF
- Standaard wordt deze cost handmatig toegekend aan elke link
- Elke route heeft standaard een cost van 10

#### Administrative Distance (AD) en Metrics

De **Administrative Distance (AD)** is een waarde die aangeeft hoe betrouwbaar een route is. Het wordt gebruikt wanneer een router meerdere routes naar hetzelfde netwerk kent via verschillende routingprotocollen. De route met de **laagste AD** wordt als meest betrouwbaar beschouwd en krijgt voorrang in de routing table.

Wanneer een router meerdere routes naar hetzelfde netwerk via **hetzelfde protocol** leert, bepaalt de **metric** van dat protocol welke route gekozen wordt. Alleen wanneer er routes via **verschillende protocollen** zijn, gebruikt de router de AD om te bepalen welke route in de routing table wordt geplaatst.


| Route protocol/type          | AD   | Route protocol/type      | AD   |
|-----------------------------|------|-------------------------|------|
| Directly connected          | 0    | IS-IS                   | 115  |
| Static                      | 1    | RIP                     | 120  |
| External BGP (eBGP)         | 20   | EIGRP (external)        | 170  |
| EIGRP                       | 90   | Internal BGP (iBGP)     | 200  |
| IGRP                        | 100  | Unusable route          | 255  |
| OSPF                        | 110  |                         |      |

**Voorbeeld van AD en Metrics in de routing table:**

- **[110/2400]** betekent dat de route via OSPF is geleerd, met een metric van 2400.
- **[110/0]** betekent dat de route via OSPF is geleerd, maar de metric is 0 (bijvoorbeeld een direct verbonden netwerk).

De eerste waarde is de **Administrative Distance (AD)**, die aangeeft via welk protocol de route is geleerd en hoe betrouwbaar deze wordt geacht.  
De tweede waarde is de **metric**, die aangeeft hoe "ver" de route is of hoe gunstig deze door het betreffende protocol wordt beoordeeld.

### RIP & EIGRP

RIP (Routing Information Protocol) en EIGRP (Enhanced Interior Gateway Routing Protocol) zijn beide distance vector protocollen, maar met verschillende kenmerken en toepassingen.

**RIP:**

- Eenvoudig te implementeren en configureren
- Beperkt tot 15 hops (maximale afstand)
- Periodieke updates (iedere 30 seconden)
- Geen ondersteuning voor VLSM of CIDR

RIP heeft 3 versies:
- **RIPv1:** IPv4, classful routing (geen ondersteuning voor VLSM of CIDR) Het zijn broadcast berichten. 255.255.255.255
Gebruikt geen subnetmaskers in zijn advertisements.
- **RIPv2:** IPv4, classless routing (ondersteunt VLSM en CIDR) het zijn multicast berichten. 224.0.09
Gebruikt subnetmaskers in zijn advertenties.
 

- **RIPng:** Ondersteunt IPv6
Ze gebruiken 2 messages:

- **Request:** Om informatie op te vragen van buren
- **Response:** Om informatie te delen met buren

**EIGRP**

- Ondersteunt **Equal-Cost Multi-Path (ECMP)** voor load balancing over meerdere gelijke paden
- Ondersteunt **unequal-cost load balancing**:  
  - Kan verkeer over paden met verschillende kosten verdelen, afhankelijk van configuratie  
  - Dit maakt het mogelijk om suboptimale paden te gebruiken zonder ze volledig uit te schakelen
  - EIGRP gebruikt een complexe metric die bandbreedte, vertraging, belasting en MTU in overweging neemt

**Wildcard mask:**

Alle 1's in het subnetmasker worden 0's in het wildcard mask, en alle 0's worden 1's. voorbeelden:

- Subnetmasker: 255.255.255.0
- Wildcard mask: 0.0.0.255

Dit komt doordat binair 255.255.255.0 gelijk is aan 11111111.11111111.11111111.00000000, en het wildcard mask is de inverse daarvan: 00000000.00000000.00000000.11111111.

- Subnetmasker: 255.255.255.128
- Wildcard mask: 0.0.0.127

Dit komt doordat binair 255.255.255.128 gelijk is aan 11111111.11111111.11111111.10000000, en het wildcard mask is de inverse daarvan: 00000000.00000000.00000000.01111111.

- Subnetmasker: 255.255.255.192
- Wildcard mask: 0.0.0.63

Dit komt doordat binair 255.255.255.192 gelijk is aan 11111111.11111111.11111111.11000000, en het wildcard mask is de inverse daarvan: 00000000.00000000.00000000.00111111.

Een kortere manier om uit te rekenen is om elk octet af te trekken van het subnetmask 255.


<img src="/assets/wildcard.png" alt="Wildcard Masken" width="600" />

#### Terminology EIGRP

**Feasible Successor** = een alternatieve route die kan worden gebruikt als de primaire route faalt (niet de beste route)
**Feasible Condition** = De route is een feasible successor als de reported distance lager is dan de successor route feasible distance.
**Feasible Distance** = De totale afstand (metric) naar de bestemming zoals gerapporteerd door de router.
**Reported Distance** = De afstand (metric) naar de bestemming zoals gerapporteerd door een andere router.
**Successor** = the route met de laagste metric (de beste route)

### Link State Routing Protocols

Wanneer je een link state routing protocol gebruikt maakt elke router een 'connectivity' map van het netwerk.

Om dit te doen werken advertised elke router informatie over zijn interfaces (connected networks) naar zijn buren. Deze advertisement worden dan doorgestuurd door de andere routers tot alle routers in het netwerk een zelfde map van het netwerk hebben.

Elke router individueel gebruikt deze map om de beste routes te bereken naar elke bestemming.

Link state protocols gebruiken meer rescources van de CPU op de router omdat er meer informatie gedeeld wordt. Link state routing protocols reageren sneller op veranderingen dan distance vector protocols.

#### OSPF

OSPF (Open Shortest Path First) is een link‑state routingprotocol. Het gebruikt het Dijkstra‑algoritme (SPF) om de kortste paden te berekenen. Ontworpen voor grotere netwerken: snelle convergentie en schaalbaarheid.

**Versies**
- OSPFv1: verouderd
- OSPFv2: IPv4
- OSPFv3: IPv6

**LSA’s en LSDB**
- Routers adverteren Link State Advertisements (LSA’s)
- LSA’s vormen de Link State Database (LSDB) per area
- LSA’s worden geflood binnen de area; aging ± 30 min, daarna refresh

**Basiswerking**
1. Routers in hetzelfde area vormen neighbors
2. Ze wisselen LSA’s uit en synchroniseren de LSDB
3. Elke router runt lokaal SPF en installeert beste routes

**Areas**
- Area = set routers/links met dezelfde LSDB
- Backbone = area 0; alle andere areas verbinden logisch met area 0
- Internal router: alle interfaces in één area
- ABR (Area Border Router): interfaces in meerdere areas; één LSDB per area (aanbevolen max. 2 areas per ABR)
- Route‑types:
  - Intra‑area: binnen dezelfde area
  - Inter‑area: tussen verschillende areas

**Rules**

Elke area moet aaneengeschakeld zijn.
Elke area moet minstens 1 ABR connected hebben aan backbone area 0.
OSPF interfaces die in hetzelfde subnet zitten moeten ook in dezelfde area zitten.

<img src="/assets/OSPF1.png" alt="OSPF Areas" width="600">

**Basic configuration**

```cisco
router ospf 1
 network 192.168.1.0 0.0.0.255 area 0
 network 192.168.2.0 0.0.0.255 area 1
 network 192.168.3.0 0.0.0.255 area 1
```


router loopback interface commands

```cisco
interface loopback 0
 ip address 192.168.1.1 255.255.255.255
```

**Router ID order of priority**

1. Manuele configuratie
2. Hoogste IP-adres op een loopback-interface
3. Hoogste IP-adres op een fysieke interface

Een autonomous system boundary router (ASBR) is een router die het OSPF netwerk verbindt met een extern netwerk.

**Router loopback interface**

Je kunt een loopback-interface op een router configureren om te dienen als een stabiele OSPF-router-ID. Dit wordt gedaan door een virtuele interface te maken die altijd actief is en een IP-adres kan krijgen. De loopback-interface heeft de voorkeur voor de router-ID omdat deze niet is gekoppeld aan een fysieke interface, die kan uitvallen.
