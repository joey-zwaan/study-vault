# Switching

## Inleiding

Dit document beschrijft de verschillen tussen full duplex en half duplex, de werking van switches en hubs, het concept van collision en broadcast domains, VLAN’s, het CSMA/CD-protocol en speed/duplex autonegotiation.

## Full Duplex vs Half Duplex

In een half-duplex verbinding kan data in beide richtingen worden verzonden, maar niet tegelijkertijd. In een full-duplex verbinding kunnen beide apparaten gelijktijdig data verzenden en ontvangen.

- **Half-duplex:** Apparaten kunnen om de beurt verzenden en ontvangen, maar niet tegelijkertijd. Dit kan leiden tot vertragingen en inefficiëntie.
- **Full-duplex:** Apparaten kunnen gelijktijdig verzenden en ontvangen, wat zorgt voor een snellere en efficiëntere communicatie. Dit is de standaardmodus voor moderne netwerken.

## Switches, Hubs en Domains

- **Switches:** Werken meestal in full-duplex modus, waardoor ze gelijktijdig data kunnen verzenden en ontvangen op verschillende poorten. Dit verhoogt de netwerkcapaciteit en vermindert vertragingen.
- **Hubs:** Werken in half-duplex modus, waardoor slechts één apparaat tegelijk kan verzenden. Dit kan leiden tot botsingen en vertragingen in het netwerk.
- **Collision Domain:** Een netwerksegment waar apparaten data kunnen versturen en ontvangen, maar waar botsingen kunnen optreden als twee apparaten tegelijkertijd proberen te verzenden. Switches verminderen het aantal collision domains door elke poort een eigen domein te geven, terwijl hubs alle poorten in één domein plaatsen.
- **Broadcast Domain:** Een netwerksegment waar een broadcast-pakket door alle apparaten kan worden ontvangen. Switches beperken broadcast domains door VLAN's te gebruiken, terwijl hubs alle poorten in één broadcast domain plaatsen.
- **VLAN's (Virtual Local Area Networks):** Logische scheidingen binnen een switch die het mogelijk maken om verschillende netwerken te creëren binnen hetzelfde fysieke netwerk. Dit helpt bij het verminderen van broadcast verkeer en het verbeteren van de netwerkbeveiliging.

## CSMA/CD Protocol

CSMA/CD (Carrier Sense Multiple Access with Collision Detection) is een protocol dat wordt gebruikt in netwerken om botsingen te detecteren en te voorkomen wanneer meerdere apparaten tegelijkertijd proberen te verzenden.  
Het werkt door eerst te luisteren naar het netwerk om te controleren of het vrij is voordat een apparaat begint met verzenden. Als er een botsing optreedt, stoppen de apparaten met verzenden en wachten ze een willekeurige tijd voordat ze opnieuw proberen te verzenden.

## Speed/Duplex Autonegotiation

Speed/Duplex autonegotiation is een proces waarbij apparaten automatisch de beste snelheid en duplexmodus bepalen voor hun verbinding. Dit zorgt ervoor dat apparaten die verschillende snelheden of duplexmodi ondersteunen, toch effectief kunnen communiceren.

Interfaces die verschillende snelheden aankunnen hebben default setting van speed auto en duplex auto. Dit betekent dat de interface automatisch de beste snelheid en duplexmodus zal kiezen op basis van de mogelijkheden van het verbonden apparaat.

Interfaces adverteren hun snelheid en duplexmodus aan elkaar, zodat ze kunnen onderhandelen over de beste instelling die ze beide ondersteunen. Dit gebeurt meestal via het autonegotiation-protocol, dat informatie uitwisselt over de mogelijkheden van elk apparaat.

---


## Protocols

### DTP

DTP (Dynamic Trunking Protocol) is een Cisco-protocol dat automatisch trunk links tussen switches kan configureren. Het maakt het mogelijk om trunking automatisch in te schakelen zonder handmatige configuratie.

DTP is bij default op alle Cisco-switches ingeschakeld.
DTP is best uitgeschakeld op alle interfaces.

switchport in dynamic desirable mode zal proberen een trunk link te maken met de andere kant. Het vormt een trunk links als de andere kant de volgende modes staat:

switchport mode trunk, switchport mode dynamic desirable, switchport mode dynamic auto.

switchport in dynamic auto mode zal niet actief een trunk link proberen te maken, maar zal wel een trunk link vormen als de andere kant in dynamic desirable mode staat of trunk mode staat.

