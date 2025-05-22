## FSMO


AD is gebaseerd op het Multimaster principe.
Dit betekent dat elke read-write DC (RWDC) de database waarden kan aanpassen. DNS servers komen overeen met het single-master principe waarbij enkel de primary DNS server aanpassingen kan doen aan de Database.

Je zou denken dat elke DC in een domein gelijkwaardig is (multimaster) en dat het uitvallen van een DC geen probleem is gezien je als goede systeembeheerder hebt gezorgd dat er nog andere DC's draaien. 
Dit is niet zo en sommige zaken moeten binnen AD geregeld worden als een singlemaster systeem. In dit geval zal de AD een server aanduiden die de master is van deze role.

Een dergelijke server noemen we een Flexible Single Master Operator of FSMO. 
Bij default worden de 5 rollen geinstalleerd op de eerste DC van je Forest. Indien je hier zelf niet aankomt blijft dit meestal wel zo.


### FSMO Rollen

Active Directory is **multimaster**, maar sommige taken vereisen één specifieke master.

### Forest-wide rollen
#### Schema Master
- Kan wijzigingen aan het **Schema** doorvoeren.
- Het schema bepaalt welke objecten en attributen bestaan in het forest.
- Is uniek in het Forest (kan maar 1x voorkomen)

#### Domain Naming Master
- Beheert wijzigingen aan de **forest-wide namespace**.
- Toevoegen/verwijderen van domeinen.
- Verplaatsen of hernoemen van een domein.
- Uniek in het Forest

### Domain-wide rollen
#### PDC Emulator
- Compatibiliteit met oude NT4 en oudere clients.
- Bevat de **laatste wachtwoordwijzigingen**.
- **Primaire tijdserver**.
- GPO wijzigingen worden uitgevoerd met deze rol
- Uniek binnen een domain

#### Infrastructure Master
- Beheert links met domeinobjecten uit andere domeinen.
- Vertaalt **GUIDs, SIDs en DNs** tussen domeinen.
- Verantwoordelijk voor updates van **multi-domein objecten**.
- Uniek binnen een domain

#### RID Master
- Elke security principal krijgt een unieke **SID**.
- De **RID Master** beheert en verdeelt **RID-pools** naar DC's.
- DC's krijgen **blokken van 500 RID's** voor nieuwe objecten.
- Uniek binnen een domain

Gezien elke DC binnen een domein beveiligingsgevoelige objecten met een unieke SID kan aanmaken, moet er een systeem bestaan dat voorkomt dat er twee keer dezelfde SID wordt uitgegeven. Hiervoor dient de RID Master. Deze bewaart een grote verzameling (pool) van unieke RID-waarden. Wanneer een DC wordt toegevoegd aan een domein, ontvangt deze DC van de RID Master een set van 500 RID-waarden uit deze pool.

Wanneer een DC minder dan 50% van zijn RID-waarden over heeft, vraagt hij automatisch een nieuwe set RID-waarden aan bij de RID Master.


### Global Catalog (GC)
Soms de **6e FSMO-rol** genoemd.
- De **eerste DC** van een forest is verplicht een **GC**.
- Andere DC's kunnen ook een **GC-kopie** bijhouden.

**Functies:**
- Bevat **forest-wide informatie**.
- Bevat **Universal Group Memberships**.
- Nodig voor **UPN-logins** (logonName@DNSDomainName).


<img src="/assets/UPNLogin.png" width="600">


#### Best Practice

**Single Forest Single Domain**  
Een single forest single domain omgeving met meerdere sites is een populair ontwerp binnen AD. In zo’n omgeving kan je al je FSMO-rollen op één DC houden. Zijn al je DC’s ook GC, dan kan je de Infrastructure Master ook op de DC met de GC-rol houden.

**Single Forest Multi Domain**  
De Schema Master en Domain Naming Master zijn forest-brede rollen en komen typisch in het forest root domain terecht. Qua computerkracht vergen deze rollen niet veel, omdat ze maar sporadisch gebruikt worden. De PDC Emulator is de rol die het meeste vergt (tijd synchronisatie, wachtwoordwijzigingen repliceren en GPO-wijzigingen beheren), dus deze plaats je best op de DC met de beste processorkracht. De RID Master plaats je best samen met de PDC Emulator. In een omgeving met meerdere domeinen is de cross-reference tussen objecten belangrijk. Stel dat er in domain A een wijziging gebeurt aan de naam van een user account en deze account wordt gebruikt binnen een ander account, dan moet deze wijziging doorgestuurd worden. De Infrastructure Master plaats je op een DC die geen GC is (indien niet elke DC in je forest ook GC is).


---