## STP & RSTP Basics

Zonder mechanismes zoals Spanning Tree Protocol (STP) of Rapid Spanning Tree Protocol (RSTP) zouden redundante paden in een netwerk leiden tot **broadcast storms**, waarbij frames eindeloos blijven circuleren. 

STP & RSTP worden sommige ports geblokkeerd op een switch. Er wordt intelligent gekozen welke poorten geblokkeerd worden met 2 doelen:

- 1. Alle switches moeten met elkaar verbonden blijven (geen netwerk segmenten mogen afgesneden worden).
- 2. Frames hebben een kort leven en mogen niet eindeloos blijven circuleren.

STP & RSTP voorkomen loops door een extra check toe te voegen aan elke interface voordat deze een frame doorstuurt of ontvangt. Als de port in forwarding mode staat in dat VLAN mag het frames doorsturen en ontvangen. Als de port in blocking mode staat, mag het geen frames doorsturen of ontvangen op dat VLAN.

De interface status van connect/notconnected veranderd niet. De operational mode van de interface als access of trunk port veranderd ook niet. Zelfs als STP/RSTP een port blokkeert, blijft het een access of trunk port & blijft hij connect/notconnected.


### Waarom STP/RSTP?

Het voorkomt veelvoorkomende problemen in Ethernet Lans. Alle problemen gebeuren van een side effect van loops in een netwerk. Zonder STP/RSTP blijven frames eindeloos circuleren in een netwerk met loops. Dit veroorzaakt 3 grote problemen:

1. **Broadcast Storms:** Frames worden eindeloos gerepliceerd en circuleren door het netwerk, hierdoor kan het netwerk volledig onbruikbaar worden.
2. **MAC Address Table Instability:** Het continue updaten van de MAC-adres tabel door de switch met onjuiste entries in reactie op de circulerende frames. Hierdoor weet de switch niet meer waar apparaten zich bevinden. Hierdoor worden frames naar de verkeerde locaties gestuurd.
3. **Multiple Frame Copies:** Door de circulatie van frames kunnen apparaten meerdere kopieën van hetzelfde frame ontvangen, wat leidt tot verwarring en fouten bij de host.


#### Wat doet STP/RSTP?


STP/RSTP zorgt ervoor dat er geen loops ontstaan in een netwerk door sommige poorten te blokkeren. Het kiest intelligent welke poorten geblokkeerd worden zodat er altijd een pad beschikbaar is voor verkeer.

In de foto hieronder zie je dat hij een port geblokkeerd heeft en dat er hierdoor geen loop kan vormen.
Het nadeel van STP is dat er dat deze link niet gebruikt kan worden voor verkeer. Als er een link failure is zal STP een blocking port omzetten naar een forwarding port. Dit proces heet **STP convergence**.

> STP convergence is het process waarbij STP de netwerk topologie herberekent en poorten opnieuw activeert of blokkeert na een verandering in het netwerk, zoals een link failure. Dit proces kan enkele seconden duren, wat kan leiden tot tijdelijke netwerkonderbrekingen.

<img src="/assets/STP_blocking.png" alt="STP Blocking" width="600">

#### Werking van Spanning Tree Protocol (STP)

Het algoritme van STP/RSTP creert een boomstructuur (spanning tree) binnen een netwerk met redundante paden. Het begint met het kiezen van een **root bridge** (de centrale switch in de boom). Het creert een enkele pad van elke switch naar de root bridge. 

STP gebruikt 3 criteria om te bepalen of een interface in een forwarding state komt.

- **Root Bridge**  

  De switch met de laagste Bridge ID wordt de root bridge.  
  Alle poorten van de root bridge worden **Designated Ports** en gaan in forwarding state.

    > De Root switch plaatst elke poort in de forwarding state, omdat elke port op de root switch altijd de DP verkiezing wint. Het is makkelijker om te herrineren dat alle poorten van de root switch in forwarding state staan.


- **Root Port**  

  Elke non-root switch berekent de **path cost** naar de root bridge.  
  De poort met de laagste totale cost wordt de root port en gaat in forwarding state.  
  Deze totale waarde heet de **root path cost**.

- **Designated Port**  

Op elke link tussen 2 switches wordt bepaald welke de **designated switch** is. Dit is de switch met de laagste root path cost (en bij gelijke cost, de laagste Bridge ID).  
  De poort van de designated switch op die link wordt de **designated port**.

