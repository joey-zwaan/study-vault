# Vlans

VLANs (Virtual Local Area Networks) zijn een manier om netwerken logisch te segmenteren, ongeacht de fysieke locatie van de apparaten. Dit biedt voordelen zoals verbeterde beveiliging, betere netwerkprestaties en eenvoudiger beheer.

## Wat is een LAN?

Een LAN (Local Area Network) is een single broadcast domain, inclusief alle apparaten die direct met elkaar kunnen communiceren zonder tussenkomst van een router. In een LAN kunnen apparaten elkaar direct bereiken via hun MAC-adressen.

Een broadcastdomein is de groep apparaten die een broadcastframe (doel-MAC FFFF.FFFF.FFFF) zullen ontvangen dat door een van de leden wordt verzonden is. 

<img src="/assets/broadcastdomain.png" alt="Broadcast Domain" width="500">

## Wat is een VLAN?

Een VLAN (Virtual LAN) is een logisch netwerk op laag 2 waarmee apparaten uit verschillende fysieke netwerken in één virtueel netwerk kunnen worden geplaatst. Apparaten binnen hetzelfde VLAN kunnen met elkaar communiceren alsof ze in hetzelfde fysieke netwerk zitten, zelfs als ze fysiek gescheiden zijn. Broadcastverkeer blijft beperkt tot het eigen VLAN; switches sturen geen broadcasts naar andere VLANs door.

Default is elke switchpoort lid van VLAN 1, het standaard VLAN.

- VLANs worden op switches geconfigureerd per interface.
- Logische scheiding van eindapparaten op layer 2.

### Wat is een Trunk?

Een trunk is een verbinding tussen switches die meerdere VLANs ondersteunt. Trunks gebruiken tagging om te bepalen bij welk VLAN een frame hoort. Dit maakt het mogelijk om verkeer van verschillende VLANs over dezelfde fysieke verbinding te verzenden. Trunk ports zijn "tagged" en kunnen meerdere VLANs tegelijk transporteren.

#### Trunking Protocols

De meest gebruikte trunking protocol is IEEE 802.1Q, dat VLAN-tags toevoegt aan Ethernet frames. ISL (Inter-Switch Link) is een Cisco-specifiek protocol dat ook trunking mogelijk maakt, dit is echter minder gebruikelijk en verouderd. IEEE 802.1Q is een industrie standaard gemaakt door de IEEE (Institute of Electrical and Electronics Engineers). De Cisco-term is dot1q.

<img src="/assets/vlan-tag802.1Q.png" alt="VLAN Tag 802.1Q" width="600">

De TPID (Tag Protocol Identifier) is een 16-bits veld dat aangeeft dat het frame een VLAN-tag bevat. Het TPID-veld heeft de waarde `0x8100` voor 802.1Q frames. 

De TCI bevat 3 velden:

- **PCP (Priority Code Point):** 3 bits voor QoS-prioriteit.
- **DEI (Drop Eligible Indicator):** 1 bit om aan te geven of het frame kan worden gedropt bij congestie.
- **VID (VLAN Identifier):** 12 bits die het VLAN identificeren waartoe het frame behoort.

Met 12 bits zijn er maximaal 4096 VLANs mogelijk, maar VLAN 0 en 4095 zijn gereserveerd, dus effectief zijn er 4094 VLANs beschikbaar.  
De range van VLANs zijn in 2 groepen verdeeld:
- **Normale VLANs:** 1-1005
- **Extended VLANs:** 1006-4094

### Wat is een Access Port?

Een access port is een switchpoort die is geconfigureerd om lid te zijn van één specifiek VLAN. Access ports worden gebruikt om eindapparaten zoals computers, printers en servers aan te sluiten. Ze verzenden frames zonder VLAN-tag, omdat ze slechts één VLAN ondersteunen.

Access ports worden wel eens "untagged" genoemd omdat ze geen VLAN-tag bevatten. 

### Wat is een Native VLAN?

De switch voegt geen VLAN-tag toe aan frames die van het native VLAN komen. Dit betekent dat als een frame van het native VLAN over een trunkport wordt verzonden, het frame geen tag heeft.     
Op een trunkport is het default native VLAN 1 maar dit kan aangepast worden. Je moet dit consistent houden over alle trunk links om problemen te voorkomen.

---