Wat gebeurt er als de ene kant manueel op access staat en de andere kant manueel op trunk?

In dit geval zal de trunk link niet worden gevormd. De switch die in access mode staat, zal geen trunking toestaan, terwijl de switch in trunk mode verwacht dat de andere kant ook trunking ondersteunt. Hierdoor blijft de link in een down-toestand totdat beide zijden correct zijn geconfigureerd.

DTP zal geen trunk vormen met een router of een PC, de switch zal in access mode gaan staan.

je kan het uitschakelen met
```cisco
switchport nonegotiate
```
Als je een access port met switchport mode access hebt geconfigureerd, zal DTP niet actief zijn op die poort. De poort blijft in access mode en zal geen trunking proberen te vormen, ongeacht de configuratie van de andere kant.

Dit wordt altijd aanbevolen van niet te gebruiken en uit te schakelen, omdat het kan leiden tot onvoorspelbaar gedrag en problemen met de netwerkconfiguratie. Het is beter om handmatig trunking te configureren waar nodig, zodat je volledige controle hebt over de netwerkverbindingen.

### VTP

VTP (VLAN Trunking Protocol) is een Cisco-protocol dat VLAN-informatie tussen switches verspreidt. Het maakt het mogelijk om VLAN's centraal te beheren en te synchroniseren over meerdere switches in een netwerk.

Het is zelden gebruikt, en word aanbevolen om het uit te schakelen op alle switches, omdat het kan leiden tot ongewenste VLAN-wijzigingen en netwerkproblemen.


**VTP Servers**:

- Add , delete en modify VLANS
- Slaan de VLAN database op in NVRAM
- Zullen elke keer de revision verhogen als er een wijziging is.
- Zal synchroniseren met een andere VTP server als deze een hogere revision heeft. dus wordt hij ook een VTP client.

**VTP Clients**:

- Kunnen geen VLAN's toevoegen, verwijderen of wijzigen.
- Volgen de VLAN database van de VTP server.
- Slaan de VLAN database niet op in NVRAM wel in VTPv3
- Advertiseren hun VLAN database en forwarden VTP advertisements aan andere clients over trunk ports.

**VTP Domains**:

- Alle switches in een VTP domein moeten dezelfde domeinnaam hebben.
- VTP domeinen kunnen worden gebruikt om VLAN's te scheiden tussen verschillende delen van een netwerk.

Grootste gevaar van VTP is dat als je een switch toevoegt met een hogere revision dan de huidige VTP server, deze de VLAN database zal overschrijven en mogelijk VLAN's zal verwijderen die niet meer bestaan. Dit kan leiden tot netwerkproblemen en verlies van connectiviteit.

**VLAN transparent mode**:

- Houd zijn eigen VLAN-database bij en zal deze niet synchroniseren met andere switches.
- Forwarden VTP advertisements, maar zal deze niet verwerken of erop reageren.

### Spanning Tree Protocol Varianten (IEEE & Cisco)

**IEEE-standaarden**

- Spanning Tree Protocol (802.1D):  
  De originele STP. Eén instantie voor alle VLANs, geen load balancing.

- Rapid Spanning Tree Protocol (802.1w):  
  Snellere convergentie dan 802.1D. Ook één instantie voor alle VLANs, geen load balancing.

- Multiple Spanning Tree Protocol (802.1s):  
  Maakt gebruik van aangepaste RSTP. Kan meerdere VLANs groeperen in aparte instanties voor load balancing.

**Cisco-versies**

- PVST+ (Per-VLAN Spanning Tree Plus):  
  Cisco’s versie van 802.1D. Elke VLAN krijgt een aparte STP-instantie, waardoor load balancing mogelijk is.

- Rapid PVST+ (Rapid Per-VLAN Spanning Tree Plus):  
  Cisco’s versie van 802.1w. Ook hier heeft elke VLAN een eigen, snellere STP-instantie en is load balancing mogelijk.


#### Spanning Tree Protocol (STP)

Spanning Tree Protocol (STP) is een netwerkprotocol dat wordt gebruikt om loops in Ethernet-netwerken te voorkomen. Het zorgt ervoor dat er slechts één actieve pad is tussen twee netwerkapparaten, waardoor broadcast storms en andere problemen worden voorkomen. Bij elke fabrikant is STP standaard ingeschakeld op switches.


**Broadcast storms**:

