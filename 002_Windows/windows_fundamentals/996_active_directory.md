# Active Directory Fundamentals

---

## Security Principal

Een Security Principal in Windows en Active Directory is een entiteit (zoals een gebruiker, groep, computer of service) die een Security Identifier (SID) heeft en toegang kan krijgen tot bronnen binnen een netwerk.

Voorbeelden van Security Principals
Gebruikersaccounts 

Normale gebruikers (bijv. Jan in AD)

Administrators (Administrator, Domain Admins)

Gasten (Guest)

2. **Groepen**  
   - Bevatten meerdere gebruikers en krijgen rechten toegewezen.
- Voorbeelden: Domain Users, Administrators, Backup Operators.

3. **Computeraccounts**  
   - Elke computer die lid is van een domein heeft een account in AD.
- Bijvoorbeeld: `PC-01$`  

4. **Service Accounts**  
   - Speciale accounts voor toepassingen en services, zoals SQL Server Service Account.

---

### Hoe werkt een Security Principal?

1. **Identificatie**  
   - Elke Security Principal heeft een unieke SID (Security Identifier).
- Dit wordt gebruikt voor authenticatie.

2. **Authenticatie & Autorisatie**  
   - **Authenticatie**: Wie ben je? (bijv. gebruikersnaam/wachtwoord of certificaat)
- **Autorisatie**: Wat mag je doen? (gebaseerd op rechten en groepslidmaatschappen)

3. **Toegangscontrole (ACLs - Access Control Lists)**  
   - Bestanden, mappen, printers en netwerkresources hebben ACL's met toegangsrechten voor specifieke Security Principals.  
   - Bijvoorbeeld: Jan mag een map lezen, maar niet bewerken.  

---

## Wat is een GPO?

Groepsbeleid (GPO) is een functie binnen Microsoft Windows waarmee beheerders instellingen centraal kunnen beheren en afdwingen binnen een netwerk.

### Belangrijke kenmerken:
- Centraal beheer van instellingen
- Configuratie-instructies
- Bewaard binnen o.a. Active Directory & SYSVOL
- Toepasbaar op computers of gebruikersaccounts

### Mogelijke instellingen:
- Beveiligingsinstellingen
- Scripts bij opstarten of afsluiten
- Publiceren van software
- Koppelen van netwerkschijven
- Publiceren van printers
- Aanpassen van instellingen via de Windows Registry

<img src="/assets/gpo_1.png" width="600">

**Belangrijk:**  
- **Computerconfiguratie** moet worden toegepast op een computerobject.  
- **Gebruikersconfiguratie** moet worden toegepast op een gebruikersobject.

---

## GPO Beheer

### Default Policies

1. **Default Domain Policy**
- Toegepast op alle gebruikers- en computeraccounts.
- Bevat instellingen zoals:
  - Wachtwoordbeleid
  - Accountvergrendeling
  - Kerberos-instellingen

2. **Default Domain Controllers Policy**
- Toegepast op alle domeincontrollers.
- Bevat instellingen zoals:
  - Toewijzen van gebruikersrechten
  - Auditing-instellingen

**Herstellen van deze policies:**  
Gebruik het commando `dcgpofix.exe` om de standaard policies te herstellen.  
**Best practice:** Gebruik deze policies niet voor andere instellingen.

---

### Scope van de GPO

De volgorde van toepassing van GPO’s is gebaseerd op de hiërarchie:

1. **Lokaal**  
   - Lokale Group Policy Editor

2. **Site**  
   - GPO’s ingesteld op site-niveau

3. **Domein**  
   - GPO’s ingesteld op domein-niveau

4. **OU(s)**  
   - GPO’s toegepast binnen een Organisational Unit (OU).  
   - Bij geneste OU’s worden alle GPO’s hiërarchisch toegepast.

---

### Registry

De Windows Registry is onderverdeeld in vijf hoofdsecties:

1. **HKEY_CLASSES_ROOT**  
   Gegevens voor algemeen gebruik, zoals geregistreerde bestandstypen en programma's die gegevens kunnen uitwisselen.

2. **HKEY_CURRENT_USER**  
   Instellingen die specifiek zijn voor de ingelogde gebruiker, zoals geïnstalleerde software, netwerkinstellingen, toetsenbord en muis.

3. **HKEY_LOCAL_MACHINE**  
   Instellingen voor hardware en software, zoals standaardconfiguraties, aangesloten hardware en softwareconfiguraties.

4. **HKEY_USERS**  
   Bevat alle gebruikersprofielen.

5. **HKEY_CURRENT_CONFIG**  
   Alle huidige instellingen van de computer.

---

### Hoe worden GPO's bewaard?

GPO’s bestaan uit twee onderdelen:

#### GPC (Group Pol---

### Registry

De Windows Registry is onderverdeeld in vijf hoofdsecties:

1. **HKEY_CLASSES_ROOT**  
   Gegevens voor algemeen gebruik, zoals geregistreerde bestandstypen en programma's die gegevens kunnen uitwisselen.

2. **HKEY_CURRENT_USER**  
   Instellingen die specifiek zijn voor de ingelogde gebruiker, zoals geïnstalleerde software, netwerkinstellingen, toetsenbord en muis.

3. **HKEY_LOCAL_MACHINE**  
   Instellingen voor hardware en software, zoals standaardconfiguraties, aangesloten hardware en softwareconfiguraties.

4. **HKEY_USERS**  
   Bevat alle gebruikersprofielen.

5. **HKEY_CURRENT_CONFIG**  
   Alle huidige instellingen van de computer.

icy Container)
- Bevat eigenschappen van de GPO, zoals versie-informatie #### GPC (Group Pol---

### Registry

De Windows Registry is onderverdeeld in vijf hoofdsecties:

1. **HKEY_CLASSES_ROOT**  
   Gegevens voor algemeen gebruik, zoals geregistreerde bestandstypen en programma's die gegevens kunnen uitwisselen.

2. **HKEY_CURRENT_USER**  
   Instellingen die specifiek zijn voor de ingelogde gebruiker, zoals geïnstalleerde software, netwerkinstellingen, toetsenbord en muis.

3. **HKEY_LOCAL_MACHINE**  
   Instellingen voor hardware en software, zoals standaardconfiguraties, aangesloten hardware en softwareconfiguraties.

4. **HKEY_USERS**  
   Bevat alle gebruikersprofielen.

5. **HKEY_CURRENT_CONFIG**  
   Alle huidige instellingen van de computer.

