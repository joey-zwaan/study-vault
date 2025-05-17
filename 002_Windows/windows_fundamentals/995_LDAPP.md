# LDAP

LDAP is een volwassen protocol die dient om te communiceren (bevragen, toevoegen , wijzigen) met directory servers.

Het bepaalt de manier waarop de data binnen een DS moet weergeven worden aan gebruikers en legt vereisten op voor de componenten die data toevoegen aan de DS.

LDAP-Communicatie is niet standaard veilig. Wens je veilige LDAP communicatie kan je geburik maken van LDAPS (LDAP over SSL) of LDAP signing in combinatie met Channel Binding


## Schema

Binnen LDAP & AD word gebruik gemaakt van een scehma. Alle informatie binnen AD word bewaard als een object. Een object kan je zien als een verzameling van gegevens omtrent een specifieke gebruiker, computer, groep, printer of anderen. Elk object bevat attributen of properties & deze atributen bepalen de eigenschappen van dat object.

Elk type object zal de zelfde eigenschappen hebben maar een andere invulling ervan.

<img src="/assets/LDAP1.png" alt="share" width="600">

Een schema moeten we zien als een blauwdruk van hoe objecten er uitzien. MAW de definiering van welke attributen bij welk soort scehma hoort is iets dat bepaalt wordt in het schema.

---

## LDAP OPBOUW

### Distinguished Name - DN

**GUID VS DN**

Wanneer je vele objecten zal bewaren binnen je AD ga je moeten zorgen dat elk object uniek kan herkend en teruggevonden worden

Globally Unique Identifier (GUID) wordt toegekend aan elk object om dit te kunnen bereiken. GUID is nogal onhandig om te onthouden als mens. Het maakt ook geen gebruik van de structuur binnen LDAP. Er bestaat een andere en meer gebruikte methode om een object aan te spreken namelijk Distinguished Name (DN)

Binnen LDAP zal DN een object uniek identificeren en zal de DN de positie van het object binnen DIT(Directory Information Tree) aangeven. Je kan het vergelijken met een absoluut pad op een filesysteem.

Aan de bron van de DIT staat een special wortel element ook wel de Root DSE.
DSE staat hier voor DSA Specific entry en bevat informatie over de data die op de server staat.


<img src="/assets/LDAP2.png" alt="share" width="600">

Distuinguished name 

CN=Rand Al Thor,OU=IT Development,OU=IT,OU=LOCAL.TEST,DC=local,DC=test


CN of Common Name is een naam toegekent door de beheerder aan het object.

OU of Organizational unit word binnen LDAP gebruikt om objecten te structuren en te orderenen (een container)

DC of Domain Component definieert de top van de LDAP-boomstructuur dat gebruikt maakt van DNS. Elk onderdeel van de DNS namespace wordt aangegeven met een DC-component


### RDN

Naast de dn hebben we ook nog de Relative Distinguished Name of RDN

Wordt gebruikt om een object uniek te identificeren binnen zijn parentcontainer binnen de directory structuur.

In het voorbeeld hierboven is de RDN ‘CN=Rand Al Thor’.
Binnen de container ‘OU=IT Development’ kan je dan ook maar 1 object hebben met de ‘CN=Rand Al
Thor’. Je kan binnen je directory wel nog een ander object hebben met dezelfde CN maar deze moet dan
in een andere container zitten

### SamAccountName vs UPN

SAMAccountName: dit komt overeen met de pre-Windows 2000 aanmeldnaam. Wanneer je je wil
aanmelden met deze naam gebruik je de vorm ‘DOMAIN\USERLOGONNAAM’. Hier merken we op dat
de SAMAccountName maar uit 20 karakters kan bestaan, het DOMAIN gedeelte het eerste stuk is van je
domeinnaam en gebaseerd is op een oude technologie genaamd NETBios maar nog steeds gebruikt
wordt in sommige onderdelen binnen Windows en gerelateerde software.
UPN (User Principal Name): dit komt overeen met de modernere en voorkeursmanier van aanmelden
en gelijkt op een email adres. De vorm is ‘USERLOGONNAAM@DOMEINNAAM’. Het voordeel van deze manier van aanmelden is dat de gebruiker uniek wordt aangegeven in het forest door het suffix gedeelte na de @