- **Disabled Port**  
  Om alle niet-werkende interfaces uit de topologie te houden, krijgen interfaces die niet in een connected up/up staat zijn de rol **disabled port**.  
  Deze poorten worden niet meegenomen in de STP/RSTP-berekeningen.


<img src="/assets/STP_reasons_forwarding.png" alt="STP Criteria" width="600">


#### STP Bridge ID & Hello BPDU

De STA (Spanning Tree Algorithm) begint een verkiezing om de root switch te kiezen. Om de verkiezing beter te begrijpen moeten we de berichten tussen de switches begrijpen.

De STP/RSTP **bridge id** (BID) is een 8-byte unieke identifier voor elke switch. Het veld bestaat uit een 2 byte **bridge priority** en een 6 byte **MAC-adres**. De system ID is gebaseerd op het MAC-adres van de switch. Door deze MAC-adres te gebruiken is de bridge ID altijd uniek.

STP/RSTP definieert berichten genaamd bridge protocol data units (BPDUs) ook genoemd configuratie BPDUs. De meest voorkomende is een **Hello BPDU** die veel informatie bevat, waaronder de bridge ID van de switch die het bericht verzendt. De Hello BPDU bevat ook de volgende informatie:

<img src="/assets/stp_hello.png" alt="STP Hello BPDU" width="600">


**Root bridge ID**: De bridge ID van wie de switch gelooft dat de root bridge is.
**Senders bridge ID**: De bridge ID van de switch die de BPDU verzendt.
**Senders root cost**: De STP/RSTP cost tussen deze switch en de huidige root switch.
**Timer values**: De waarden voor de hello time, max age en forward delay timers van de root switch.

De verkiezing van een root switch gebeurd op basis van de BID's. De root switch is de switch met de laagste numerieke waarde van de BID. Omdat de priority value het eerste deel van de BID is, wint de switch met de laagste priority waarde. Als er een gelijke priority waarde is, wint de switch met het laagste MAC-adres.

De verkiezing begint met alle switches die zichzelf als root switch beschouwen. Elke switch stuurt Hello BPDUs uit waar ze beweren de root te zijn op alle poorten. Als een switch een HELLO BPDU ontvangt van een andere switch met een lagere BID, accepteert het die switch als de root en stopt het met het verzenden van HELLO BPDUs die beweren de root te zijn. In plaats daarvan stuurt het nu HELLO BPDUs uit die de nieuwe root switch erkennen.

> Een betere Hello, betekende dat de root ID lager is, noemen we een superieure Hello, een slechtere Hello noemen we een inferieure Hello.


Het tweede deel van de verkiezing is het kiezen van de root port op elke non-root switch. De switch berekent de totale cost naar de root switch voor elke poort. De poort met de laagste totale cost wordt de root port en gaat in forwarding state. 

<img src="/assets/STP_cost1.png" alt="STP Cost" width="600">

In het voorbeeld hierboven heeft SW3 2 mogelijke fysieke paden naar de root switch (SW1). Het directe pad naar de root switch & het indirecte pad.
De cost uit Gi0/1 is de laagste cost en wordt de root poort. Switch 2(SW2) kiest Gi0/2 als root poort omdat dat de laagste cost is. **De poort Gi0/1 op SW2 gaat in Blocking State omdat SW3 designated poort is op die link na de root poort verkiezing.**

Switches hebben wel een tie-breaker nodig als er meerdere poorten met dezelfde cost zijn. Er zijn 3 tie-breakers:

1. De lowest neighbor BID (de switch met de laagste BID wint).
2. De lowest neighbor port ID (de poort met de laagste poortnummer wint).
3. De lowest local port ID (de poort met de laagste poortnummer wint).

#### Designated port kiezen

De finale stap van STP/RSTP is het bepalen van de designated port op elk lan segment. De switch met de laagste root cost wordt de designated switch en zijn poort wordt de designated port. **Op een link met een end-device of een ander apparaat dat geen STP/RSTP ondersteunt, wordt de poort van de switch automatisch de designated port.**


STP/RSTP werkt default op alle Cisco switches. Alle settings hadden dus een logisch default hebben. Switches hebben een default BID gebaseerd op een priority van 32768 en het MAC-adres van de switch. Switches interfaces hebben een default STP/RSTP cost gebaseerd op de snelheid van de interface. 

<img src="/assets/Port_Cost.png" alt="STP Port Cost" width="600">


