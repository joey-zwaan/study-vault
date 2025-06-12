# Replication

## Wat is Replication?

Binnen een Domain is het best practice om minstens 2 DC's actief te hebben.  
Ze zijn gebaseerd op het **Multimaster** principe: elke read-write DC (RWDC) kan de databasewaarden aanpassen. Als een DC dit doet, is het de bedoeling dat de andere DC's op de hoogte zijn. Het systeem hiervoor heet **replicatie**.

Als alle DC's binnen de AD Database dezelfde waarden hebben, noemen we dit **convergentie**. Dit zal na een bepaalde tijd plaatsvinden. Totdat we in een staat van convergentie zijn, kunnen er verschillen zitten in de attributen van objecten in de AD Databases van de DC's. Dit heet **loose consistency**.

De **SYSVOL folder** bevat belangrijke informatie zoals GPO-gerelateerde data. Dit moet ook verstuurd worden naar de andere DC's. Het principe dat hiervoor gebruikt wordt om SYSVOL folders gesynchroniseerd te houden is **DFSR** (Distributed File System Replication).

---

## Componenten binnen replication

### Multimaster Replication

Elke DC kan zogenaamde **originating updates** ontvangen.  
Wanneer een gebruiker wordt aangemaakt op DC1, dan spreekt men over een originating update in de AD Database op DC1.  
Wanneer DC2 deze update binnenkrijgt, spreken we van een **replicated update**.

### Pull Replication

DC's vragen (to pull) wijzigingen op. Ze vragen ook enkel wat ze nodig hebben.  
Wanneer er een wijziging heeft plaatsgevonden binnen een DC, zal deze via een systeem de andere DC inlichten.

---

## Replicatie topology

Er zijn een aantal onderdelen nodig. De standaard tool om replicatie te configureren is **Active Directory Sites and Services (ADS&S)**.

Deze kan je toevoegen binnen een MMC snap-in binnen je management console of beheren via Server Manager of WAC.

<img src="/assets/replicatie.png" width="600">

Subnets zijn heel belangrijk voor objecten om de dichtste DC te lokaliseren die bijgevolg het snelst bereikbaar is.

---

## Sites & Domains

### Single Domain Sites

Dit komt het meeste voor in kleine en middelgrote ondernemingen.  
Wanneer we onze eerste DC configureren, komt hij standaard in dit ontwerp.

### Single Domain - Multiple Sites

In deze opstelling beschikt de onderneming maar over 1 domain, maar over meerdere fysieke locaties.  
De verbindingen tussen deze sites gebeurt via fysieke connecties.

### Multiple Domains - Single Site

Hier werken we met 1 fysieke locatie, maar met meerdere gebouwen die geconnecteerd zijn over een snelle LAN-verbinding waarbij elk gebouw een apart domain voorstelt.  
Hier zal het repliceren heel snel gaan tussen DC's.

### Multiple Domain - Multiple Sites

Dit is vooral bij grote organisaties met wereldwijde locaties.  
Repliceren zal hiervan van verschillende factoren afhangen.

---

## Inter-site vs Intra-site

### Intra-site replication

Dit is het replicatieproces binnen 1 site.  
Standaard zal elke DC binnen de 15 minuten op de hoogte zijn van wijzigingen.  
Belangrijk om te merken is dat de connecties volgens een ring-topologie gaan.

Elke DC zal 2 zogenaamde **Replication Links** hebben naar een andere DC. Dit voorkomt eindeloze replicatie loops.

### Inter-site replication

Wanneer je over meerdere sites beschikt, zal een wijziging in 1 site naar een andere site gerepliceerd moeten worden.

De replicatie tussen sites gebeurt aan de hand van een **Bridgehead Server** via zogenaamde **Site Links**.

---

## Update Sequence Number

Een DC weet of en wat er moet gerepliceerd worden aan de hand van een **USN** (Update Sequence Number).  
Wanneer er een wijziging op een DC gebeurt, dan zal de USN wijzigen.


