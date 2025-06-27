# Ethernet

## Physical Layer (Layer 1)

De Physical Layer definieert de fysieke kenmerken van het gebruikte medium om data over te dragen tussen apparaten.

**Medium specificaties:**
- Het type kabel of draadloos medium (koper, glasvezel, radiofrequentie)
- De elektrische of optische signalen (spanningsniveaus, lichtpulsen)
- Connectoren en pinconfiguraties

**Netwerk karakteristieken:**
- Fysieke topologie (bus, ster, ring)
- Specificaties zoals kabellengtes, bandbreedte, en transmissiesnelheden

**Functies:**
- Converteert frames naar bits
- Verstuurt bits als elektrische/optische signalen over het fysieke medium
- Ontvangt signalen en converteert deze terug naar bits
- Geen adressering - werkt alleen met ruwe bits

## Ethernet Frame


Een Ethernet frame is de eenheid van data die over een Ethernet-netwerk wordt verzonden. Het bestaat uit verschillende delen:
- **Preamble**: 7 bytes (56 bits), gebruikt om kloksynchronisatie te bereiken tussen zender en ontvanger. Bestaat uit zeven opeenvolgende bytes met het patroon 10101010 * 7, die zorgen voor een ritmische klok voor de ontvanger om zich op af te stemmen.
- **Start Frame Delimiter (SFD)**: 1 byte (8bits), markeert het begin van het frame. 10101011, dit geeft aan dat de preamble is afgelopen en het daadwerkelijke frame begint.
- **Destination MAC Address**: 6 bytes, het MAC-adres van de ontvanger.
- **Source MAC Address**: 6 bytes, het MAC-adres van de zender
- **EtherType/Length**: 2 bytes, geeft het type protocol aan (bijv. IPv4, IPv6) of de lengte van de payload. IPV4 = 0x0800, IPV6 = 0x86DD

**Ethernet trailer**
- **FCS (Frame Check Sequence)**: 4 bytes, gebruikt voor foutdetectie door een CRC (Cyclic Redundancy Check) toe te passen op de gegevens in het frame door de ontvanger.

26 bytes (header + trailer)
