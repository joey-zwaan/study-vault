## Lan Switching

Lan switching verwijst naar het gebruik van netwerk switches om apparaten binnen een lokaal netwerk (LAN) met elkaar te verbinden en communicatie tussen hen mogelijk te maken. Switches werken op de data-link laag (Layer 2) van het OSI-model en gebruiken MAC-adressen om frames naar de juiste bestemming te sturen.

### Lan Switching Logic

De role van een **LAN switch** is om Ethernet frames te forwarden. Een Lan bestaat uit een reeks van user devices, servers, en andere devices die connecteren met een switch, en de switches met elkaar. De LAN heeft 1 hoofdtaak en dat is om frames te forwarden naar de juiste bestemming(MAC-adres). Om dit doel te bereiken, maakt de switch gebruik van logic based op de source en destination MAC-adressen in elke Ethernet header.

Wanneer een LAN switch een **Ethernet frame** ontvangt maakt het een beslissing.
Hij forward de frame of hij dropt de frame. Om dit te bereiken doet de switch de volgende 3 stappen:

1. Beslissen wanneer een **frame** te forwarden of te droppen gebaseerd op de destination MAC-adres.
2. Voorbereiden om toekomstige frames te forwarden door het leren van de source MAC address van elke frame die hij ontvangt.
3. Samenwerken met andere switches om het eindeloos looping van frames te voorkomen door gebruik te maken van het **Spanning Tree Protocol (STP)**.

> De eerste actie is de hoofdtaak van een switch, de andere zijn ondersteunend voor de eerste actie. 

#### Forwarding unicast frames

Om te beslissen of een frame geforward of gedropt moet worden, gebruikt de switch zijn **MAC address table**. Deze tabel bevat een lijst van bekende MAC-adressen en de poorten waar ze aan verbonden zijn. Deze tabel bepaald of de switch een frame moet forwarden of droppen.

Een **MAC address table** lijst de locatie van elk Mac-adres relatief aan de switch op. In een netwerk met meerdere verbonden switches maakt elke switch individueel beslissingen over het forwarden of droppen van frames. Elke switch heeft zijn eigen MAC address table en gebruikt deze om te bepalen waar een frame naartoe moet worden gestuurd.

> Een switch **MAC address table** wordt ook wel eens een CAM table, content addressable memory of bridging table genoemd.

Een andere term voor frames waarvan het destination MAC-adres bekend is in de MAC address table is een **known unicast frame**. Switches forwarden deze unicast frames enkel naar de poort die overeenkomt met de MAC-tabel entry.


#### Flooding Unknown Unicast and Broadcast Frames

Wanneer een switch een frame ontvangt met een destination MAC-adres dat niet in zijn MAC address table staat, wordt dit een **unknown unicast frame** genoemd. In dit geval weet de switch niet naar welke poort hij het frame moet sturen. Om ervoor te zorgen dat het frame de juiste bestemming bereikt, zal de switch het frame naar alle poorten sturen, behalve de poort waar het frame vandaan kwam. Dit proces wordt **flooding** genoemd. Elke apparaat in hetzelfde VLAN zal het frame ontvangen maar enkel het apparaat met het overeenkomende MAC-adres zal erop antwoorden.

Switches flooden ook **broadcast frames**. Broadcast frames hebben een speciaal destination MAC-adres van `FF:FF:FF:FF:FF:FF`, wat betekent dat ze naar alle apparaten in het lokale netwerk moeten worden gestuurd. Net als bij unknown unicast frames, zal de switch broadcast frames naar alle poorten sturen, behalve de poort waar het frame vandaan kwam. Dit wordt gebruikt voor netwerkprotocollen zoals **ARP** (Address Resolution Protocol) en **DHCP** (Dynamic Host Configuration Protocol).



<img src="/assets/switch-forwarding.png" alt="Switch Forwarding Behavior" width="600">


> BELANGRIJK! Switches passen niet het source-MAC-adres aan van een frame aan wanneer ze het forwarden. Het source-MAC-adres blijft altijd hetzelfde van de originele zender. Hierdoor kan een andere switch MAC-adressen leren van hosts die niet direct verbonden zijn met de switch.
> 
> BELANGRIJK! Switches forwarden geen frames tussen verschillende VLANs. Dit vereist een router of een Layer 3 switch. Het is enkel mogelijk om te switchen binnen hetzelfde VLAN of over een **trunk link** tussen switches.

### Autonegotiation & Duplex

IEE 802.3u definieert **autonegotiation** als een manier voor twee verbonden apparaten om automatisch de beste snelheid en duplex-modus te bepalen die ze beide ondersteunen. 

`10/100 = een port dat 10 en 100 Mbps ondersteund.`
`10/100/1000 = een port dat 10, 100 en 1000 Mbps ondersteund.`