Een broadcast storm ontstaat wanneer er door een netwerkloop of fout te veel broadcastverkeer, zoals ARP of DHCP, in een netwerk circuleert. Hierdoor raken switches en andere netwerkapparaten overbelast, waardoor het netwerk traag wordt of zelfs volledig uitvalt. Dit gebeurt als er meerdere paden zijn tussen switches en je geen STP gebruikt.

Op laag 3 wordt overmatig verkeer beperkt door de TTL-waarde (Time To Live) in het IP-header, maar op laag 2 (Ethernet) bestaat zo’n limiet niet. Daarom is op laag 2 het Spanning Tree Protocol (STP) nodig, zodat netwerklussen automatisch gedetecteerd en uitgeschakeld worden en broadcast storms worden voorkomen.

**MAC Address Flapping**: 

Wanneer frames met hetzelfde source MAC address herhaaldelijk worden ontvangen op verschillende interfaces blijft de switch continue zijn MAC-adres tabel updaten. Dit kan leiden tot netwerkproblemen en vertragingen, omdat de switch steeds opnieuw moet bepalen waar het frame naartoe moet worden gestuurd.


#### Werking van STP

**STP en het voorkomen van loops**:

STP voorkomt Layer 2 loops door redundante ports in een blocking state te zetten. STP selecteert welke ports in forwarding state staan en welke in blocking state. Het creert een single path van en naar elk punt in het netwerk.

Dit is een vastgelegd process dat STP gebruikt om te fbepalen welke poorten actief zijn en welke geblokkeerd worden.

