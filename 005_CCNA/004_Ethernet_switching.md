# Ethernet Switching

## Inleiding

Dit document behandelt de werking van Ethernet switching, de structuur van Ethernet frames, het gedrag van switches, ARP en ICMP.

## Physical Layer en Data Link Layer

De Physical Layer definieert de fysieke kenmerken van het gebruikte medium om data over te dragen tussen apparaten. De Data Link Layer zorgt voor de betrouwbare overdracht van frames over dit fysieke medium.

### Medium specificaties

- Type kabel of draadloos medium (koper, glasvezel, radiofrequentie)
- Elektrische of optische signalen (spanningsniveaus, lichtpulsen)
- Connectoren en pinconfiguraties

### Netwerk karakteristieken

- Fysieke topologie (bus, ster, ring)
- Kabellengtes, bandbreedte, transmissiesnelheden

### Functies

- Converteert frames naar bits
- Verstuurt bits als elektrische/optische signalen over het fysieke medium
- Ontvangt signalen en converteert deze terug naar bits
- Geen adressering, werkt alleen met ruwe bits

## Ethernet Frame Structure

Een Ethernet frame is de eenheid van data die over een Ethernet-netwerk wordt verzonden. Het bestaat uit verschillende delen.

### Frame Components

**Ethernet Header:**
- **Preamble**: 7 bytes (56 bits), gebruikt om kloksynchronisatie te bereiken tussen zender en ontvanger. Bestaat uit zeven opeenvolgende bytes met het patroon 10101010 * 7, die zorgen voor een ritmische klok voor de ontvanger om zich op af te stemmen.
- **Start Frame Delimiter (SFD)**: 1 byte (8 bits), markeert het begin van het frame. 10101011, dit geeft aan dat de preamble is afgelopen en het daadwerkelijke frame begint.
- **Destination MAC Address**: 6 bytes, het MAC-adres van de ontvanger.
- **Source MAC Address**: 6 bytes, het MAC-adres van de zender
- **EtherType/Length**: 2 bytes, geeft het type protocol aan (bijv. IPv4, IPv6) of de lengte van de payload. IPV4 = 0x0800, IPV6 = 0x86DD

**Ethernet Trailer:**
- **FCS (Frame Check Sequence)**: 4 bytes, gebruikt voor foutdetectie door een CRC (Cyclic Redundancy Check) toe te passen op de gegevens in het frame door de ontvanger.

### Frame Sizing

De Preamble en SFD zijn meestal niet beschouwd als deel van de Ethernet header. Daarom is de grootte van een Ethernet header + trailer 18 bytes (6 + 6 + 2 + 4).

**Minimum size:** 64 bytes (inclusief header en trailer)
- Payload minimaal 46 bytes (64 - 18 = 46)
- Als payload kleiner is, worden padding bytes toegevoegd

**Maximum size:** 1518 bytes (inclusief header en trailer)
- Payload maximaal 1500 bytes (1518 - 18 = 1500)
- Jumbo frames kunnen tot 9000 bytes payload hebben (niet standaard)

## Switch Behavior

### Frame Types

**Unicast frame:**  
Bestemd voor één specifieke ontvanger

**Broadcast frame:**  
Bestemd voor alle apparaten in het netwerk  
MAC-adres: FF:FF:FF:FF:FF:FF

**Multicast frame:**  
Bestemd voor een specifieke groep apparaten  
MAC-adres: begint met 01:00:5E (voor IPv4 multicast)  
Voorbeeld: 01:00:5E:00:00:01 voor multicast groep

### MAC Address Table

- Tabel die door switches wordt gebruikt om te bepalen naar welke poort een frame moet worden gestuurd
- Bevat MAC-adressen van apparaten en de poorten waarop ze zijn aangesloten
- Wordt dynamisch bijgewerkt wanneer frames worden ontvangen
- Bij ontvangst frame: bron-MAC-adres wordt toegevoegd aan tabel met bijbehorende poort
- Dynamische MAC-adressen worden na 5 minuten verwijderd bij geen activiteit
- Interface betekent niet altijd direct verbonden, kan ook via andere switch gaan

### Switch Forwarding Behavior

**Unknown unicast frame**  
Een frame met een bestemmings-MAC-adres dat niet in de MAC-adres tabel van de switch staat.  
- Wordt naar alle poorten verzonden (flooding), behalve de poort waar het frame vandaan komt.
- Zorgt ervoor dat het frame de juiste bestemming bereikt, ook als de switch de locatie niet kent.

**Known unicast frame**  
Een frame met een bestemmings-MAC-adres dat wél in de MAC-adres tabel staat.  
- Wordt alleen naar de specifieke poort gestuurd die overeenkomt met het MAC-adres.
- Efficiënter dan flooding omdat verkeer beperkt blijft tot de relevante poort.

## ARP (Address Resolution Protocol)

ARP wordt gebruikt om het MAC-adres van een apparaat te vinden op basis van zijn IP-adres. Het protocol werkt op de Data Link Layer (Layer 2).

- Een ARP-verzoek wordt als broadcast naar alle apparaten in het lokale netwerk gestuurd.
- Een ARP-respons wordt als unicast teruggestuurd naar de zender van het ARP-verzoek.

**ARP-table**  
- Bevat IP-adressen en bijbehorende MAC-adressen.
- Wordt gebruikt om snel het MAC-adres van een apparaat te vinden zonder opnieuw een ARP-verzoek te hoeven sturen.
- Dynamisch bijgewerkt bij ontvangst van ARP-verzoeken en -antwoorden.

**ARP-request frame:**  
- Bestemmings-MAC-adres: FF:FF:FF:FF:FF:FF (broadcast)
- Bron-MAC-adres: MAC-adres van de zender
- EtherType: 0x0806 (ARP)

**ARP-reply frame:**  
- Bestemmings-MAC-adres: MAC-adres van de zender van het ARP-verzoek
- Bron-MAC-adres: MAC-adres van de ontvanger
- EtherType: 0x0806 (ARP)
- Payload bevat ARP-header met IP- en MAC-adressen

## ICMP echo request/reply

ICMP wordt gebruikt voor netwerkdiagnose, bijvoorbeeld met het commando **ping**.

- **ICMP echo request** wordt verzonden naar een apparaat om te controleren of het bereikbaar is.
- **ICMP echo reply** wordt verzonden als antwoord op het verzoek.
- ICMP bevat geen MAC-adressen, alleen IP-adressen.
- Werkt op de Internet Layer (Layer 3)

---
