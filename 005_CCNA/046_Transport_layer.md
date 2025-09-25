# Transport Layer

## Overzicht

De Transport Layer is verantwoordelijk voor end-to-end communicatie tussen hosts.

- **Betrouwbare overdracht (TCP):**
  - Zorgt ervoor dat data correct en in de juiste volgorde aankomt.
- **Error recovery (TCP):**
  - Herstelt fouten door verloren of beschadigde pakketten opnieuw te verzenden.
- **Data sequencing (TCP):**
  - Zorgt ervoor dat pakketten in de juiste volgorde worden afgeleverd.
- **Flow control (TCP):**
  - Voorkomt dat een snelle zender een trage ontvanger overweldigt.

## Layer 4 Adressering (Poortnummers)

- **Identificatie van Application Layer-protocollen:**
  - Poortnummers koppelen specifieke applicaties aan datastromen.
- **Multiplexing van datastromen:**
  - Meerdere applicaties kunnen tegelijkertijd communiceren via dezelfde verbinding.
- **Well-known ports (0-1023):**
  - Voor gereserveerde diensten en protocollen (bijv. HTTP, FTP, SMTP).
- **Registered ports (1024-49151):**
  - Voor applicaties die niet onder de well-known ports vallen.
- **Dynamic/Private ports (49152-65535):**
  - Voor tijdelijke of privéverbindingen.


## TCP (Transmission Control Protocol)

TCP is een connectie-georiënteerd protocol. Voordat data wordt verzonden, moeten de twee hosts een verbinding tot stand brengen. Zodra de verbinding is gemaakt, kan de dataoverdracht beginnen.

### Functies van TCP

1. **Betrouwbare communicatie:**
   - De bestemming moet bevestigen dat een TCP-segment is ontvangen.
   - Als de bevestiging niet wordt ontvangen, zal de zender het segment opnieuw verzenden.

2. **Sequencing:**
   - TCP voegt een volgnummer toe aan elk segment.
   - De ontvanger kan de segmenten in de juiste volgorde reconstrueren.
   - Als een segment ontbreekt, kan de ontvanger een verzoek om hertransmissie sturen.

3. **Flow control:**
   - TCP gebruikt een venstermechanisme om te voorkomen dat een snelle zender een trage ontvanger overweldigt.


### Three-way handshake (TCP)

Als we naar een website gaan gebeurd het volgende om een verbinding tot stand te brengen.

Client : SYN FLAG --> 
Server : SYN-ACK FLAG <--
Client : ACK FLAG -->

Na dit is de verbinding tot stand gebracht en kan de dataoverdracht beginnen.

##### Four-way handshake (TCP)

Bij het beëindigen van een TCP-verbinding wordt een vier-weg handdruk gebruikt.

1. **Einde van de verbinding (Client):**
   - Client : FIN FLAG -->
2. **Bevestiging (Server):**
   - Server : ACK FLAG <--
3. **Einde van de verbinding (Server):**
   - Server : FIN FLAG -->
4. **Bevestiging (Client):**
   - Client : ACK FLAG <--

Na deze stappen is de verbinding volledig beëindigd.

**Sequencing / Acknowledgment (TCP)**

<img src="/assets/sequenceTCP.png" alt="TCP Sequencing and Acknowledgment" width="600">

- **Volgnummer (Sequence Number):**
  - Elk TCP-segment bevat een volgnummer dat aangeeft waar de data in de totale stroom hoort.
  - Dit helpt de ontvanger om de data in de juiste volgorde te plaatsen.
- **Bevestigingsnummer (Acknowledgment Number):**
  - Elk TCP-segment bevat een bevestigingsnummer dat aangeeft welk segment de ontvanger heeft ontvangen.
  - Dit helpt de zender te begrijpen welke data succesvol is afgeleverd.

  Als er na een tijd geen ACK komt dan zal de zender het segment opnieuw verzenden.


#### Flow Control (TCP) 

De TCP header's Window Size (W) staat toe dat er meer data verzonden wordt voordat een acknowledgment (ACK) van de ontvanger vereist is.
Een "sliding window" kan gebruikt worden om dynamisch de grootte van het venster aan te passen.

## UDP

Is niet connectie-georiënteerd en biedt geen garantie voor betrouwbare aflevering van gegevens. UDP is sneller dan TCP, maar met minder overhead en zonder foutcorrectie.

### Kenmerken van UDP

1. **Geen verbinding:**
   - UDP maakt geen verbinding voordat gegevens worden verzonden.
   - Dit vermindert de latency, maar verhoogt het risico op gegevensverlies.

2. **Geen foutcorrectie:**
   - UDP biedt geen mechanismen voor foutdetectie of -correctie.
   - Verloren of beschadigde pakketten worden niet opnieuw verzonden.


3. **Snelle gegevensoverdracht:**
   - UDP is ideaal voor toepassingen die snelheid vereisen, zoals video- en audiostreaming.

4. **Multicast-ondersteuning:**
   - UDP ondersteunt multicast, waardoor gegevens naar meerdere ontvangers tegelijk kunnen worden verzonden.
5. **Geen flow control:**
   - UDP heeft geen mechanismen voor flow control, wat betekent dat zenders gegevens kunnen blijven verzenden zonder te wachten op bevestigingen van de ontvanger.  