**Bridge Protocol Data Units (BPDU's)**:

- STP-switches sturen en ontvangen Hello BPDUs op alle interfaces, standaard elke 2 seconden.
- Alleen switches nemen deel aan het STP-proces; andere apparaten zoals pc's of routers doen hier niet aan mee.
- Interfaces die zich in blocking state bevinden, sturen en ontvangen nog wel BPDUs. Zo blijft de switch op de hoogte van eventuele topologieveranderingen.

**Root Bridge-verkiezing**:

- Elke BPDU bevat een Bridge ID, bestaande uit prioriteit (standaard 32768) en MAC-adres (tie-breaker bij gelijke prioriteit).
- De switch met de laagste Bridge ID wordt de root bridge voor het netwerk.
- Alle poorten op de root bridge staan in forwarding state.


<img src="/assets/SPT-election.png" alt="STP Election" width="600">


**Root Port-selectie op niet‑root switches**:

- Elke switch berekent de root cost (padkosten) per interface, gebaseerd op link-snelheid.
- De interface met de **laagste root cost** wordt geselecteerd als **root port** (forwarding).
- Bij gelijke kosten geldt deze volgorde:
  1. Laagste **sender Bridge ID** (het MAC‑adres van de buur-switch).
  2. Bij gelijke Bridge ID: laagste **sender Port ID** (poortprioriteit/nummer op de buur).

<img src="/assets/STP-cost.png" alt="STP Root cost" width="600">

<img src="/assets/STP-tiebreaker.png" alt="STP tiebreaker" width="600">

**Designated Port**

- De **designated port** is op elk collision domain de poort die door STP is aangewezen om verkeer door te sturen naar de rest van het netwerk.
- Alleen de designated port mag frames en BPDUs vanuit het collision domain forwarden.
- Op elk collision domain is er precies één STP designated port (gekozen op basis van de laagste path cost naar de root bridge) en deze staat in forwarding state.


*Let op:*  
Ook een switchpoort naar een pc is een collision domain; de switchpoort is daar altijd de designated port (de pc zelf neemt niet deel aan STP).

**Non-Designated Port**
- Een **non-designated port** is een poort die niet de designated port is voor dat segment.
- Deze poorten staan in blocking state en ontvangen geen verkeer, behalve BPDUs.
- Non-designated ports zijn essentieel voor het voorkomen van loops in het netwerk.


<img src="/assets/SPT-timer.png" alt="STP Designated Port" width="600">


**BPDU Types en Flags in STP**

Ethernet frames bevatten een header met een EtherType-veld dat aangeeft welk protocol wordt gebruikt.  
Voor STP/RSTP BPDU’s wordt Protocol Identifier `0x0000` gebruikt in het BPDU-pakket.

**BPDU Type:**
- `0x00`: Configuration BPDU (voor topologie-informatie)

**BPDU Flags:**
- `0x01`: Topology Change (TC) flag — geeft aan dat er een topologieverandering is
- `0x02`: Topology Change Acknowledgment (TCA) flag — bevestigt ontvangst van een TC BPDU

#### STP Poortstaten

| Status      | Verkeer doorlaten | MAC-adressen leren | BPDU's | Doel / Opmerking                                  |
|-------------|------------------|--------------------|--------|---------------------------------------------------|
| Blocking    | Nee              | Nee                | Ontvangen | Loops vermijden door overbodige verbindingen te blokkeren |
| Listening   | Nee              | Nee                | Ontvangen/Verzenden | Controleren op loops, geen frames doorgestuurd    |
| Learning    | Nee              | Ja                 | Ontvangen/Verzenden | MAC-adrestabel opbouwen, voorbereiding op forwarding |
| Forwarding  | Ja               | Ja                 | Ontvangen/Verzenden | Normale operationele staat, verkeer wordt doorgestuurd |
| Disabled    | Nee              | Nee                | Geen   | Poort is uitgeschakeld of administratief down     |

**Toelichting:**
- **Blocking:** Alleen BPDU’s ontvangen, geen verkeer of MAC-adressen.
- **Listening:** Luistert naar BPDU’s, controleert op loops, nog geen MAC-adressen leren.
- **Learning:** Begint MAC-adressen te leren, nog geen verkeer doorgestuurd.
- **Forwarding:** Stuurt verkeer door en leert MAC-adressen, normale werking.
- **Disabled:** Geen deelname aan STP, geen verkeer.

**Portfast:**  
Met `spanning-tree portfast` gaat een poort direct naar forwarding state (vooral voor eindapparaten, niet voor uplinks).

Portfast kan in 2 modi worden geconfigureerd:
1. **Access mode:** Voor eindapparaten zoals computers en printers.
2. **Trunk mode:** Voor trunkpoorten die meerdere VLAN's vervoeren.

**Let op:**  
- Portfast niet gebruiken op ports verbonden met andere switches omdat dit kan leiden tot loops.

#### Voorbeeld: STP portrollen in een netwerk

Onderstaande afbeelding toont een STP-topologie met 4 switches: SW1, SW2, SW3 en SW4.  
Voor elke interface is aangegeven of deze een **root port (R)**, **designated port (D)** of **non-designated port (N)** is.

<img src="/assets/STP-example.png" alt="STP Port Roles" width="600">


- **Root bridge:**  
  SW4 heeft het laagste bridge ID (prioriteit 20481), dus wordt root bridge.  
  Alle poorten op SW4 zijn designated ports (D).

- **Root port:**  
  Op alle andere switches (SW1, SW2, SW3) is per switch de root port (R) de poort met de laagste cost naar de root bridge (SW4).

- **Designated port:**  
  Op elk segment (collision domain) bepaalt STP wie de designated port (D) is. De poort met de snelste weg naar de root bridge (laagste cost) wordt designated port voor dat segment.

- **Non-designated port:**  
  De andere poort(en) op het segment (indien aanwezig) worden non-designated ports (N) en gaan in blocking state.




- **Voorbeeld in de afbeelding**:

- Tussen SW1 en SW2 (Fa1/0 en Fa1/0):  
  SW2 Fa1/0 = Designated port (D)  
  SW1 Fa1/0 = Non-designated port (N)

- Tussen SW2 en SW4 (G0/0 en G0/0):  
  SW2 G0/0 = Root port (R)  
  SW4 G0/0 = Designated port (D)

- Op elke switch:  
  SW4: Alle poorten zijn Designated (D)  
  SW1, SW2, SW3: Elk heeft precies één root port (R) richting de root bridge (SW4).  
  Andere poorten zijn Designated (D) of Non-designated (N) afhankelijk van hun positie op het segment.

**Samenvatting:**  
- Eén root bridge per netwerk (hier SW4, geel omlijnd)  
- Elke andere switch heeft één root port richting de root bridge  
- Per segment bepaalt STP de designated port  
- Overige poorten op een segment gaan in blocking state als non-designated port

**STP Convergentie**:

Bij default, wanneer een switch opstart, gaat hij ervan uit dat hij zelf de root bridge is. Hij stuurt BPDUs met zijn eigen Bridge ID.  
Wanneer de switch een BPDU ontvangt met een lagere Bridge ID (“superior BPDU”), zal hij zijn root bridge claim opgeven en deze nieuwe root bridge accepteren.

Na convergentie, wanneer alle switches het eens zijn over wie de root bridge is, blijft de root bridge BPDUs versturen op al zijn interfaces. Niet-root switches sturen BPDUs alleen door op hun designated ports. Zo blijft de netwerktopologie up-to-date en kunnen switches snel reageren op veranderingen in het netwerk.



  

**PVST (Per VLAN Spanning Tree)**:

Cisco switches gebruiken een versie van STP genaamd PVST (Per VLAN Spanning Tree), waarbij elke VLAN zijn eigen STP-instantie heeft. Dus in elk VLAN kunnen verschillende interfaces in forwarding of blocking state staan, afhankelijk van de topologie van dat specifieke VLAN.

<img src="/assets/SPT-cisco.png" alt="PVST" width="600"> 

De STP bridge priority kan enkel in units van 4096 worden aangepast.

<img src="/assets/STP-priority.png" alt="STP Priority" width="600">

Port-fast STP is een Cisco-optie die de convergentietijd van STP versnelt door direct naar forwarding state te gaan zonder de standaard 30 seconden wachttijd.

PVST+ ondersteund 802.1Q trunking en is de standaard op Cisco switches. 


### Rapid Spanning Tree Protocol (RSTP)

802.1w, ook bekend als Rapid Spanning Tree Protocol (RSTP), is een verbeterde versie van STP die snellere convergentie en betere prestaties biedt. Het is ontworpen om de beperkingen van STP te overwinnen, zoals de lange convergentietijd en inefficiënte poortstatussen. Het is compatibel met STP in hetzelfde netwerk.





RSTP:

- Kiest een root bridge op basis van Bridge ID, net als STP.
- Kiest root ports en designated ports op basis van de laagste kosten naar de root bridge zoals STP.
- Kiest designated ports met de laagste kosten naar de root bridge, net als STP.

De RSTP port cost zijn anders dan bij STP maar wel nog altijd hetzelfde principe. De kosten worden berekend op basis van de snelheid van de link, maar RSTP gebruikt een andere schaal dan STP.


<img src="/assets/RSTP+.png" alt="RSTP cost" width="600">

RSTP introduceert nieuwe poortstatussen en -rollen om de convergentietijd te verkorten:
- **Discarding:** Poort staat in blocking state, maar kan snel overschakelen naar forwarding.
- **Learning:** Poort leert MAC-adressen, maar stuurt geen verkeer door.
- **Forwarding:** Poort staat in forwarding state en stuurt verkeer door.
-

<img src="/assets/RSTP-portstate.png" alt="RSTP Port State" width="600">


- Als een port administratief (manueel) is uitgeschakeld, dan is de port in discarding state.
- Als een port is enabled maar blocking state staat om Layer 2 loops te voorkomen, dan is de port in discarding state.

Port roles in RSTP:
- **Root Port:**  
  De poort met de laagste kosten naar de root bridge op een switch (altijd maar één per switch).

- **Designated Port:**  
  De poort op elk segment met de laagste kosten naar de root bridge; stuurt verkeer het segment in richting root.

- **Alternate Port:**  
  Een discarding port die een superior BPDU ontvangt via een ander pad dan de root port.  
  Dient als back-up pad naar de root bridge en wordt actief als de root port uitvalt.

- **Backup Port:**  
  Een discarding port die een inferior BPDU ontvangt van een andere poort op dezelfde switch (typisch als twee poorten via een hub in hetzelfde segment zitten).  
  Is een back-up voor de designated port op dat segment en wordt actief als die uitvalt.


**UplinkFast**: 
is een optionele feature van STP (802.1D) die zorgt voor snellere failover bij het uitvallen van een uplink op access switches.  
Deze functionaliteit is **standaard geïntegreerd in RSTP (802.1w)** en hoeft daar niet meer apart geconfigureerd te worden.

**BackboneFast**:

BackboneFast is een optionele feature van STP (IEEE 802.1D) die ontworpen is om de convergentietijd te verkorten bij **indirect link failures** in het netwerk.  
Normaal wacht STP op het verlopen van de **max age timer** voordat een poort opnieuw wordt berekend, wat de failover vertraagt.  
Met BackboneFast kan een switch deze timer versneld laten verlopen wanneer een indirecte fout wordt gedetecteerd, bijvoorbeeld als er geen BPDUs meer worden ontvangen maar de link fysiek nog actief is.  
De switch mag dan sneller **superior BPDUs** accepteren van een andere switch, waardoor het netwerk veel sneller convergent is bij indirecte netwerkproblemen.

Deze functionaliteit is standaard opgenomen in RSTP (802.1w) en hoeft daar niet apart ingeschakeld te worden.


**BPDU Types en Flags in STP**

Ethernet frames bevatten een header met een EtherType-veld dat aangeeft welk protocol wordt gebruikt.  
Voor STP/RSTP BPDU’s wordt Protocol Identifier `0x0000` gebruikt in het BPDU-pakket.

**BPDU Type:**
- `0x02`: Rapid Spanning Tree Protocol (RSTP)

**BPDU Flags:**
- `0x01`: Topology Change (TC) flag — geeft aan dat er een topologieverandering is
- `0x02`: Topology Change Acknowledgment (TCA) flag — bevestigt ontvangst van een TC BPDU
- `0x04`: Proposal flag — geeft aan dat de poort een voorstel doet voor een nieuwe rol
- `0x08`: Agreement flag — bevestigt akkoord gaan met een voorstel van een andere poort
- `0x10`: Synchronization flag — geeft aan dat de poort gesynchroniseerd is met de root bridge
- `0x20`: Extended flag — gebruikt voor extra informatie in RSTP BPDUs
- `0x40`: Reserved flag — gereserveerd voor toekomstig gebruik
- `0x80`: Reserved — niet in gebruik (voor toekomstig gebruik)


**Let op**: RSTP heeft een groot verschil met STP en dit is dat elke switch BPDUS stuurt, ook als deze geen root bridge is. Dit maakt het mogelijk om sneller te convergeren en veranderingen in de topologie sneller te detecteren.


#### RSTP link types

RSTP kent drie verschillende link types:

- **Edge:**  
 Een port die direct is verbonden met een eindapparaat (zoals een pc of printer) en geen andere switches. Deze poorten gaan direct naar forwarding zonder negotiatie.

Er is geen risico op een loop dus daarom kunnen deze poorten direct naar forwarding gaan zonder STP. Dit wordt ook wel PortFast genoemd.

- **Point-to-Point:**  
 Een port die direct is verbonden met een andere switch.

Ze functioneren in full-duplex modus. 
Hier is RSTP van toepassing en worden de poorten geclassificeerd als root, designated, alternate of backup.


- **Shared:**  
 Een port die verbonden is met een hub. deze moeten in half-duplex staan.

Praktisch gezien wordt dit nooit meer gebruikt.






#### Voorbeeld Port Roles in RSTP

<img src="/assets/RTSTP-voorbeeld.png" alt="RSTP BackboneFast" width="600">

In onderstaand netwerk zijn vier switches (SW1, SW2, SW3, SW4) verbonden. Elke switch heeft een unieke MAC-adres en dezelfde bridge priority.

**Root Bridge**
- SW1 is de Root Bridge (gele omlijning), omdat deze het laagste MAC-adres heeft.

**Port Roles per Switch**
- **Root Port (R):**  
  - Op elke switch behalve de root, is de poort met de kortste (laagste) kosten naar de root bridge gemarkeerd als root port (groene label ‘R’).  
  - SW2: G0/0  
  - SW3: G0/2  
  - SW4: G0/1

- **Designated Port (D):**  
  - Op elk segment is de poort die het dichtst (qua kosten) bij de root bridge staat de designated port (groen label ‘D’).  
  - SW1: G0/0 en G0/1  
  - SW2: G0/1  
  - SW3: G0/0

- **Alternate Port (A):**  
  - Op SW4 is G0/0 de alternate port (oranje label ‘A’).  
  - Dit is een discarding port; deze poort ontvangt superieure BPDUs van een ander pad richting de root bridge en fungeert als back-up voor de root port.

- **Backup Port (B):**  
  - Op SW3 is G0/1 de backup port (oranje label ‘B’).  
  - Deze is ook discarding en wordt alleen actief als de designated port op datzelfde segment uitvalt. Backup ports ontstaan alleen als meerdere poorten van dezelfde switch op hetzelfde segment zijn aangesloten (hier zie je dat niet via een hub maar de logica is gelijk).


**Belangrijk:**

Door PVST+ te gebruiken als je dan 2 switches hebt die met elkaar verbonden zijn met meerder trunks, dan kan je per trunk een ander vlan instellen en PVST+ zorgt ervoor dat de juiste trunk wordt gebruikt voor het juiste VLAN. Dit zorgt ervoor dat je geen Loops krijgt als je meerdere trunks hebt tussen 2 switches.


### EtherChannel


**Wat is EtherChannel?**

EtherChannel is een technologie die meerdere fysieke netwerkverbindingen tussen switches of tussen een switch en een router bundelt tot één logische verbinding. Dit verhoogt de bandbreedte. Als er te weinig bandbreedte is heb je een oversubscription ratio. Dit betekent dat de totale bandbreedte van de individuele links groter is dan de bandbreedte die nodig is voor het verkeer dat over de EtherChannel wordt verzonden en hierdoor kan er congestie optreden.


Alternatieve namen voor een EtherChannel zijn:
- Port Channel
- Link Aggregation Group (LAG)
- 
**Etherchannel & STP**

Als je 2 switches met elkaar verbindt met meerdere kabels, dan gaat er maar 1 link werken door Spanning Tree Protocol (STP).
EtherChannel lost dit probleem op door meerdere fysieke links te combineren tot één logische link. Hierdoor wordt de bandbreedte vergroot en vormt de EtherChannel één enkele logische verbinding en hierdoor zal STP deze link als een enkele interface beschouwen.

Let op:

>Er is nog steeds STP nodig om Loops te voorkomen. Als er meerdere switches zijn die met elkaar verbonden zijn via EtherChannel, dan moet STP nog steeds worden gebruikt om te voorkomen dat er loops ontstaan in het netwerk.

EtherChannel verkeer zal geloadbalancend worden over de verschillende links in de EtherChannel. Dit betekent dat het verkeer gelijkmatig wordt verdeeld over de beschikbare links, afhankelijk van de configuratie en het gebruikte load balancing-algoritme.

**EtherChannel Load Balancing**

EtherChannel load balance op basis van flows.
Een flow is communicatie tussen 2 nodes in het netwerk.
Frames in dezelfde flow worden over dezelfde link gestuurd, frames in verschillende flows kunnen over verschillende links worden gestuurd.

#### EtherChannel Protocols

Er zijn drie methodes om EtherChannel te configureren:

**PAgP (Port Aggregation Protocol)** is een Cisco proprietaire protocol.
- Dynamisch negotieren over het maken / onderhouden van een EtherChannel.
(Zoals DTP voor trunking, maar dan voor EtherChannel)
- Ondersteunt twee modi: 
  - **Auto:** Poort zal proberen een EtherChannel te vormen als de andere kant ook in auto of desirable mode staat.
  - **Desirable:** Poort zal actief proberen een EtherChannel te vormen met de andere kant.
  
>auto + auto = geen EtherChannel
>auto + desirable = EtherChannel
>desirable + desirable = EtherChannel
>on/on = static EtherChannel

**LACP (Link Aggregation Control Protocol)**
- Een open standaard (IEEE 802.3ad) industrieprotocol voor EtherChannel.
- Ondersteund door meerdere fabrikanten, niet alleen Cisco.
- Switches van verschillende fabrikanten kunnen LACP gebruiken om EtherChannel te vormen.
- Ondersteunt twee modi:
  - **Active:** Poort zal actief proberen een EtherChannel te vormen met de andere kant.
  - **Passive:** Poort zal alleen een EtherChannel vormen als de andere kant in active mode staat.

>active + active = EtherChannel
>active + passive = EtherChannel
>passive + passive = geen EtherChannel
>on/on = static EtherChannel

**Static (Manual) EtherChannel**
- Handmatige configuratie van EtherChannel zonder gebruik te maken van PAgP of LACP.
- Vereist dat beide zijden handmatig worden geconfigureerd met dezelfde instellingen.
- Geen automatische detectie of onderhoud van de EtherChannel.


**Belangrijk:**

- Er kunnen maximum 8 fysieke interfaces in een EtherChannel worden opgenomen, maar LACP ondersteunt maximaal 16 interfaces in totaal, waarvan 8 actief kunnen zijn in de EtherChannel en de andere 8 in standby staan.


#### Layer 3 EtherChannel

Een Layer 3 EtherChannel wordt gebruikt om meerdere fysieke interfaces te combineren tot één logische interface op Layer 3 (netwerklaag). Als je dit gebruikt i.p.v Layer 2 EtherChannel dan kan je geen loops krijgen omdat er geen layer 2 verkeer overheen gaat.