### Specifieke details voor STP

Deze sectie bevat specifieke details over STP die niet van toepassing zijn op RSTP. Bijna alle verschillen tussen STP & RSTP zijn gerelateerd aan de snelheid van convergentie. RSTP is ontworpen om veel sneller te convergeren dan STP.

Wanneer een netwerk convergentie heeft bereikt, betekent dit dat alle switches het eens zijn over de netwerktopologie en welke poorten zich in **forwarding** of **blocking/discarding** state bevinden. In een stabiel netwerk genereert de **Root Bridge** periodiek Hello BPDUs en de non-root switches verspreiden deze informatie verder. Dit continue proces zorgt ervoor dat alle switches up-to-date blijven over de topologie.

De **Root Bridge** genereert Hello BPDUs (standaard elke 2 seconden) met de volgende informatie:
- Root Bridge ID
- Sender's Bridge ID
- Sender's Root Cost --> **0**
- Timer Values (Hello Time, Max Age, Forward Delay)

Deze BPDUs worden verzonden uit alle **Designated Ports** van de root.

**Non-root switches** ontvangen de BPDU op hun **Root Port**, verhogen de **Root Path Cost** met de waarde van de inkomende poort (afhankelijk van bandbreedte) en genereren vervolgens een **nieuwe BPDU**. Deze wordt verzonden uit alle **Designated Ports** van de switch.

Dit proces herhaalt zich bij elke **Hello Time** (default 2 seconden). Alleen de **Designated Port** op een segment verzendt BPDUs; blocking-poorten verzenden geen BPDUs maar kunnen ze wel ontvangen.
Wanneer een switch faalt om een Hello BPDU te ontvangen op zijn root port weet het dat er een probleem in het netwerk is. Er gebeuren dan verschillende stappen. **STP gebruikt timers die bepaald worden door de root switch.**

<img src="/assets/STP-timers.png" alt="STP Cost" width="600">

1. **Hello Time**: De interval waarin de root switch Hello BPDUs verzendt (default 2 seconden).
2. **Max Age**: De tijd die een switch wacht zonder een BPDU te ontvangen voordat het de root switch als onbereikbaar beschouwt (default 20 seconden).
3. **Forward Delay**: De tijd die een poort in de listening en learning state blijft tijdens de overgang naar forwarding state (default 15 seconden).

Als een switch niet een HELLO BPDU krijgt binnen de Hello Time gaat de switch door alsof er niks gebeurd is. Maar de Max Age timer begint te lopen en als er binnen die tijd geen Hello BPDU ontvangen wordt gaat de switch alle stappen opnieuw doorlopen van het STP proces. 

States van een STP poort:

- **Blocking:** De poort ontvangt BPDUs maar verzendt geen frames. Het is in deze state om loops te voorkomen. **Stable state.**
- **Listening:** De poort luistert naar BPDUs om de netwerk topologie te begrijpen. Het leert geen MAC-adressen in deze state. **Transitory state.**
- **Learning:** De poort leert MAC-adressen maar verzendt nog geen frames. Het bereidt zich voor om in forwarding state te gaan. **Transitory state.**
- **Forwarding:** De poort verzendt en ontvangt frames. Het is volledig operationeel in deze state. **Stable state.**
- **Disabled:** De poort is uitgeschakeld en doet niet mee aan STP. **Stable state.**

STP beweegt een interface van blocking naar listening, dan naar learning en uiteindelijk naar forwarding. Bij elke transitory state wacht de poort een periode die wordt bepaald door de **Forward Delay** timer (default 15 seconden). Dit betekent dat het minimaal 30 seconden duurt om van blocking naar forwarding te gaan (15 seconden in listening en 15 seconden in learning). Uiteindelijk is er een totale convergentietijd van 50 seconden (20 seconden max age + 30 seconden forward delay) als een switch zijn root port verliest.


### Rapid Spanning Tree Protocol (RSTP)

De orginele Spanning Tree Protocol (STP) is ontworpen in de jaren 80 en heeft enkele beperkingen, vooral op het gebied van convergentiesnelheid. Rapid Spanning Tree Protocol (RSTP), gedefinieerd oorspronkelijk in **IEEE 802.1w** maar eigenlijk vandaag de dag is het ondergebracht in **802.1W**. Het is een verbeterde versie van STP **802.1D** die snellere convergentie biedt en enkele extra functies introduceert.

