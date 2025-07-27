# Routing

## Inleiding

Routing is het proces waarbij routers bepalen welke route IP-pakketten moeten volgen om hun bestemming te bereiken. Routers bewaren routes van bekende netwerken in hun routing table en kiezen op basis daarvan de beste route voor elk ontvangen pakket.

## Soorten Routing

Er zijn twee hoofdtypen routing:

- **Statische routing:** Handmatig geconfigureerd door een beheerder.
- **Dynamische routing:** Automatisch beheerd door routingprotocollen, waarbij routers informatie uitwisselen en hun routing tables aanpassen bij netwerkveranderingen.

Een route vertelt de router waar een pakket naartoe moet: naar een next-hop router of, als het netwerk direct verbonden is, naar de juiste interface. Is de bestemming het eigen IP-adres van de router, dan wordt het pakket direct afgeleverd aan de router zelf.

## Routing Details

- **Local route:** Het specifieke IP-adres van de router op een interface.
- **Connected route:** Een netwerk dat direct verbonden is met de router via een interface.

Voorbeeld:  
Bij een connected route naar `192.168.1.0/24` worden alle adressen binnen dat netwerk doorgestuurd, andere adressen worden gedropt.

```
192.168.1.2   → match, wordt verstuurd
192.168.1.7   → match, wordt verstuurd
192.168.1.89  → match, wordt verstuurd
192.168.2.1   → geen match, wordt gedropt
```

Als een pakket op meerdere routes matcht, kiest de router altijd de meest specifieke (langste prefix).  
Bijvoorbeeld:

- `192.168.1.0/24`
- `192.168.1.1/32`

Voor bestemming `192.168.1.1` kiest de router de `/32` route.

Routers flooden nooit zoals switches. Als een router geen route kent naar de bestemming, wordt het pakket altijd gedropt.

## Default Gateway

End hosts gebruiken een default gateway om adressen buiten hun eigen netwerk te bereiken. De default route (`0.0.0.0/0`) geeft aan waar pakketten naartoe moeten als er geen specifieke route bekend is.

### Point-to-Point Verbindingen

Bij een point-to-point verbinding, zoals tussen twee routers, kun je een `/31` subnet gebruiken omdat je geen broadcast of netwerkadres nodig hebt. Dit geeft je precies twee bruikbare IP-adressen voor de twee routers.


## ROAS (Router-on-a-Stick)

**Router-on-a-Stick (ROAS)** is een methode waarbij één enkele fysieke routerinterface gebruikt wordt om verkeer tussen meerdere VLANs te routeren. Dit gebeurt door op die interface meerdere **subinterfaces** te configureren. Elke subinterface is gekoppeld aan een specifieke VLAN via **802.1Q VLAN-tagging**.

Deze aanpak is nodig omdat switches standaard geen verkeer tussen VLANs doorlaten (layer 2-beperking). Door een router toe te voegen (layer 3), wordt **inter-VLAN-communicatie** mogelijk. In plaats van voor elke VLAN een aparte fysieke verbinding te voorzien, wordt met ROAS alles via één trunkverbinding afgehandeld.

De switch stuurt getagd verkeer naar de router via een **trunkpoort**. De router herkent aan de hand van de tag tot welke VLAN het verkeer behoort, en stuurt het via de juiste subinterface naar het bijhorende subnet. Als verkeer van VLAN 10 naar VLAN 20 moet, verloopt dit via de router die beide subnets kent en daartussen kan routeren.

**Waarom gebruiken?**

- Bespaart fysieke interfaces
- Eenvoudig te beheren in kleine tot middelgrote netwerken
- Maakt VLAN-segmentatie mogelijk met centrale routing

Deze techniek is ideaal in omgevingen waar meerdere VLANs actief zijn, maar slechts één routerinterface beschikbaar is.

```cisco
interface g0/0.10
 encapsulation dot1Q 10
 ip address 192.168.1.1 255.255.255.0
```

- `g0/0.10`: Subinterface voor VLAN 10  
- `encapsulation dot1Q 10`: VLAN 10 tagging inschakelen  
- `ip address`: Default gateway voor VLAN 10 clients

---
