## Layered Defense & Defense in Depth

**Layered Defense**
- Beveiliging zal zich bevinden op meerdere lagen
- Bij falen van 1 laag werkt de beveiligingslaag nog steeds

**Defense in Depth**
- Meerdere componenten binnen je algemene beveiligingsbeleid
- Layered defense, monitoring/alerting, disaster recovery, rapportage, forensische analyse,...

## Cyber Killchain Framework

<img src="/assets/killchain-framework.png" width="600">

## Highest Privilege Groups

**Enterprise Admins (EA)**
- Binnen Forest Root Domain (eerste geinstalleerde forest domain) en lid van Built-in  Administrator (BA) groep in elk domain
- Ingebouwde Administrator van Forest Root Domain standaard lid van elk domain/forest
- Lidmaatschap indien wijzigingen aan Forest gebeuren
- IN PRINCIPE ENKEL INGEBOUWDE ADMINISTRATOR HIERVAN LID!!!

**Domain Admins (DA)**
- Elk domain in forest heeft eigen DA groep dat lid is van BA van dat domain
- DA groep lid van de Local Administrator groep van elk computerobject in domain
- Lid kan alles doen binnen domain
- Zeer uitzonderlijk!! NIET GEBRUIKEN!!

**Built-in Administrators Group (BA)**
- In elk domain standaard een administrator dat lid is van BA en DA. Gaat het om het forest root domain ook EA.
- Account voldoende beveiligen
- Enkel gebruiken voor disaster recovery en opzet omgeving

**Schema Admins (SA)**
- Binnen forest root domain.
- Lid is ingebouwde administrator van forest root domain
- Enkel nodig bij aanpassen schema!
- Goed monitoren

## Tiering

<img src="/assets/tiering.png" width="600">

**Tier 0**
Zeer kritisch dit gaat meestal over toestellen die een administratieve controle hebben over ons forest
- Domain controllers
- Exchange servers
- CA servers
- Private key infrastructure machines

**Tier 1**
Servers die een bepaalde service aanbieden aan de eindgebruikers maar die geen administratieve controle hebben.
- File server
- Database server
- application server
- app server

**Tier 2**
Dit gaat om toestellen van eindgebruikers
- Workstations
- Printers
- Laptops
- GSM

We willen ons beveiligen op basis van tier.
Het is dus logisch dat iemand van tier 2 zich niet moet kunnen aanmelden op een apparaat binnen tier 0 of tier 1.

Elke tier zal zijn eigen administrators nodig hebben.
Deze werken enkel op hun eigen tier.
Dit zal typisch via GPO ingesteld worden.
Hogere tier admin kan wel gelimiteerd user accounts aanpassen van een lagere tier

--> Dit gaat enkel over machines die on-prem draaien

**Protected Users Group**
- Moeilijker om gecachte credentials te bekomen
- Oudere legacy protocollen worden geweerd
- Sinds server 2012

Je kan dit in een Domain Admin plaatsen voor extra beveiliging

## Scheiding der machten

Dagdagelijkse taken
- normale user account

Admin taken
- Admin account met juiste rechten

Eventueel meerdere admin accounts afhankelijk van taak
- Tier-model

Absoluut minimum binnen onze labo
- serveradmin account
- domainadmin account
- normale useraccount


## FGPW

Fine grained password policy sinds server 2008
Voor bepaalde user groups afwijkende password en lock-out policy instellen

- Normale eindgebruiker is policy 1 en bijvoorbeeld 14 karakters en elke 6 maand wijzigen
- Domain Admins is policy 2 en bijvoorbeeld 20 karakters en elke maand wijzigen. Locked out na 1 foutive aanmelding

## MSA

Gebruik van user account om service onder te draaien maar dit heeft wel nadelen

- Typisch account met "Password Never Expire"
- Wachtwoord wijzigen account betekent dat je het wachtwoord moet wijzigen aan alle gelinkte services
- Documentatie + wachtwoorden bijhouden
- Kan je mogelijks gebruiken als account om aan te melden