icy Container)
ctive Directory.  
  **Locatie:** `LDAP://CN{GUID},CN=P#### GPC (Group Pol---

### Registry

De Windows Registry is onderverdeeld in vijf hoofdsecties:

1. **HKEY_CLASSES_ROOT**  
   Gegevens voor algemeen gebruik, zoals geregistreerde bestandstypen en programma's die gegevens kunnen uitwisselen.

2. **HKEY_CURRENT_USER**  
   Instellingen die specifiek zijn voor de ingelogde gebruiker, zoals geïnstalleerde software, netwerkinstellingen, toetsenbord en muis.

3. **HKEY_LOCAL_MACHINE**  
   Instellingen voor hardware en software, zoals standaardconfiguraties, aangesloten hardware en softwareconfiguraties.

4. **HKEY_USERS**  
   Bevat alle gebruikersprofielen.

5. **HKEY_CURRENT_CONFIG**  
   Alle huidige instellingen van de computer.

icy Container)
ctive="/assets/GPC.png" width="600">

#### GPT (Group Policy Template)
- Bevat de daadwerkelijke instellingen van de GPO.
- Wordt opgeslagen binnen SYSVOL.  
  **Locatie:** `\\zjlocal.test\sysvol\zjlocal.test\Policies\{GUID}`

---

### Group Policy Loopback Processing Mode

Met de **Group Policy Loopback Processing Mode** kun je gebruikersconfiguratie-instellingen toepassen op een computerobject. Dit is handig in scenario’s zoals:

- **Kiosk-machines**: Computers in openbare ruimtes waar gebruikersinstellingen moeten worden toegepast, ongeacht wie inlogt.

#### Modes

1. **Merge Mode**  
   - Eerst worden de normale user policies toegepast bij de gebruiker die inlogt.  
   - Daarna worden de user configuration-instellingen toegepast die op het computerobject van toepassing zijn.  
   - Bij conflicterende instellingen heeft de instelling van het computerobject prioriteit.

2. **Replace Mode**  
   - Instellingen voor de gebruiker worden genegeerd bij het inloggen.  
   - Alleen de user configuration-instellingen van GPO’s die op het computerobject zijn toegepast, gelden.

**Let op:**  
LBM (Loopback Mode) is een instelling die geldt voor de hele computer.  
- Zodra LBM is ingesteld via één GPO, geldt deze voor de hele computer en dus voor elke gebruiker die zich aanmeldt op de computer.

<img src="/assets/gpo_gpc.png" width="600">

---

### Software installeren via GPO

- **Enkel via .msi-installaties**  
- Beschikbaar maken via een netwerkshare met leesrechten.  

#### Installatiemethoden:
1. **Assign**  
   - **Users**: Installatie van het programma gebeurt zodra de gebruiker op de snelkoppeling klikt.  
   - **Computer**: Automatische installatie na een herstart.

2. **Publish**  
   - **Users**: Het programma kan worden geïnstalleerd via het configuratiescherm of (instelbaar) als de gebruiker een bestand probeert te openen dat aan de applicatie is gekoppeld.  
   - **Computer**: Publish is niet mogelijk.

**Central Storage**

We maken een Central storage for Administrative Templates (.admx) voor group policies. We maken een folder aan PolicyDefinitions op de locatie 
C:/windows/SYSVOL/sysvol/ZJLocal.test/policies

We downloaden de nieuwste templates voor Windows 10 en zorgen ook dat onze machines op de laatste updates zitten.
Het is belangrijk om ook de language files erbij te hebben.

## AGDLP


## Kerberos

Kerberos is een beveiligingsprotocol. Het is een protocol waarbij het mogelijk is om te communiceren over een onveilig n
### Group Policy Loopback Processing Mode

Met de **Group Policy Loopback Processing Mode** kun je gebruikersconfiguratie-instellingen toepassen op een computerobject. Dit is handig in scenario’s zoals:

- **Kiosk-machines**: Computers in openbare ruimtes waar gebruikersinstellingen moeten worden toegepast, ongeacht wie inlogt.

#### Modes

1. **Merge Mode**  
   - Eerst worden de normale user policies toegepast bij de gebruiker die inlogt.  
   - Daarna worden de user configuration-instellingen toegepast die op het computerobject van toepassing zijn.  
   - Bij conflicterende instellingen heeft de instelling van het computerobject prioriteit.

2. **Replace Mode**  
   - Instellingen voor de gebruiker worden genegeerd bij het inloggen.  
   - Alleen de user configuration-instellingen van GPO’s die op het computerobject zijn toegepast, gelden.

**Let op:**  
LBM (Loopback Mode) is een instelling die geldt voor de hele computer.  
- Zodra LBM is ingesteld via één GPO, geldt deze voor de hele computer en dus voor elke gebruiker die zich aanmeldt op de computer.

<img src="/assets/gpo_gpc.png" width="600">

---

### Software installeren via GPO

- **Enkel via .msi-installaties**  
- Beschikbaar maken via een netwerkshare met leesrechten.  

#### Installatiemethoden:
1. **Assign**  
   - **Users**: Installatie van het programma gebeurt zodra de gebruiker op de snelkoppeling klikt.  
   - **Computer**: Automatische installatie na een herstart.

2. **Publish**  
   - **Users**: Het programma kan worden geïnstalleerd via het configuratiescherm of (instelbaar) als de gebruiker een bestand probeert te openen dat aan de applicatie is gekoppeld.  
   - **Computer**: Publish is niet mogelijk.

**Central Storage**

We maken een Central storage for Administrative Templates (.admx) voor group policies. We maken een folder aan PolicyDefinitions op de locatie 
C:/windows/SYSVOL/sysvol/ZJLocal.test/policies

We downloaden de nieuwste templates voor Windows 10 en zorgen ook dat onze machines op de laatste updates zitten.
Het is belangrijk om ook de language files erbij te hebben.

## AGDLP

etwerk met een partner die niet altijd betrouwbaar is. Er wordt een derde partij vertrouwd door zowel client 1 als client 2, terwijl ze elkaar onderling niet vertrouwen. **Er worden geen wachtwoorden gestuurd over het netwerk.**

- **Open standaard**: RFC4120  
- **Werkt met tickets**

---

### **Onderdelen**

1. **KDC (Key Distribution Center)**  
   - **AS (Authentication Service)**  
   - **TGS (Ticket Granting Service)**  

2. **SP (Security Principal)**  
   - Gebruikers, groepen of computers die worden herkend door het beveiligingssysteem.  

3. **TGT (Ticket Granting Ticket)**  
   - Een ticket, beperkt in tijd, om services te verkrijgen via de TGS.  
   - Enkel leesbaar door de KDC en uitgegeven door de AS.  
   - Bevat een User Access Token met o.a. de groepen waartoe de gebruiker behoort.  

4. **Session Key**  
   - Een tijdelijke sleutel om communicatie met een domeincontroller (DC) te beveiligen.  

---

### **Kerberos Process**

#### Stap 1: Authenticatie bij de KDC (AS)
1. Een **AS-REQ (Authentication Service Request)** wordt gestuurd naar de Authentication Service.  
   Dit bevat:  
   - Gebruikersnaam  
   - Clienttijd  
   - Geëncrypteerd met de hash van het gebruikerswachtwoord.  

2. De AS decrypt de aanvraag met de hash van het gebruikerswachtwoord uit Active Directory.  

3. Een **AS-REP (Authentication Service Reply)** wordt teruggestuurd.  
   Dit bevat:  
   - Session Key  
   - TGT (Ticket Granting Ticket)  
   - Geldigheidsduur van het ticket  

<img src="/assets/kerberos_1.png" width="600">

---

#### Stap 2: Aanvragen van een service bij de KDC (TGS)
1. Een **TGS-REQ (Ticket Granting Service Request)** wordt gestuurd naar de TGS.  
   Dit bevat:  
   - **Service Principal Name (SPN)**: Unieke identificatie van de service die de gebruiker wil raadplegen.  
   - **TGT**: Om aan te tonen dat de gebruiker al geauthenticeerd is.  

2. De TGS stuurt een **TGS-REP (Ticket Granting Service Reply)** terug.  
   Dit bevat:  
   - **Service Ticket**:  
     - Wordt gepresenteerd aan de service om toegang te krijgen.  
     - Niet leesbaar door de client.  
     - Beperkt bruikbaar in tijd.  

<img src="/assets/kerberos_2.png" width="600">

---

#### Stap 3: Toegang tot de service
1. Een **AP-REQ (Application Request)** wordt gestuurd naar de service.  
   Dit bevat:  
   - **Service Ticket**  

2. De service stuurt een **AP-REP (Application Reply)** terug.  
   - Omdat de KDC een vertrouwde derde partij is, vertrouwt de server het ticket en geeft toegang tot de service.  
   - Optioneel: Verificatie van de authenticatie.

<img src="/assets/kerberos_3.png" width="600">

---

## ADSI Edit 

**ADSI Edit** is een krachtig hulpmiddel voor geavanceerd beheer en probleemoplossing van Active Directory. Het stelt beheerders in staat om taken uit te voeren die niet mogelijk zijn met standaardtools zoals Active Directory Gebruikers en Computers (ADUC).

<img src="/assets/adsi_edit.png" width="600">

### Veelvoorkomende toepassingen:
1. **Handmatige wijzigingen**
2. **Corrigeren of verwijderen van corrupte objecten**
3. **Beheren van verborgen of geavanceerde attributen**
4. **Configuratieaanpassingen voor specifieke services**  

**Let op:** Wijzigingen in ADSI Edit zijn direct en onomkeerbaar.

---

## Replicatie

Active Directory (AD)-replicatie zorgt ervoor dat wijzigingen in AD automatisch worden gesynchroniseerd tussen domeincontrollers (DC's).  

### Belangrijke kenmerken:
- **Synchronisatie van de AD-database**:  
  Alleen gewijzigde attributen worden doorgestuurd bij toevoegingen, aanpassingen of verwijderingen van objecten.
- **Multimaster-replicatie**:  
  Elke DC kan wijzigingen aanbrengen in de domeinpartitie, wat zorgt voor fouttolerantie.

---

## Componenten binnen replicatie

### Multimaster Replication
- Elke DC kan wijzigingen (**originating updates**) ontvangen.
- **Voordeel**: Fouttolerantie, omdat niet één enkele DC verantwoordelijk is voor directory-taken.

### Pull Replication
- **Uitleg**: DC's vragen (pull) alleen de wijzigingen op die ze nodig hebben, in plaats van dat wijzigingen automatisch worden gepusht. Bij een wijziging informeert een DC zijn replicatiepartners.
- **Voordeel**: Vermindert onnodig netwerkverkeer.

### Store-and-Forward Replication
- **Uitleg**: Elke DC communiceert met een beperkte set andere DC's in plaats van met alle DC's.
- **Voordeel**: De replicatielast wordt verdeeld over meerdere DC's.

### State-Based Replication
- **Uitleg**: Elke DC houdt een replicatie-update bij (zijn state) en vergelijkt deze met andere DC's.
- **Voordeel**: Vermindert conflicten en onnodige replicaties.

## Convergentie

Convergentie betekent dat alle objecten uiteindelijk dezelfde waarden hebben voor alle attributen. Dit proces vindt plaats na een bepaalde tijd. Tot die tijd kan er een verschil bestaan tussen de databases van DC's, wat bekend staat als **loose consistency**.

## Update Sequence Number (USN)

Een **USN** is een 64-bit nummer dat bij elke wijziging (transactie) wordt verhoogd.
- **Voorbeeld**: DC A heeft een USN van 1000. Tien minuten later is de USN 1056, wat betekent dat er 56 transacties hebben plaatsgevonden.
- **Belangrijk**:  
  - Een USN kan alleen omhoog gaan, nooit omlaag.
  - Elke DC heeft een eigen, onafhankelijke USN-nummering.
  - De huidige USN staat in het `highestCommittedUSN`-attribuut van het `rootDSE`-object.

**Commando om de huidige USN te bekijken:**
```powershell
Get-ADRootDSE -Server dc1.zjlocal.test
```

## Metadata van objecten

Elk object bevat de volgende attributen:
- **usnCreated**: De USN op het moment dat het object werd aangemaakt.
- **usnChanged**: De USN op het moment dat het object voor het laatst werd gewijzigd.

Daarnaast houdt elk attribuut metadata bij, zoals:
- **Local USN**: De USN van de DC op het moment dat de wijziging plaatsvond.
- **Originating USN**: De USN van de DC waar de wijziging oorspronkelijk plaatsvond.

Deze metadata, ook wel de "stamp" genoemd, wordt gebruikt om conflicten op te lossen.

## Replicated Update

Wanneer een wijziging wordt binnengehaald door een DC, spreken we van een **replicated update**.

## Replicatie Topologie

### Site
Een site bestaat uit een of meerdere subnetten.
- Verzameling van goed geconnecteerde subnetten.
- Binnen een site snelle verbinding tussen DC's.
- Een site gebruik je om logische collecties te maken waartussen je replicatieafspraken vastlegt.
- Helpt clients om de dichtstbijzijnde bron te vinden voor bepaalde services.

Het is mogelijk om:
- Verschillende domeinen te hebben binnen één site.
- Meerdere sites te hebben binnen één domein.

### Intrasite Replication
- Tussen DC's in dezelfde site.
- Binnen 15 seconden na een wijziging.
- Gebruikt RPC.

### Intersite Replication
- Tussen DC's in verschillende sites.
- Tussen **bridgehead** servers.
- Gebruikt RPC.
- Standaard interval: 3 uur (minimum 15 minuten).

### Site Link
Een **Site Link** is een softwarematige set van instellingen die een replicatieverbinding configureert:
- Bepaalt welke sites geconnecteerd zijn en de **cost** van verbindingen.
- Instellingen zoals **schedule, replication period/interval** en **cost**.
- Configuratie via **AD Sites and Services** → Sites → Inter-Site Transports → IP.

## Replicatie RODC (Read-Only Domain Controller)
Een **RODC** is een read-only domain controller:
- Houdt een **read-only kopie** van de database bij **zonder wachtwoorden**.
- Er kunnen op de RODC zelf **geen instellingen** worden gewijzigd.
- Speciale **Administrator-rol** voor beheer.

Gebruik in **risicovolle omgevingen** zoals:
- DMZ
- Externe vestigingen

**Beveiligingsmaatregelen:**
- **PRP (Password Replication Policy)**: Bepaalt welke objecten hun wachtwoord kunnen laten cachen.
- Filteren van welke attributen gerepliceerd mogen worden.

   **Replicatie Tools**
- **Active Directory Replication Status Tool**
- **Repadmin**

## FSMO Rollen

Active Directory is **multimaster**, maar sommige taken vereisen één specifieke master.

### Forest-wide rollen
#### Schema Master
- Kan wijzigingen aan het **Schema** doorvoeren.
- Het schema bepaalt welke objecten en attributen bestaan in het forest.

#### Domain Naming Master
- Beheert wijzigingen aan de **forest-wide namespace**.
- Toevoegen/verwijderen van domeinen.
- Verplaatsen of hernoemen van een domein.

### Domain-wide rollen
#### PDC Emulator
- Compatibiliteit met oude NT4 en oudere clients.
- Bevat de **laatste wachtwoordwijzigingen**.
- **Primaire tijdserver**.

#### Infrastructure Master
- Beheert links met domeinobjecten uit andere domeinen.
- Vertaalt **GUIDs, SIDs en DNs** tussen domeinen.
- Verantwoordelijk voor updates van **multi-domein objecten**.

#### RID Master
- Elke security principal krijgt een unieke **SID**.
- De **RID Master** beheert en verdeelt **RID-pools** naar DC's.
- DC's krijgen **blokken van 500 RID's** voor nieuwe objecten.

### Global Catalog (GC)
Soms de **6e FSMO-rol** genoemd.
- De **eerste DC** van een forest is verplicht een **GC**.
- Andere DC's kunnen ook een **GC-kopie** bijhouden.

**Functies:**
- Bevat **forest-wide informatie**.
- Bevat **Universal Group Memberships**.
- Nodig voor **UPN-logins** (logonName@DNSDomainName).


<img src="/assets/UPNLogin.png" width="600">

## Back-up Windows Server

### AD Recycle Bin
- Mogelijkheid om verwijderde objecten te herstellen.

### Windows Server Backup
#### Full Server Backup
- Volledige herstelmogelijkheid op dezelfde of andere machine.

#### System State Backup
- Herstelt systeem en applicatiegegevens op dezelfde machine.
- **Authoritative Restore**: Overschrijft andere DC's met herstelde data.
- **Non-Authoritative Restore**: Laat andere DC's data bijwerken via replicatie.

---