#### Vergelijking tussen STP & RSTP


**Belangrijkste gelijkenissen**

RSTP & STP verkiezen een root switch op dezelfde manier en met dezelfde regels.
RSTP & STP kiezen hun root port op dezelfde manier en met dezelfde regels.
RSTP & STP kiezen hun designated port op dezelfde manier en met dezelfde regels.
RSTP & STP plaatsen elke port in forward of blocking state, alhoewel noemt RSTP dit discarding state.

**Belangrijkste verschillen**

RSTP voegt een mechanisme toe waarbij een switch een root port kan vervangen zonder te wachten op forwarding state.(sommige gevallen)
RSTP voegt een mechanisme toe om een designated port te vervangen zonder te wachten op forwarding state. (sommige gevallen)
RSTP verlaagt de wachttijden in gevallen waar RSTP op een timer moet wachten.

De beste manier om te zien hoe de mechanismen werken is om te kijken hoe de alternate & backup port roles werken. Alternate wordt gebruikt om een alternatieve root port te hebben. Backup wordt gebruikt om een alternatieve designated port te hebben. De backup port is alleen van toepassing op een hub.

<img src="/assets/RSTP-roles.png" alt="RSTP Port Roles" width="600">


In RSTP sturen alle switches een Hello BPDU uit elke port, ongeacht of het een designated port, root port, alternate port of backup port is. Dit is een belangrijk verschil met STP, waar alleen de **Root Switch** Hello BPDUs verzendt. In RSTP kunnen switches queries sturen om de status van een port te controleren. Dit helpt bij het sneller detecteren van veranderingen in de netwerk topologie.

| Rol        | Wat is het?                                       | Normale toestand |
| ---------- | ------------------------------------------------- | ---------------- |
| Root Port  | Beste pad **naar** de root bridge                 | Forwarding       |
| Designated | Verantwoordelijk **voor** een LAN-segment         | Forwarding       |
| Alternate  | Alternatief pad via andere switch (stand-by)      | Discarding       |
| Backup     | Alternatief pad naar hetzelfde segment (stand-by) | Discarding       |


<img src="/assets/port_roles_rstp.png" alt="RSTP Port Roles" width="600">



#### RSTP & Alternate (Root) Port Role

Met STP plaats elke non-root switch 1 poort in de (RP role) RSTP volgt dezelfde regels om deze te kiezen maar neemt nog een stap verder. Het kiest ook een **Alternate Port**. Dit is een poort die een alternatieve verbinding naar de root switch biedt. Deze poort is in blocking state (discarding state in RSTP) maar kan snel worden geactiveerd als de huidige root port faalt. Het is de 2e beste weg naar de root switch.

Er zijn wel verschillen in port states tussen STP & RSTP. De states zijn ook iets verschillend benoemd.

<img src="/assets/port_states.png" alt="RSTP Port States" width="600">


Om sneller tot convergentie te komen communiceren met elkaar als de topologie veranderd. Deze berichten vertellen ook aan de direct neighbours om de inhoud van hun MAC-adres tabel te wissen. Dit verwijderd potentieel alle loop veroorzaakende entries en de port kan hierdoor direct in forwarding state te gaan zonder te wachten.

#### RSTP & Backup (Designated) Port Role

De RSTP backup port verbertert ook de convergentie tijd op een link met een hub. In STP is er geen backup port role. Als de designated port faalt, moet de switch wachten op de max age timer om te verlopen voordat het een nieuwe designated port kan kiezen. In RSTP kiest de switch een backup port die in discarding state staat. Als de designated port faalt, kan de backup port direct in forwarding state gaan zonder te wachten.



#### RSTP Link Types 

RSTP introduceert ook het concept van link types om de convergentie verder te verbeteren. Er zijn 3 link types:

- **Point-to-Point Link:** Een directe verbinding tussen twee switches.
- **Shared Link:** Een verbinding die aangesloten is op een hub. RSTP gebruikt een andere methode om te bepalen of een poort in forwarding of discarding state moet gaan.
- **Edge Link:** Een verbinding naar een end-device zoals een computer of printer. RSTP kan deze poorten direct in forwarding state plaatsen omdat ze geen loops kunnen veroorzaken.


### STP Optional features

**Etherchannel**

