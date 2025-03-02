## Windows Services

Services zijn een belangrijk component van het Windows operating system. Ze zorgen voor creatie en beheer van long-running processes.
Ze kunnen automatisch gestart worden bij system boot zonder dat er user input nodig is. Ze kunnen verder draaien in de achtergrond zelfs als de user van zijn account uitlogd.

Er kunnen ook applicaties gemaakt worden om geinstalleerd te worden als een service. Een goed voorbeeld hiervan is een netwerk-monitoring applicatie. Services op windows zijn verantwoordelijk voor veel functies binnen Windows zoals, netwerk functies, systeem diagnosis , managing user credentials , Windows updates en nog veel meer.

Windows services worden beheerd via het Service Control Manager (SCM) system toegankelijk via services.msc
Dit zorgt voor een GUI interface om met services te managen. Het toont ook informatie for elk geinstalleerde service. Deze informatie bevat onder andere 
Name, Description, Status, Startup Type, en de user waar de service onder draait.

Er zijn bepaalde kritieke services in Windows die niet kunnen gestopt worden en ook niet gerestart zonder een system reboot. Als we een bestand of een rescource in gebruik bij een van deze services moeten we het systeem herstarten.

**Processes**

Processen runnen in de background by een Windows Systeem. Ze runnen of automatisch als onderdeel van het windows systeem of worden gestart door andere applicaties.

**Local Security Authority Subsystem Service (LSASS)**

lsass.exe is het process dat verantwoordelijk is voor het forceren van security policy op Windows Systems.

Wanneer een gebruiker probeert in te loggen verifieert het process de login poging en maakt hij een access token op basis van de user permissions.

Alle acties gerelateerd aan login, logout pogingen worden gelogd in de Windows Security Log. Dit is een enorm high value target.

**Sysinternals Tools**

Is een Tools Suite met een set van draagbare windows applicaties dat gebruikt kan worden om Windows systemen te beheren. Je kan ze via de Microsoft website downloaden of rechtstreeks in je explorer invoeren.

\\live.sysinternals.com\tools

**Task Manager**

Is een belangrijke tool voor het beheren van je windows systeem.
Het geeft je informatie over processen, systeem performance, startup progammas , users , services.
ctrl + alt + del

**Service Permissions**

Services die het beheer van langlopende processen mogelijk maken zijn een cruciaal onderdeel van het Windows-besturingsysteem. Systeembeheerders negeren ze vaak als potentiele aanvalsrisico's

Hierdoor kunne ze worden gebruikt om schadelijke DLL's te laden of toepassingen uit te voeren zonder beheerdersrechten, privileges te escaleren en persistentie te behouden.

Dit onstaat vaak door verkeerde configuraties door software van derde of door fouten van beheerders tijdens het installatieprocess.

Het erkennen van het belang van permissies is cruciaal en zeker voor netwerkservices zoals DHCP en AD domain services.

Best practice is om een service account te gebruiken voor alle netwerkgerelateerde services.

We moeten ook aandacht besteden aan servicepermissies en de rechten van de mappen waaruit ze worden uitgevoerd, omdat het mogelijk is om het pad naar een uitvoerbaar bestand te vervangen door een kwaadaardige DLL of uitvoerbaar bestand

**Examining Services using services.msc**

In voorgaande hoofdstuk hebben we gezien dat we services.msc kunnen gebruiken om services te bekijken en te beheren. We gaan dieper kijken naar de service wuauserv (Windows Update)

<img src="/assets/service_properties.webp" alt="share" width="600">

De naam van de service leren kennen is handing als je met command-line tools werkt om services te managen. 
Het pad naar de uitvoerbare file is het volledige pad naar het programma en het commando dat wordt uitgevoerd wanneer de service start.

Als de NTFS permissies van de target directory geconfigureerd zijn met zwakke permissies zou een aanvaller een orginele exe kunnen vervangen door een kwaadaardige.

<img src="/assets/logon.png" alt="share" width="600">

De meeste services runnen standaard met LocalSystem privileges wat het hoogste level van access mogelijk is op een individuele Windows OS. 

Niet alle applicaties hebben deze permissies nodig. Je moet goed onderzoeken op een case-by-case basis wanneer je nieuwe applicaties in Windows installeerd. 
Gebruik altijd het principe van least privilege.

Notable built-in service accounts in Windows:

Belangrijke built-in service accounts :
- LocalService
- NetworkService
- LocalSystem

We kunnen ook accounts maken met als enige doel het draaien van een service.

<img src="/assets/recovery_screen.webp" alt="share" width="600">

De recovery tab zorgt ervoor dat je stappen can configureren die moeten worden genomen als een service faalt.

**Examining services using sc**

C:\Users\htb-student>sc qc wuauserv
[SC] QueryServiceConfig SUCCESS

```plaintext
SERVICE_NAME: wuauserv
    TYPE               : 20  WIN32_SHARE_PROCESS
    START_TYPE         : 3   DEMAND_START
    ERROR_CONTROL      : 1   NORMAL
    BINARY_PATH_NAME   : C:\WINDOWS\system32\svchost.exe -k netsvcs -p
    LOAD_ORDER_GROUP   :
    TAG                : 0
    DISPLAY_NAME       : Windows Update
    DEPENDENCIES       : rpcss
    SERVICE_START_NAME : LocalSystem
```

