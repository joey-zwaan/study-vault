## VLAN concepts (virtual LANs) 

Om VLANS te begrijpen moet je eerst een begrip hebben van de specifieke definitie van een LAN. Een LAN is alle apparaten in hetzelfde broadcast domein. Met enkel de default settings zijn alle interfaces van een switch bij default in hetzelfde broadcast domein. 

Met VLANS kan een switch opgedeeld worden in meerdere broadcast domeinen zonder dat er nog een extra switch nodig is zoals bij een LAN. De switch zal nooit een frame forwarden tussen verschillende VLANS.

### Creating Multiswitch VLANs (Trunking)

Een vlan op een enkele switch vereist weinig configuratie. Maar in een netwerk met meerdere switches moeten de switches met elkaar kunnen communiceren over welke VLANS ze ondersteunen. Dit wordt gedaan via een **trunk link** tussen de switches. Een switch gebruikt **VLAN tagging** door een extra header toe te voegen aan elk frame dat hij verstuurt over de trunk link. Deze header bevat o.a het VLAN ID. Hierdoor weet de ontvangende switch in welk VLAN het frame thuishoort.


#### VLAN tagging concepts

VLAN trunking creeert een link tussen switches die zoveel VLANS kan dragen als je nodig hebt. De switches behandelen de link alsof hij in elk VLAN zit. Toch houden trunks het VLAN verkeer gescheiden door middel van VLAN tagging en hierdoor belandt een frame voor VLAN 10 niet in VLAN 20.

Het gebruik van trunking links staat switches toe om frames van verschillende VLANS te versturen over een enkele fysieke link. Dit is efficiënter dan voor" elk VLAN een aparte fysieke verbinding te hebben.


Wanneer er een incorrecte trunk configuratie is dan gaat de switch die geen trunk is alle VLAN tagged frames droppen. De interface gaat nog steeds als up/up status zijn omdat native VLAN verkeer (untagged frames) nog steeds doorgelaten worden. 

#### 802.1Q VLAN tagging

Over de jaren heen waren er 2 trunking protocollen: ISL (Cisco proprietary) en 802.1Q (open standaard). Tegenwoordig is 802.1Q de standaard en wordt ISL niet meer gebruikt. De ISL was gemaakt omdat er in die tijd nog geen open standaard was voor VLAN tagging.

Cisco switches delen de VLANS IDs op in 2 ranges:
- **Normal range:** 1-1005 (1-1000 zijn bruikbaar, 1002-1005 zijn gereserveerd voor legacy protocollen zoals FDDI en Token Ring)
- **Extended range:** 1006-4094 (wordt niet ondersteund op alle switches)

802.1Q defineert ook een speciaal VLAN ID op elke trunk als native VLAN (default is VLAN 1). 
Frames die in de native VLAN thuishoren worden zonder tag verstuurd. Dit is om backwards compatibility te behouden met apparaten die geen VLAN tagging ondersteunen. Frames van andere VLANS worden altijd getagd verstuurd.

DTP (Dynamic Trunking Protocol) is een Cisco-proprietary protocol dat automatisch trunk links kan opzetten tussen switches. DTP onderhandelt de trunking modus en VLAN-informatie tussen twee verbonden switches. Het is handig voor eenvoudige configuraties, maar in productieomgevingen wordt het vaak uitgeschakeld om veiligheidsredenen. 

Er zijn de volgende DTP modes:
- **Access:** De poort is altijd in access mode en zal nooit een trunk worden.
- **Trunk:** De poort is altijd in trunk mode.
- **Dynamic auto:** De poort zal een trunk worden als de andere kant in trunk of dynamic desirable staat. Dit is de default mode.
- **Dynamic desirable:** De poort probeert altijd een trunk te maken. Hij zal een trunk maken als de andere kant in trunk of dynamic auto staat.

> Als beide switches in Dynamic auto staan zal er geen trunk worden gemaakt. Het is wel altijd aanbevolen om switchport nonegotiate in te stellen op trunk poorten om DTP uit te schakelen.

### Data & voice VLANs

IP telefonie (VoIP) maakt gebruik van VLANs om spraakverkeer te scheiden van data verkeer. . Het is gebruikelijk om aparte VLANs te creëren voor spraak- en dataverkeer, zodat QoS (Quality of Service) instellingen specifiek kunnen worden toegepast op het spraakverkeer.


