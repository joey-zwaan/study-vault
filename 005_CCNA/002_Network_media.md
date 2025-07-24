# Network Media

## Inleiding

Dit document beschrijft de belangrijkste netwerkmedia, hun eigenschappen, voordelen en nadelen. Er wordt ook uitgelegd welke standaarden er zijn en welke begrippen je moet kennen voor fysieke netwerken.

## Ethernet & Netwerkmedia

Ethernet is een verzameling netwerkprotocollen en -standaarden voor betrouwbare communicatie tussen apparaten. Ethernet media verwijst naar de fysieke kabels en verbindingen die gebruikt worden om netwerken te bouwen.

### Typen Netwerkmedia

- **Twisted Pair Cable (UTP/STP):**
  - Meest gebruikt (Cat5e, Cat6, Cat6a, Cat7)
  - Hoge snelheden, lage interferentie
- **Fiber Optic Cable:**
  - Lange afstanden, hoge snelheden
  - Bestand tegen elektromagnetische interferentie
- **Coaxial Cable:**
  - Minder gebruikelijk, nog in gebruik voor kabel-tv en oude netwerken
- **Wireless (Wi-Fi):**
  - Draadloos via radiogolven

### Elektromagnetische Interferentie (EMI) & Crosstalk

- **EMI/RFI:** 
  - Stoort signaalkwaliteit, vooral bij langere kabels
  - Oorzaken: radiogolven, TL-lampen, motoren
- **Crosstalk:** 
  - Verstoring van een signaal door andere kabels in de buurt
  - Kan leiden tot signaalverlies of interferentie

## Veelvoorkomende Ethernet-standaarden

### UTP (koper) standaarden

| Type               | Standaard    | IEEE    | Max. Snelheid | Max. Lengte      |
|--------------------|--------------|---------|---------------|------------------|
| Ethernet           | 10Base-T     | 802.3   | 10 Mbps       | 100 meter (UTP)  |
| Fast Ethernet      | 100Base-T    | 802.3u  | 100 Mbps      | 100 meter (UTP)  |
| Gigabit Ethernet   | 1000Base-T   | 802.3ab | 1 Gbps        | 100 meter (UTP)  |
| 10 Gig Ethernet    | 10GBase-T    | 802.3an | 10 Gbps       | 100 meter (UTP)  |

### Fiber standaarden

| Type               | Standaard    | IEEE    | Max. Snelheid | Medium            | Max. Lengte      |
|--------------------|--------------|---------|---------------|-------------------|------------------|
| Fast Ethernet      | 100Base-FX   | 802.3u  | 100 Mbps      | Multi-mode fiber  | 412 meter        |
| Gigabit Ethernet   | 1000Base-SX  | 802.3z  | 1 Gbps        | Multi-mode fiber  | 550 meter        |
| Gigabit Ethernet   | 1000Base-LX  | 802.3z  | 1 Gbps        | Single-mode fiber | 5 km             |
| 10 Gig Ethernet    | 10GBase-SR   | 802.3ae | 10 Gbps       | Multi-mode fiber  | 400 meter        |
| 10 Gig Ethernet    | 10GBase-LR   | 802.3ae | 10 Gbps       | Single-mode fiber | 10 km            |
| 10 Gig Ethernet    | 10GBase-ER   | 802.3ae | 10 Gbps       | Single-mode fiber | 30 km            |

### Uitleg termen

- **Base:** baseband, alleen dat protocol op de kabel
- **T:** twisted pair (koper)
- **FX:** fiber optic (glasvezel)
- **SR:** short range (meestal multi-mode fiber)
- **LR:** long range (meestal single-mode fiber)
- **ER:** extended range (zeer lange afstanden)
- **UTP:** Unshielded Twisted Pair
- **STP:** Shielded Twisted Pair

### Kabelsoorten en aansluitingen

- **Cross-over kabel:** voor verbinding tussen gelijke apparaten (switch-switch)
- **Straight-through kabel:** voor verschillende apparaten (switch-computer)
- **Auto MDI-X:** moderne apparaten herkennen automatisch het type verbinding

### Fiber-optic

- **Multimode fiber:** grotere core, meerdere lichtmodi, goedkoper, kortere afstand
- **Single-mode fiber:** kleinere core, één lichtstraal, duurder, langere afstand

---