The sc qc command word gebruikt om een query te sturen naar de service. Hier is het handig om de naam van de services te weten.
Als we een query willen uitvoeren op een service over het netwerk kunnen we ook hostname & IP address na het sc commando

```
C:\Users\htb-student>sc \\hostname or ip of box query ServiceName
```

We kunnen sc ook gebruiken om services te starten of te stoppen.

C:\WINDOWS\system32> sc config wuauserv binPath=C:\Winbows\Perfectlylegitprogram.exe

[SC] ChangeServiceConfig SUCCESS

C:\WINDOWS\system32> sc qc wuauserv

[SC] QueryServiceConfig SUCCESS

```plaintext
SERVICE_NAME: wuauserv
    TYPE               : 20  WIN32_SHARE_PROCESS
    START_TYPE         : 3   DEMAND_START
    ERROR_CONTROL      : 1   NORMAL
    BINARY_PATH_NAME   : C:\Winbows\Perfectlylegitprogram.exe
    LOAD_ORDER_GROUP   :
    TAG                : 0
    DISPLAY_NAME       : Windows Update
    DEPENDENCIES       : rpcss
    SERVICE_START_NAME : LocalSystem
```

Als we een situatie onderzoeken bij een systeem waar we een vermoeden van malware zou sc ons de mogelijkheid geven om snel de meest targeted services te onderzoeken en kijken welke nieuwe services er gemaakt zijn. Dit is meer script vriendelijk dan een GUI tool zoals services.msc

We kunnen ook service permissies bekijken door het sdshow commando.

```
C:\WINDOWS\system32> sc sdshow wuauserv

D:(A;;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)S:(AU;FA;CCDCLCSWRPWPDTLOSDRCWDWO;;;WD)
```
Op het eerste zicht lijkt de outpu thelemaal gek. Het lijkt zelfs of we iets fout hebben gedaan met het comando. Maar er is een betekenis in deze schijnlijke willekeurige letters.
Elk named object in windows is een securable object, en sommige unnamed objects zijn securable.

Als iets securable is in Windows OS heeft het een security descriptior. 

Deze bepalen de ownership en de primaire groep. 
DACL & SACL

DACL word gebruikt om de toegang tot een object te controleren.
SACL word gebruikt om access attempts te loggen. 

D:(A;;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)

This amalgamation of characters crunched together and delimited by opened and closed parentheses is in a format known as the Security Descriptor Definition Language (SDDL).

We kunnen in de verleiding komen om van links naar rechts te lezen, omdat dat is hoe onze taal doorgaans wordt geschreven. Maar bij interactie met computers kan dit heel anders zijn. Lees de volledige beveiligingsdescriptor voor de Windows Update-service (wuauserv) in deze volgorde, beginnend met de eerste letter en de reeks haakjes:

```
D: (A;;CCLCSWRPLORC;;;AU)

D: de volgende tekens vertegenwoordigen DACL-machtigingen (Discretionary Access Control List).
AU: definieert de beveiligingsprincipal Authenticated Users (geverifieerde gebruikers).
A;; toegang is toegestaan.
CC - SERVICE_QUERY_CONFIG: Hiermee kan de serviceconfiguratie worden opgevraagd bij de Service Control Manager (SCM).
LC - SERVICE_QUERY_STATUS: Hiermee kan de huidige status van de service worden opgevraagd bij de SCM.
SW - SERVICE_ENUMERATE_DEPENDENTS: Hiermee wordt een lijst met afhankelijke services opgevraagd.
RP - SERVICE_START: Hiermee kan de service worden gestart.
LO - SERVICE_INTERROGATE: Hiermee wordt de huidige status van de service opgevraagd.
RC - READ_CONTROL: Hiermee kan de beveiligingsdescriptor van de service worden opgevraagd.
Wanneer we de beveiligingsdescriptor lezen, kan het gemakkelijk zijn om de volgorde van tekens willekeurig te vinden. Maar onthoud dat we in feite toegangcontroles bekijken binnen een toegangcontrolelijst. Elke set van twee tekens tussen de puntkomma's vertegenwoordigt acties die mogen worden uitgevoerd door een specifieke gebruiker of groep.
```

;;CCLCSWRPLORC;;;
Na de laatste set puntkomma's worden de tekens gebruikt om de beveiligingsprincipal te specificeren (de gebruiker of groep die deze acties mag uitvoeren).
;;;AU
Het teken direct na de openingshaakjes en vóór de eerste set puntkomma’s bepaalt of de acties zijn toegestaan of geweigerd.

A;;
Deze volledige beveiligingsdescriptor die is gekoppeld aan de Windows Update-service (wuauserv) bevat drie sets toegangcontrole-items, omdat er drie verschillende beveiligingsprincipals zijn. Elke beveiligingsprincipal heeft specifieke machtigingen toegewezen gekregen.


Using the Get-Acl PowerShell cmdlet, we can examine service permissions by targeting the path of a specific service in the registry.


PS C:\Users\htb-student> Get-ACL -Path HKLM:\System\CurrentControlSet\Services\wuauserv | Format-List

Merk op hoe dit commando specifieke accountmachtigingen retourneert in een gemakkelijk leesbaar formaat en in SDDL. Ook is de SID die elke beveiligingsprincipal (Gebruiker en/of Groep) vertegenwoordigt, aanwezig in de SDDL. Dit is iets wat we niet krijgen wanneer we sc uitvoeren vanuit de opdrachtprompt.


