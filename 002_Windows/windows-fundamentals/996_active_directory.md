## Group Policy




**Central Storage**

We maken een Central storage for Administrative Templates (.admx) voor group policies. We maken een folder aan PolicyDefinitions op de locatie 
C:/windows/SYSVOL/sysvol/ZJLocal.test/policies

We downloaden de nieuwste templates voor Windows 10 en zorgen ook dat onze machines op de laatste updates zitten.
Het is belangrijk om ook de language files erbij te hebben.


## AGDLP


## Kerberos

Kerberos is een beveiligingsprotocol
Protocol waarbij het mogelijk is om te communiceren over een onveilig netwerk met een partner die niet altijd betrouwbaar is. Er word een 3e partij vertrouwd door zowel client 1 & client 2 terwijl ze elkaar onderling niet vertrouwen. ER WORDEN GEEN WACHTWOORDEN GESTUURD OVER HET NETWERK.

Open standaard --> RFC4120
Werkt met tickets.


** Onderdelen **

KDC (Key distribution server)
- AGS (Authenthication service)
- TGS (Ticket Granting Service)

SP (security principal)
Entiteit herkend door het beveiligingsysteem
- Users,group,computer

TGT 
- Een ticket, beperkt in de tijd om services te bekomen via TGS. Enkel leesbaar door de KDC en uitgegeven door AS. Bevat User Access Token waar instaat o.a welke groepen de user zit

Session Key
- Tijdelijke sleutel die je meekrijgt om communicatie met een DC te beveiligen voor de sessie. Geen user paswd meer nodig.

**Kerberos Process**

<img src="/assets/kerberos_1.png" width="600">

KDC (AS)
KDC(TGS)
- draait op een domain controller.

E word een request (AS-REQ) gestuurd naar de authentication service.
Dit bevat o.a
- Username
- Client Tijd
Deze is gencrypteerd met hash van gebruikerswachtwoord
AS Gaat deze decrypteren met hash gebruikerswachtwoord uit AD


Er word een antwoord teruggestuurd (AS-REP)
Dit bevat o.a
- Session Key
- TGT (Ticket granting Ticket)
- Geldigheidsduur van het ticket

<img src="/assets/kerberos_2.png" width="600">


Na de Authenticatie gaan we een service aanvragen we sturen een request (TGS-REQ) naar de TGS (Ticket granting service)

Dit bevat o.a
- Service Principal Name (SPN)
Unieke identificatie van de service die de user wil raadplegen

- TGT
Om aan te tonen dat we al geauthenticeerd zijn.

Er word een antwoord teruggestuurd (TGS-REP) 
Dit bevat o.a
- Service ticket
Dit zal de client presenteren aan de service om toegang te krijgen.
Niet leesbaar door de client --> versleuteld
Beperkt bruikbaar in de tijd


We sturen een request naar de service (AP-REQ)
Dit bevat o.a
- Service ticket

We krijgen een antwoord terug (AP-REP)
Omdat de KDC een vertrouwde 3e partij is vertrouwd de server het ticket en geeft hij toegang tot de service. Er is nog een mogelijkheid tot optionele verificatie van de authenticatie.