Managed service account
sinds Server 2008 R2 MSA
- Willekeurig , automatisch gewijzigd, 240 char wachtwoord
- Kan niet gelocked worden. 
- 1 MSA per computer

## LAPS

Wanneer geinstalleerd zal elk computerobject een property bij kregen
We moeten hiervoor onze schema aanpassen.
Wachtwoord lokale admin bewaard in computerobject en worden automatisch hernieuwd

Slechte situatie 
- We hebben op elk computer een lokale admin. Deze hebben we rondgestuurd via GPO naar elk toestel met als gevolg
-  dat er maar 1 local admin is voor alle toestellen met maar 1 enkel wachtwoord. 

## Delegate Control

Kan je controle over bepaalde objecten in u AD delegeren naar andere.
Dit kan heel specifiek gebeuren.
vb --> Joost in ou_administratie kan wachtwoorden wijzigen van ou_Administratie

**Het is aan de beheerder om te bepalen welke user een bepaalde actie kan uitvoeren of security groups**

## RDP

Remote Desktop protocol
Best practice beveiliging

- NOOIT een RDP-enabled device rechtstreeks op een publiek netwerk aansluiten
--> Ook niet via VPN of gelijkwaardig
--> Eerst VPN tunnel naar bedrijf toe en dan pas RDP gebruiken om PC over te nemen
- Updaten en patchen van toestellen/software met RDP
- Beperkte toegang tot RDP-devices
- Complexe en unieke wachtwoorden
- Inactieve RDP sessies afsluiten
- Beveilig machines betrokken in RDP-sessies
- RDP over ssh


Restricted Access Mode for RDP
- Er worden geen credentials meegestuurd naar remote computer
- Zou default manier moeten zijn om rdp te gebruiken

## Time-based Group Membership

**TGM**

- Speciale account gebruiken om andere accounts tijdelijk toegang geven
- tot bepaalde security groepen
- Kan via aanpassen TTL TGT via PowerShell
--> Account kan je tijdelijk lid maken van bepaalde groep BV : Domain Admin
**Tijd begint te lopen zodra commando is ingegeven!**

<img src="/assets/TGM-toevoegen.png" width="600">

Opmerkingen:
❖ Het Forest Functional Level moet op Windows Server 2016 staan.
❖ Eenmaal ingeschakeld (staat default uitgeschakeld) kan je deze niet meer uitschakelen.


## Jump Server & PAW

**Jump Server**
De jump server kan je gebruiken om een groep van servers te beheren.

- De servers kunnen alleen beheerd worden door via de jump server in te loggen
- Extra beveiliging --> Bastion Server
- Enkel vanaf bepaalde toestellen aanmelden op de jumpserver

<img src="/assets/JUMP-server.png" width="600">

**PAW**

Wat is PAW?
--> Privileged Access Workstation
Werkstation dat enkel gebruikt wordt
voor administratieve taken

- Enkel deze heeft toegang tot administratieve taken , Jump server , ...
- Extra beveiligingsmaatregeln ( Firewall , Internettoegang , email etc..)
<img src="/assets/PAW.png" width="600">

## Windows Defender Firewall

WDF
Is een host based firewall
--> bescherming voor 1 toestel of host
een FW werkt met regels om al dan niet bepaald netwerkverkeer toe te laten
- Gratis
- Standaard ingebouwd in Windows

**Geavanceerde opties**
Verschillende soort profielen op basis van je situatie

- Domain Profile
Bedrijfsomgeving

- Private Profile
Thuisnetwerk

- Public Profile
Publiek netwerk ( openbare wifi)

Elk profiel heeft aparte en specifieke regels. 
Publiek profiel is de meest restrictieve bij default 

**Beheer van Firewall**
GUI
- Client of server met desktop experience
- Firewall & Firewall advanced opties

GPO
- Centraal Beheer
- Groeperen van machines volgens functies --> regels per groep

Powershell
  Get-Command *NetFirewall¨*

WAC
--> Windows Admin center
Hiermee kan je ook een firewall configuren op meerdere devices