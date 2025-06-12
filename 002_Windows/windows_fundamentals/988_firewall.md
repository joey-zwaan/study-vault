# Windows Defender Firewall

Windows Defender Firewall is een host-based firewall.  
Het beschermt één specifieke host, namelijk het systeem waarop de software actief is.

Binnen Windows bestaan er verschillende netwerkprofielen, afhankelijk van het type netwerk waarmee je verbindt. Standaard zijn de volgende profielen aanwezig:

- **Domain Profile**  
  Dit profiel wordt gebruikt binnen netwerken waar authenticatie plaatsvindt tegen een Domain Controller (DC). Als je toestel aan een domein is toegevoegd, zal dit profiel actief zijn.

- **Private Profile**  
  Ontworpen en best gebruikt binnen privé-netwerken zoals thuis.

- **Public Profile**  
  Ontworpen met hogere veiligheid in gedachten voor publieke netwerken zoals wifi-hotspots, koffiebars, luchthavens, enz.

Elk profiel heeft een eigen standaard beveiligingsniveau. Het is logisch dat op een publiek profiel je beveiliging hoger staat dan op een veiligere omgeving zoals een domeinprofiel. Je kan het per profiel verder aanscherpen of aanpassen.

## Regels

De regels in je firewall bepalen welk verkeer er wel of niet toegelaten wordt. Er is meestal een onderscheid tussen inkomend en uitgaand verkeer.

- **Binnenkomende regels** regelen het binnenkomende verkeer.  
  Standaard wordt hier alles geblokkeerd, tenzij er een regel bestaat die het specifieke binnenkomende verkeer toelaat.

  Wanneer je bepaalde rollen installeert op een server, worden automatisch de bijhorende firewallregels opengezet. Promoveer je een server tot DC, dan is het nodig dat gebruikers de AD kunnen contacteren om zich te authenticeren. Bij het installeren vraagt Windows soms toestemming om verkeer door te laten op de firewall. Altijd goed controleren is de boodschap.

- **Uitgaande regels** bepalen wat er gebeurt met verkeer dat het toestel verlaat.  
  Hier wordt alles doorgelaten, ongeacht of er al dan niet een regel voor is. Kies je hier voor blokkeren, dan moeten de nodige regels voorzien worden om het verkeer toe te laten vanaf de host naar buiten.

De firewall kan handmatig beheerd worden. Gebruik je een grafische omgeving (zoals op een client of een server met desktop experience), dan kan je via het programma **Windows Defender with Advanced Security** de firewall beheren.

Binnen een GPO kan je firewallregels instellen via:  
`Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Windows Defender Firewall with Advanced Security`

Het standaardgedrag bij het toepassen van firewallregels via GPO is dat deze regels samengevoegd worden met bestaande lokale regels. Bij een overlap zal de meest restrictieve regel winnen.

Een goede manier om te starten is bij Windows Clients een referentiecomputer te configureren met de nodige firewallregels. Deze regels worden geëxporteerd in een bestand. In een GPO kan dit bestand dan gebruikt worden als referentieregels.

## Best Practice

- Schakel de WDF nooit uit.
- Gebruik de default settings waar mogelijk. Deze zijn opgesteld met de meeste netwerkomgevingen in gedachten en vormen een goede standaard.
- Maak gescheiden GPO's om de firewalls te beheren van werkstations en servers. Binnen elke groep kan je nog verder opsplitsen, gezien de firewallregels voor databankservers, Exchange servers, DC's en andere servers anders zullen zijn.
- Een GPO voor werkstations waarmee je de firewall inschakelt, voorkomt werkstations waar deze foutief is uitgeschakeld. Een ketting is maar zo sterk als zijn zwakste schakel.
- Test firewallregels uit in een testomgeving voordat je ze naar productie uitrolt.
- Expliciete block rules hebben voorrang op conflicterende allow rules.
- Specifieke rules hebben voorrang op algemene rules.
- Shields up mode: block all connections tijdens een aanval.