De beste manier om STP convergentie time te verbeteren is om het te vermijden. Etherchannel is een manier om meerdere fysieke links te bundelen tot één logische link.  Hierdoor als er een link uitvalt hoeft er geen STP convergentie plaats te vinden.
Zonder Etherchannel als je meerdere paralelle links hebt tussen 2 switches, zal STP 1 of meerdere van die links blokkeren om loops te voorkomen.


**PortFast**

Switchports die direct verbonden zijn met een end-device zoals een computer of printer kunnen worden geconfigureerd met **PortFast**. Dit zorgt ervoor dat de poort direct in forwarding state gaat zonder de tussenliggende listening en learning states te doorlopen. Dit is veilig omdat end-devices geen STP BPDUs verzenden en dus geen loops kunnen veroorzaken. Deze functie is *standaard inbegrepen in RSTP.* 

> Portfast mag NOOIT worden gebruikt op poorten die verbonden zijn met andere switches of hubs, omdat dit loops kan veroorzaken.

**BPDU Guard**

PortFast creert een risico omdat als een switch per ongeluk op een PortFast-poort wordt aangesloten, het een loop kan veroorzaken. Om dit risico te verminderen, kan **BPDU Guard** worden ingeschakeld op PortFast-poorten. Als een BPDU wordt ontvangen op een poort met BPDU Guard, schakelt de switch de poort uit (err-disabled state) om verdere problemen te voorkomen.

**BPDU Filter**

BPDU Filter is een andere optie die kan worden ingeschakeld op PortFast-poorten. In plaats van de poort uit te schakelen reageert de filter door PortFast uit te schakelen en de poort terug te zetten naar de normale STP regels. Hierdoor neemt de poort deel aan STP en wordt zo bepaald of het in forwarding of blocking state moet gaan.

Je kan ook een feature inschakelen met een totaal andere logica. Als deze met een interface subcommando wordt ingeschakeled zal het alle BPDU's inkomend en uitgaand op die port discarden. Effectief zorgt dit ervoor dat STP uitgeschakeld is op die poort. Dit is een riskante instelling die niet zonder kennis gebruikt moet worden.

**Scenario's voor BPDU Filter:**

Twee IT groepen bouwen een netwerk in hetzelfde gebouw. Ze willen hun LANS met elkaar verbinden maar de groep links & rechts wil niet dat de andere groep hun STP beïnvloed. Ze kunnen BPDU filter inschakelen op de trunk poorten die de 2 groepen verbinden. Hierdoor zullen geen BPDU's tussen de 2 groepen worden uitgewisseld en zal elke groep zijn eigen STP topologie behouden. --> Hier hebben we de **subcommand BPDU filter op de interface gebruikt**. Niet de verwarren met het globale commando die BPDU filter op alle PortFast poorten inschakeld en die de PortFast functie uitschakelds en terug laat deelnemen aan STP process.


**Root Guard**  

Root Guard is een feature die kan worden ingeschakeld op poorten om te voorkomen dat een switch met een lagere Bridge ID de root switch wordt. Als een poort met Root Guard een BPDU ontvangt van een switch die beweert de root te zijn (met een lagere BID dan de huidige root), schakelt Root Guard die poort in **root-inconsistent state**. In deze state wordt de poort in blocking state geplaatst totdat de inconsistente BPDU's niet meer worden ontvangen.



**Loop Guard Probleem**

<img src="/assets/Loop-guard-problem.png" alt="Loop Guard Problem" width="600">

**Loop Guard**  

Loop Guard is een feature die kan worden ingeschakeld op poorten om te voorkomen dat een poort onbedoeld in forwarding state gaat als het geen BPDUs meer ontvangt. Als een poort met Loop Guard geen BPDUs meer ontvangt schakelt Loop Guard die poort naar **broken state**. In deze state wordt de poort in blocking state geplaatst totdat het weer BPDUs begint te ontvangen.  

<img src="/assets/Loop-guard-oplossing.png" alt="Loop Guard Solution" width="600">