Deze standaard verkiest **full-duplex** boven **half-duplex** wanneer beide apparaten full-duplex ondersteunen.
Een apparaat verklaart zijn mogelijkheden door middel van **Fast Link Pulses (FLPs)**. Deze FLPs worden verzonden zodra een apparaat verbinding maakt met een ander apparaat. Elk apparaat dat autonegotiation ondersteunt, zal zijn mogelijkheden communiceren via FLPs. Dit lost het probleem op voor hoe apparaten elkaar informatie kunnen sturen voordat er een link is gevormd.


Als beide apparaten autonegotiation ondersteunen is het resultaat logisch.
Het is aanbevolen om altijd autonegotiation te gebruiken op elk apparaat dat het ondersteunt. Maar als je het echt moet uitschakelen, zorg er dan voor dat je het op beide apparaten uitschakelt en stel handmatig dezelfde snelheid en duplex-modus in `speed 100` en `duplex full` als voorbeeld.
Om terug autonegotiation in te schakelen, gebruik je het commando `no speed` en `no duplex`.

**Parallel detection** wordt gebruikt wanneer een apparaat geen autonegotiation-signalen ontvangt van de andere kant van de verbinding. In dat geval probeert het apparaat de snelheid te bepalen door te luisteren naar de inkomende signalen.

Bij 10 Mbps of 100 Mbps wordt de snelheid correct herkend, maar de duplex-modus kan niet onderhandeld worden.
De poort schakelt daarom standaard naar half-duplex.
Dit mechanisme is een fallback zodat er alsnog communicatie mogelijk blijft, zelfs als autonegotiation niet werkt.
Een belangrijk gevolg is dat, als de andere kant handmatig op full-duplex is ingesteld, er een **duplex mismatch** ontstaat. Dit leidt tot problemen zoals **collisions**, late collisions en verminderde prestaties.

> Bij ethernet interfaces met snelheden meer of gelijk aan 1 Gbps is het altijd full-duplex.

#### Duplex Mismatch

Een duplex mismatch ontstaat wanneer twee apparaten op een verbinding verschillende duplex-modi gebruiken. Een typisch scenario is dat de ene kant op **full-duplex** staat ingesteld en de andere kant op **half-duplex**.

In **full-duplex** wordt er tegelijkertijd gezonden en ontvangen, zonder gebruik van **CSMA/CD (Carrier Sense Multiple Access with Collision Detection)**. Het apparaat gaat er dus vanuit dat de lijn altijd vrij is.

In **half-duplex** wordt wél **CSMA/CD** gebruikt: het apparaat luistert eerst of de lijn vrij is en detecteert collisions tijdens het verzenden.

Wanneer een apparaat in **full-duplex** aan het zenden is, kan dit door het **half-duplex** apparaat worden geïnterpreteerd als een collision. Het **half-duplex** apparaat zal daardoor het verzenden onderbreken, wachten, en het frame opnieuw proberen te versturen. Ondertussen blijft het **full-duplex** apparaat gewoon doorsturen, omdat het geen collisions kan waarnemen.

Het gevolg is dat de link  wel actief (up) is, maar er ontstaat een groot aantal collisions, late collisions en retransmissions (trage verbinding).


#### Auto-mdix

**Auto-MDIX (Automatic Medium-Dependent Interface Crossover)** is een functie die automatisch het type kabel (straight-through of crossover) detecteert en aanpast op een netwerkpoort. Dit betekent dat je je geen zorgen hoeft te maken over het gebruik van de juiste kabel voor verschillende verbindingen, omdat de apparaten zelf bepalen hoe ze met elkaar communiceren.


> De show-running config & show-startup config tonen geen default instellingen. Als autonegotiation en auto-mdix niet zijn uitgeschakeld, worden ze niet weergegeven in de configuratie.


#### Cisco Interface Counters

**Runts:** Ethernet-frames die kleiner zijn dan de minimale grootte (64 bytes) en worden weggegooid door switches.
**Giants:** Ethernet-frames die groter zijn dan de maximale grootte (1518 bytes) en worden weggegooid door switches.
**Collisions:** Teller van het aantal keren dat er een collision is tijdens het verzenden van een frame.
**CRC Errors:** Teller van het aantal frames dat is ontvangen met een fout in de CRC-check (Cyclic Redundancy Check), wat wijst op beschadigde frames.
**Late Collisions:** Collisions die optreden na de eerste 64 bytes van een frame zijn verzonden, wat wijst meestal op een duplex mismatch.
**Retransmissions:** Het opnieuw verzenden van frames die verloren zijn gegaan of beschadigd tijdens de overdracht.
**Input Errors:** Algemene teller voor fouten die optreden bij het ontvangen van frames, zoals CRC-fouten of framing-fouten.
**Packet outputs:** Teller van het aantal frames dat succesvol is verzonden vanaf de interface.
**Output Errors:** Algemene teller voor fouten die optreden bij het verzenden van frames, zoals collisions of buffer-overflows.