# Ethernet & Netwerkmedia

Ethernet is een verzameling netwerkprotocollen en -standaarden die zorgen voor betrouwbare communicatie tussen apparaten, ongeacht fabrikant of taal. Het vormt de basis van vrijwel alle bekabelde netwerken.

Ethernet media verwijst naar de fysieke kabels en verbindingen die worden gebruikt om netwerken te bouwen. De meest voorkomende types zijn:
- **Twisted Pair Cable** (UTP/STP): Meest gebruikt, zoals Cat5e, Cat6, Cat6a en Cat7. Ontworpen voor hoge snelheden en lage interferentie.
- **Fiber Optic Cable**: Voor lange afstanden en hoge snelheden. Bestand tegen elektromagnetische interferentie en biedt hoge bandbreedte.
- **Coaxial Cable**: Minder gebruikelijk in moderne netwerken, maar nog steeds gebruikt in toepassingen zoals kabeltelevisie en oudere Ethernet-netwerken.
- **Wireless (Wi-Fi)**: Draadloze Ethernet-verbindingen via radiogolven.


Electromagnetic-interference (EMI) of radio frequency interference (RFI) 
- kunnen de signaalkwaliteit beïnvloeden, vooral bij langere kabels. 
- bronnen van EMI/RFI zijn onder andere radiogolven, fluorescentielampen en elektrische motoren.

Crosstalk
- verstoring veroorzaakt door de electrische of magnetische velden van een signaal dat in een kabel loopt, die invloed heeft op een ander signaal in een nabijgelegen kabel.
- In telefoons kan het resultaat zijn dat je een gesprek hoort van een andere lijn, of dat je eigen stem terughoort.
- Wanneer een electrische stroom door een kabel loopt, creëert het een magnetisch veld dat invloed kan hebben op nabijgelegen kabels. Dit kan leiden tot signaalverlies of interferentie.

---

### Veelvoorkomende Ethernet-standaarden

#### Copper (UTP) standaarden

| **Type**             | **Standaard**   | **IEEE**    | **Max. Snelheid** | **Max. Lengte**      |
|----------------------|-----------------|------------|-------------------|----------------------|
| **Ethernet**         | 10Base-T        | 802.3      | 10 Mbps           | 100 meter (UTP)      |
| **Fast Ethernet**    | 100Base-T       | 802.3u     | 100 Mbps          | 100 meter (UTP)      |
| **Gigabit Ethernet** | 1000Base-T      | 802.3ab    | 1 Gbps            | 100 meter (UTP)      |
| **10 Gig Ethernet**  | 10GBase-T       | 802.3an    | 10 Gbps           | 100 meter (UTP)      |

#### Fiber standaarden

| **Type**             | **Standaard**   | **IEEE**    | **Max. Snelheid** | **Medium**           | **Max. Lengte**      |
|----------------------|-----------------|-------------|-------------------|----------------------|----------------------|
| **Fast Ethernet**    | 100Base-FX      | 802.3u      | 100 Mbps          | Multi-mode fiber     | 412 meter            |
| **Gigabit Ethernet** | 1000Base-SX     | 802.3z      | 1 Gbps            | Multi-mode fiber     | 550 meter            |
| **Gigabit Ethernet** | 1000Base-LX     | 802.3z      | 1 Gbps            | Single-mode fiber    | 5 km                 |
| **10 Gig Ethernet**  | 10GBase-SR      | 802.3ae     | 10 Gbps           | Multi-mode fiber     | 400 meter            |
| **10 Gig Ethernet**  | 10GBase-LR      | 802.3ae     | 10 Gbps           | Single-mode fiber    | 10 km                |
| **10 Gig Ethernet**  | 10GBase-ER      | 802.3ae     | 10 Gbps           | Single-mode fiber    | 30 km                |

---

**Uitleg termen:**
- **Base** = baseband, signaal alleen voor dat protocol.
- **T** = twisted pair (koper).
- **FX** = fiber optic (glasvezel).
- **SR** = short range (korte afstanden, meestal multi-mode fiber).
- **LR** = long range (lange afstanden, meestal single-mode fiber).
- **ER** = extended range (zeer lange afstanden).
- **UTP** = Unshielded Twisted Pair, geen afscherming.
- **STP** = Shielded Twisted Pair, wel afscherming.

**Kabels:**
- Cross-over kabels werden gebruikt voor verbindingen tussen twee dezelfde typen apparaten (zoals twee switches of twee computers).
- Straight-through kabels werden gebruikt voor verbindingen tussen verschillende typen apparaten (zoals een switch en een computer).
- Dankzij Auto MDI-X in moderne apparatuur is het verschil tussen deze kabels meestal niet meer relevant: apparaten detecteren automatisch welke pinnen gebruikt moeten worden.

**Fiber:**
- **Multimode fiber** heeft een grotere core diameter, laat meerdere lichtmodi toe, is goedkoper en geschikt voor kortere afstanden (meestal LED-zenders).
- **Single-mode fiber** heeft een kleinere core diameter, één lichtstraal (mode), is duurder en geschikt voor veel langere afstanden (meestal laser-zenders).