> Loop guard moet worden ingeschakeld op Root porten & non-designated porten. (porten die BPDU's moeten ontvangen)

> Root guard & Loop guard kunnen niet samen op dezelfde poort worden ingeschakeld. Root guard voorkomt Designated ports om root ports te worden.
> Loop guard voorkomt dat Non-designated of Root ports Designated ports worden.


#### STP vs RSTP – Poortrollen en BPDU-gedrag


**STP (802.1D)**

| Poortrol                 | Staat      | BPDU-gedrag                | Opmerking                           |
| ------------------------ | ---------- | -------------------------- | ----------------------------------- |
| **Root Port (RP)**       | Forwarding | Ontvangt, **stuurt niet**  | Kortste pad naar root bridge        |
| **Designated Port (DP)** | Forwarding | **Stuurt BPDUs**           | Eén per segment                     |
| **Non-Designated Port**  | Blocking   | Ontvangt, **stuurt niet**  | Verliest verkiezing, voorkomt loops |
| **Disabled Port**        | Disabled   | **Geen BPDU-uitwisseling** | Admin down/geen deelname            |


**RSTP (802.1w)**

| Poortrol                 | Staat      | BPDU-gedrag                | Opmerking                                   |
| ------------------------ | ---------- | -------------------------- | ------------------------------------------- |
| **Root Port (RP)**       | Forwarding | Ontvangt, **stuurt niet**  | Kortste pad naar root bridge                |
| **Designated Port (DP)** | Forwarding | **Stuurt BPDUs**           | Eén per segment                             |
| **Alternate Port**       | Discarding | Ontvangt, **stuurt niet**  | Alternatief pad naar root (andere link)     |
| **Backup Port**          | Discarding | Ontvangt, **stuurt niet**  | Back-up op **hetzelfde** segment (zeldzaam) |
| **Disabled Port**        | Disabled   | **Geen BPDU-uitwisseling** | Admin down/geen deelname                    |



**STP & RSTP states**

| State                  | Verkeer doorlaten | MAC-adressen leren | BPDU-gedrag (kort)                 |
| ---------------------- | ----------------- | ------------------ | ---------------------------------- |
| **Blocking** (STP)     | Nee               | Nee                | Ontvangt, verwerkt; geen data door |
| **Listening** (STP)    | Nee               | Nee                | Verwerkt BPDUs; wacht op timers    |
| **Learning** (beide)   | Nee               | **Ja**             | Verwerkt BPDUs                     |
| **Forwarding** (beide) | **Ja**            | **Ja**             | Verwerkt BPDUs                     |
| **Discarding** (RSTP)  | Nee               | Nee                | Verwerkt BPDUs                     |
| **Disabled** (beide)   | Nee               | Nee                | Geen deelname (admin down)         |

#### Rapid PVST+ (Rapid Per-VLAN Spanning Tree Plus)

Rapid PVST+ is Cisco's implementatie van RSTP die per VLAN werkt. Dit betekent dat elke VLAN zijn eigen spanning tree heeft, wat meer flexibiliteit en optimalisatie mogelijk maakt in netwerken met meerdere VLANs. Rapid PVST+ gebruikt dezelfde principes als RSTP, maar past ze toe op elke VLAN afzonderlijk. Als reactie hierop heeft het IEEE een standaard ontwikkeld genaamd MST (Multiple Spanning Tree) **802.1s** die vergelijkbare functionaliteit biedt.

De switches ondersteunen niet STP & RSTP single tree protocollen. Alleen de per-VLAN varianten.
De drie protocollen zijn:

- PVST+ (Per-VLAN Spanning Tree Plus) - Gebaseerd op STP (802.1D)
- Rapid PVST+ (Rapid Per-VLAN Spanning Tree Plus) - Gebaseerd op RSTP (802.1w)
- MSTP (Multiple Spanning Tree) - (802.1s)

> MSTP laat toe om verschillende instances van spanning tree te hebben die elk meerdere VLANs kunnen bevatten. Het hoeft er niet 1 per VLAN te zijn zoals bij PVST+ & Rapid PVST+.

Omdat je met multiple spanning trees werkt, 1 per vlan of meerdere per vlan, het protocol moet rekening houden met VLANS & Trunking. Dit is de reden dat RSTP & MSTP nu een deel zijn van de 802.1Q standaard. Deze standaard definieert VLANS & VLAN trunking. 

Orgineel werdt een switch BID gemaakt door de 2 byte priority & 6 byte MAC-adres. Maar in een per-VLAN spanning tree moet de switch een unieke BID hebben per VLAN. Dit wordt gedaan door de **VLAN ID** toe te voegen aan de priority waarde. Dit wordt de **System ID Extension** genoemd. Het is een 12-bit veld dat de VLAN ID bevat. Hierdoor kan elke switch een unieke BID hebben voor elk VLAN.

<img src="/assets/STP-system-ID.png" alt="STP System ID" width="600">

