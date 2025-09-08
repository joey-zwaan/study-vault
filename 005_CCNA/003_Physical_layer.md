## Physical Layer

De Physical Layer (Layer 1) van het OSI-model is verantwoordelijk voor de fysieke verbindingen tussen netwerkapparaten. Dit omvat de elektrische, optische of radiogolven die gebruikt worden om data over te dragen. De belangrijkste aspecten zijn de kabels, connectoren, signaalsterkte en transmissiesnelheid.

Ethernet is een verzameling netwerkprotocollen en -standaarden voor betrouwbare communicatie tussen apparaten. Ethernet media verwijst naar de fysieke kabels en verbindingen die gebruikt worden om netwerken te bouwen.

#### Soorten netwerkmedia

1. **Twisted Pair Cable (UTP/STP)**  
   - Meest gebruikt (Cat5e, Cat6, Cat6a, Cat7)  
   - Hoge snelheden, relatief goedkoop  
   - STP biedt extra bescherming tegen interferentie  

2. **Fiber Optic Cable**  
   - Geschikt voor lange afstanden en hoge snelheden  
   - Bestand tegen elektromagnetische interferentie  
   - Duurder en kwetsbaarder bij installatie  

3. **Coaxial Cable**  
   - Minder gebruikelijk in moderne netwerken  
   - Nog toegepast bij kabel-tv en oudere netwerken  

4. **Wireless (Wi-Fi)**  
   - Draadloze communicatie via radiogolven  
   - Handig voor mobiliteit, maar gevoeliger voor interferentie en beveiligingsrisico’s 

**Signaalproblemen**

- **EMI/RFI:** 
  - Stoort signaalkwaliteit, vooral bij langere kabels
  - Oorzaken: radiogolven, TL-lampen, motoren
- **Crosstalk:** 
  - Verstoring van een signaal door andere kabels in de buurt
  - Kan leiden tot signaalverlies of interferentie

#### Veelvoorkomende Ethernet-standaarden

**UTP (koper) standaarden**

| Type               | Standaard    | IEEE    | Max. Snelheid | Max. Lengte      |
|--------------------|--------------|---------|---------------|------------------|
| Ethernet           | 10Base-T     | 802.3   | 10 Mbps       | 100 meter (UTP)  |
| Fast Ethernet      | 100Base-T    | 802.3u  | 100 Mbps      | 100 meter (UTP)  |
| Gigabit Ethernet   | 1000Base-T   | 802.3ab | 1 Gbps        | 100 meter (UTP)  |
| 10 Gig Ethernet    | 10GBase-T    | 802.3an | 10 Gbps       | 100 meter (UTP)  |

**Fiber standaarden**

| Type               | Standaard    | IEEE    | Max. Snelheid | Medium            | Max. Lengte      |
|--------------------|--------------|---------|---------------|-------------------|------------------|
| Fast Ethernet      | 100Base-FX   | 802.3u  | 100 Mbps      | Multi-mode fiber  | 412 meter        |
| Gigabit Ethernet   | 1000Base-SX  | 802.3z  | 1 Gbps        | Multi-mode fiber  | 550 meter        |
| Gigabit Ethernet   | 1000Base-LX  | 802.3z  | 1 Gbps        | Single-mode fiber | 5 km             |
| 10 Gig Ethernet    | 10GBase-SR   | 802.3ae | 10 Gbps       | Multi-mode fiber  | 400 meter        |
| 10 Gig Ethernet    | 10GBase-LR   | 802.3ae | 10 Gbps       | Single-mode fiber | 10 km            |
| 10 Gig Ethernet    | 10GBase-ER   | 802.3ae | 10 Gbps       | Single-mode fiber | 30 km            |

- **Base:** baseband, alleen dat protocol op de kabel
- **T:** twisted pair (koper)
- **FX:** fiber optic (glasvezel)
- **SR:** short range (meestal multi-mode fiber)
- **LR:** long range (meestal single-mode fiber)
- **ER:** extended range (zeer lange afstanden)
- **UTP:** Unshielded Twisted Pair
- **STP:** Shielded Twisted Pair

#### Netwerkbekabeling

1. **Koperen kabels**  
   - **Cross-over kabel:** gebruikt voor verbinding tussen gelijke apparaten (bv. switch ↔ switch).  
   - **Straight-through kabel:** gebruikt voor verbinding tussen verschillende apparaten (bv. switch ↔ computer).  
   - **Auto MDI-X:** moderne apparaten herkennen automatisch het type verbinding, waardoor cross-over kabels vrijwel niet meer nodig zijn.  

2. **Glasvezel**  
   - **Multimode fiber (MMF):** grotere core, meerdere lichtmodi tegelijk, goedkoper, geschikt voor kortere afstanden.  
   - **Single-mode fiber (SMF):** kleinere core, één lichtstraal, duurder, geschikt voor langere afstanden.  

| Categorie | Max Snelheid | Bandbreedte
|-----------|--------------|-----------
| Cat5e     | 1 Gbps       | 100 MHz
| Cat6      | 10 Gbps      | 250 MHz
| Cat6a     | 10 Gbps      | 500 MHz
| Cat7      | 10 Gbps      | 600 MHz
| Cat8      | 40 Gbps      | 2000 MHz
