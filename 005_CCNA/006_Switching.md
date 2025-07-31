# Switching

## Inleiding

Dit document beschrijft de verschillen tussen full duplex en half duplex, de werking van switches en hubs, het concept van collision en broadcast domains, VLAN’s, het CSMA/CD-protocol en speed/duplex autonegotiation.

## Full Duplex vs Half Duplex

In een half-duplex verbinding kan data in beide richtingen worden verzonden, maar niet tegelijkertijd. In een full-duplex verbinding kunnen beide apparaten gelijktijdig data verzenden en ontvangen.

- **Half-duplex:** Apparaten kunnen om de beurt verzenden en ontvangen, maar niet tegelijkertijd. Dit kan leiden tot vertragingen en inefficiëntie.
- **Full-duplex:** Apparaten kunnen gelijktijdig verzenden en ontvangen, wat zorgt voor een snellere en efficiëntere communicatie. Dit is de standaardmodus voor moderne netwerken.

## Switches, Hubs en Domains

- **Switches:** Werken meestal in full-duplex modus, waardoor ze gelijktijdig data kunnen verzenden en ontvangen op verschillende poorten. Dit verhoogt de netwerkcapaciteit en vermindert vertragingen.
- **Hubs:** Werken in half-duplex modus, waardoor slechts één apparaat tegelijk kan verzenden. Dit kan leiden tot botsingen en vertragingen in het netwerk.
- **Collision Domain:** Een netwerksegment waar apparaten data kunnen versturen en ontvangen, maar waar botsingen kunnen optreden als twee apparaten tegelijkertijd proberen te verzenden. Switches verminderen het aantal collision domains door elke poort een eigen domein te geven, terwijl hubs alle poorten in één domein plaatsen.
- **Broadcast Domain:** Een netwerksegment waar een broadcast-pakket door alle apparaten kan worden ontvangen. Switches beperken broadcast domains door VLAN's te gebruiken, terwijl hubs alle poorten in één broadcast domain plaatsen.
- **VLAN's (Virtual Local Area Networks):** Logische scheidingen binnen een switch die het mogelijk maken om verschillende netwerken te creëren binnen hetzelfde fysieke netwerk. Dit helpt bij het verminderen van broadcast verkeer en het verbeteren van de netwerkbeveiliging.

## CSMA/CD Protocol

CSMA/CD (Carrier Sense Multiple Access with Collision Detection) is een protocol dat wordt gebruikt in netwerken om botsingen te detecteren en te voorkomen wanneer meerdere apparaten tegelijkertijd proberen te verzenden.  
Het werkt door eerst te luisteren naar het netwerk om te controleren of het vrij is voordat een apparaat begint met verzenden. Als er een botsing optreedt, stoppen de apparaten met verzenden en wachten ze een willekeurige tijd voordat ze opnieuw proberen te verzenden.

## Speed/Duplex Autonegotiation

Speed/Duplex autonegotiation is een proces waarbij apparaten automatisch de beste snelheid en duplexmodus bepalen voor hun verbinding. Dit zorgt ervoor dat apparaten die verschillende snelheden of duplexmodi ondersteunen, toch effectief kunnen communiceren.

Interfaces die verschillende snelheden aankunnen hebben default setting van speed auto en duplex auto. Dit betekent dat de interface automatisch de beste snelheid en duplexmodus zal kiezen op basis van de mogelijkheden van het verbonden apparaat.

Interfaces adverteren hun snelheid en duplexmodus aan elkaar, zodat ze kunnen onderhandelen over de beste instelling die ze beide ondersteunen. Dit gebeurt meestal via het autonegotiation-protocol, dat informatie uitwisselt over de mogelijkheden van elk apparaat.

---


