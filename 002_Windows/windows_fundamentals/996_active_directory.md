## Wat is GPO?

Groepsbeleid (GPO) is een functie binnen Microsoft Windows waarmee beheerders instellingen centraal kunnen beheren en afdwingen binnen een netwerk.

### Belangrijke kenmerken:
- Centraal beheer van instellingen
- Configuratie-instructies
- Bewaard binnen o.a. Active Directory & SYSVOL
- Toepasbaar op computers of gebruikersaccounts

### Mogelijke instellingen:
Dit is geen volledige lijst, maar enkele voorbeelden van wat je kunt instellen met GPO:
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

#### Default Domain Policy
- Toegepast op alle gebruikers- en computeraccounts.
- Bevat instellingen zoals:
  - Wachtwoordbeleid
  - Accountvergrendeling
  - Kerberos-instellingen

#### Default Domain Controllers Policy
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
   - GPO’s toegepast binnen een Organisational Unit (OU)  
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

#### GPC (Group Policy Container)
- Bevat eigenschappen van de GPO, zoals versie-informatie en status.
- Wordt opgeslagen binnen Active Directory.  
  **Locatie:** `LDAP://CN{GUID},CN=Policies,CN=System,DC=zjlocal,DC=test`

<img src="/assets/GPC.png" width="600">

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

Kerberos is een beveiligingsprotocol. Het is een protocol waarbij het mogelijk is om te communiceren over een onveilig netwerk met een partner die niet altijd betrouwbaar is. Er wordt een derde partij vertrouwd door zowel client 1 als client 2, terwijl ze elkaar onderling niet vertrouwen. **Er worden geen wachtwoorden gestuurd over het netwerk.**

- **Open standaard**: RFC4120  
- **Werkt met tickets**

---

### **Onderdelen**

1. **KDC (Key Distribution Center)**  
   - **AS (Authentication Service)**  
   - **TGS (Ticket Granting Service)**  

2. **SP (Security Principal)**  
   Een entiteit herkend door het beveiligingssysteem, zoals:  
   - Gebruikers  
   - Groepen  
   - Computers  

3. **TGT (Ticket Granting Ticket)**  
   - Een ticket, beperkt in tijd, om services te verkrijgen via de TGS.  
   - Enkel leesbaar door de KDC en uitgegeven door de AS.  
   - Bevat een User Access Token met o.a. de groepen waartoe de gebruiker behoort.  

4. **Session Key**  
   - Een tijdelijke sleutel die je ontvangt om communicatie met een DC te beveiligen voor de sessie.  
   - Geen gebruikerswachtwoord meer nodig.  

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

## Tools

### ADSI EDIT 

*ADSI Edit** is een krachtig hulpmiddel voor geavanceerd beheer en probleemoplossing van Active Directory. Het stelt beheerders in staat om taken uit te voeren die niet mogelijk zijn met standaardtools zoals Active Directory Gebruikers en Computers (ADUC).


<img src="/assets/adsi_edit.png" width="600">

#### Veelvoorkomende toepassingen:
1. **Handmatige wijzigingen**:  
   Voer handmatige wijzigingen uit in Active Directory wanneer standaardtools zoals ADUC onvoldoende zijn.

2. **Corrigeren of verwijderen van corrupte objecten**:  
   Identificeer en corrigeer of verwijder corrupte objecten in de directory.

3. **Beheren van verborgen of geavanceerde attributen**:  
   Toegang tot en beheer van attributen die niet zichtbaar of bewerkbaar zijn in andere AD-tools.

4. **Configuratieaanpassingen voor specifieke services**:  
   Wijzig configuraties voor services zoals:  
   - Exchange Server  
   - Groepsbeleid  

***Let op: Wijzigingen in ADSI Edit zijn direct en onomkeerbaar***


## Replicatie

Active Directory (AD)-replicatie zorgt ervoor dat wijzigingen in AD, zoals gebruikers, wachtwoorden en groepsbeleid, automatisch worden gesynchroniseerd tussen domeincontrollers (DC's). Dit proces verschilt binnen sites (snel en frequent) en tussen sites (minder frequent om bandbreedte te besparen).

### Belangrijke kenmerken:
- **Synchronisatie van de AD-database**:  
  Alleen gewijzigde attributen worden doorgestuurd bij toevoegingen, aanpassingen of verwijderingen van objecten.
- **Multimaster-replicatie**:  
  Elke DC kan wijzigingen aanbrengen in de domeinpartitie, wat zorgt voor fouttolerantie.

---

### Componenten binnen replicatie

#### Multimaster Replication
- Elke DC kan wijzigingen (originating updates) ontvangen.
- **Voordeel**: Fouttolerantie, omdat niet één enkele DC verantwoordelijk is voor directory-taken.

#### Pull Replication
- **Uitleg**: DC's vragen (pull) alleen de wijzigingen op die ze nodig hebben, in plaats van dat wijzigingen automatisch worden gepusht. Bij een wijziging informeert een DC zijn replicatiepartners.
- **Voordeel**: Vermindert onnodig netwerkverkeer.

#### Store-and-Forward Replication
- **Uitleg**: Elke DC communiceert met een beperkte set andere DC's in plaats van met alle DC's.
- **Voordeel**: De replicatielast wordt verdeeld over meerdere DC's.

#### State-Based Replication
- **Uitleg**: Elke DC houdt een replicatie-update bij (zijn state) en vergelijkt deze met andere DC's.
- **Voordeel**: Vermindert conflicten en onnodige replicaties.

---

### Convergentie

Convergentie betekent dat alle objecten uiteindelijk dezelfde waarden hebben voor alle attributen. Dit proces vindt plaats na een bepaalde tijd. Tot die tijd kan er een verschil bestaan tussen de databases van DC's, wat bekend staat als **loose consistency**.

---

### Update Sequence Number (USN)

Een **USN** is een 64-bit nummer dat bij elke wijziging (transactie) wordt verhoogd.  
- **Voorbeeld**: DC A heeft een USN van 1000. Tien minuten later is de USN 1056, wat betekent dat er 56 transacties hebben plaatsgevonden.  
- **Belangrijk**:  
  - Een USN kan alleen omhoog gaan, nooit omlaag.  
  - Elke DC heeft een eigen, onafhankelijke USN-nummering.  
  - De huidige USN staat in het `highestCommittedUSN`-attribuut van het `rootDSE`-object.

**Commando om de huidige USN te bekijken**:  
```powershell
Get-ADRootDSE -Server dc1.zjlocal.test
```

---

### Metadata van objecten

Elk object bevat de volgende attributen:
- **usnCreated**: De USN op het moment dat het object werd aangemaakt.
- **usnChanged**: De USN op het moment dat het object voor het laatst werd gewijzigd.

Daarnaast houdt elk attribuut metadata bij, zoals:
- **Local USN**: De USN van de DC op het moment dat de wijziging plaatsvond.
- **Originating USN**: De USN van de DC waar de wijziging oorspronkelijk plaatsvond.

Deze metadata, ook wel de "stamp" genoemd, wordt gebruikt om conflicten op te lossen.

---

### Replicated Update

Wanneer een wijziging wordt binnengehaald door een DC, spreken we van een **replicated update**.

<img src="/assets/replicatie_process.png" width="600">