# Docker

## Docker netwerk

### Drivers

Docker Engine heeft een paar netwerkdrivers ingebouwd:

- **bridge**: De standaardnetwerkdriver voor containers die op een enkele host draaien. Hiermee kunnen containers op dezelfde host met elkaar communiceren.
- **host**: Hiermee deelt een container het netwerk van de host. Dit betekent dat de container dezelfde IP-adressen en poorten gebruikt als de host.
- **overlay**: Hiermee kunnen containers op verschillende Docker-hosts met elkaar communiceren via een gedeeld netwerk.
- **ipvlan**: Hiermee kunnen containers op verschillende hosts communiceren via een gedeeld netwerk, met ondersteuning voor meerdere IP-adressen per container (vlan).
- **macvlan**: Verschijnt als een fysiek apparaat op het netwerk van de host.
- **none**: Hiermee wordt geen netwerk toegewezen aan de container. Dit is handig voor containers die geen netwerktoegang nodig hebben.