**Data VLAN:** Wordt gebruikt om normaal dataverkeer (bijvoorbeeld van de pc die via de IP-telefoon verbonden is) te transporteren. Ongecodeerd (untagged) verkeer dat op de accesspoort binnenkomt, wordt toegewezen aan dit VLAN.

**Voice VLAN:** De VLAN die gebruikt wordt voor het spraakverkeer van de IP-telefoon zelfs. Verkeer in dit VLAN is meestal getagd met een 802.1Q header. 

Op een switch wordt een **access VLAN** gebruikt voor gewone apparaten zoals pc’s. Frames in dit VLAN worden altijd **zonder VLAN-tag** verstuurd. Het aangesloten apparaat hoeft dus niets te weten van VLAN’s.  
Wanneer er een **IP-telefoon** tussen staat, kan de switch op dezelfde poort ook een **voice VLAN** toewijzen. De telefoon tagt zijn eigen spraakverkeer dan met een **802.1Q-header**, zodat de switch dit kan scheiden van dataverkeer.  

De poort kan daardoor twee soorten verkeer tegelijk doorgeven:  
- **PC-verkeer (access VLAN):** gaat ongetagd  
- **Telefoonverkeer (voice VLAN):** gaat met een 802.1Q-tag  

Wanneer data van een server naar de pc wordt gestuurd, stuurt de switch het frame dus **zonder VLAN-tag** door. Voor de pc ziet dit eruit als een normaal Ethernet-frame, zonder dat deze iets merkt van de VLAN-configuratie.

> PAS OP! zonder vlan tag betekent niet native vlan. Native vlan is de vlan die gebruikt wordt voor untagged frames op een trunk link.

#### Native VLAN

Een **native VLAN** is de VLAN waarin **ongelabeld verkeer** (frames zonder 802.1Q-tag) op een trunk-poort terechtkomt.  
Standaard is dit meestal **VLAN 1**.

- Ongtagged verkeer op een trunk → wordt toegewezen aan de native VLAN  
- Frames uit de native VLAN → worden standaard **niet getagd** bij verzending  
- Handig voor compatibiliteit met apparaten die geen VLAN-tags begrijpen  

**Best practice:** gebruik een aparte, ongebruikte VLAN (bijv. 999) als native VLAN en niet VLAN 1.

De IEEE 802.1q TRUNKING encapsulation standaard zegt dat de NATIVE VLAN verkeer vertegenwoordigt dat wordt verzonden en ontvangen op een interface die 802.1q encapsulatie uitvoert en geen tag heeft. Dus hoewel de NATIVE VLAN ook bestaat op access-poorten, is de rol ervan alleen relevant op trunk-poorten.


#### Wanneer worden frames getagd?

Niet elk frame in een VLAN-netwerk wordt getagd. Tagging gebeurt alleen als een frame over een **trunkpoort** gaat. 

- **Access-poorten**  
  - Behoren tot één VLAN  
  - Verkeer van en naar eindapparaten (pc, printer, IoT) is altijd **untagged**  
  - De switch koppelt dit verkeer intern aan de juiste VLAN  

- **Trunk-poorten**  
  - Kunnen meerdere VLANs tegelijk vervoeren  
  - Frames krijgen een **802.1Q VLAN-tag** zodat de ontvangende switch weet bij welke VLAN het hoort  
  - Alleen frames uit de **native VLAN** gaan ongetagd over de trunk  

**Voorbeeld**  
1. PC stuurt een untagged frame naar een switchpoort in VLAN 20 → switch plaatst dit in VLAN 20  
2. Switch stuurt het frame verder over een trunk → frame wordt **getagd met VLAN 20**  
3. Andere switch ontvangt het → ziet de tag → plaatst het in VLAN 20  
4. Als het frame naar een pc in VLAN 20 moet, verwijdert de switch de tag en stuurt het **untagged** de accesspoort uit  


**voorbeeld configuratie trunk poort:**

```cisco
interface GigabitEthernet0/1
 switchport mode trunk
 switchport trunk native vlan 999
 switchport trunk allowed vlan 10,20,30
 switchport nonegotiate
```