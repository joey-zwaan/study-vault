# General Security and Network Security Features

## Microsoft Defender for Cloud

Microsoft Defender for Cloud is een uitgebreide cloudbeveiligingsoplossing die helpt bij het beschermen van Azure-resources tegen bedreigingen. Het biedt geavanceerde beveiligingsfuncties zoals dreigingsdetectie, kwetsbaarheidsbeheer en nalevingsrapportage. Vroeger noemde het zich Azure Security Center.

### Network Security Groups (NSG's)

Network Security Groups (NSG's) zijn een fundamenteel beveiligingsmechanisme binnen Azure die netwerkverkeer naar en van Azure-resources regelen. NSG's bevatten regels die bepalen welk inkomend en uitgaand verkeer is toegestaan of geblokkeerd op basis van bron- en bestemmings-IP-adressen, poorten en protocollen. Ze kunnen worden toegepast op subnetten of individuele netwerkinterfaces van virtuele machines, waardoor een gelaagde beveiligingsaanpak mogelijk is. Het is eigenlijk een virtuele firewall op netwerkniveau.

## Key Vault

`Access Policies`: Met Key Vault kun je toegangsbeleid definiëren om te bepalen wie toegang heeft tot welke geheimen of sleutels. Dit helpt bij het afdwingen van het principe van de minste privilege. Je moet de permissies per Vault instellen. Of je kan RBAC gebruiken en dan is het granularer.


Azure Key Vault is een cloudgebaseerde beveiligingsservice voor het veilig opslaan en beheren van cryptografische sleutels, geheimen (zoals wachtwoorden, API-sleutels en connection strings) en certificaten. Het voorkomt dat gevoelige gegevens in code of configuratiebestanden terechtkomen. Applicaties kunnen deze gegevens opvragen via beveiligde API-calls of via Managed Identity, zodat er geen secrets hardcoded hoeven te worden. Key Vault ondersteunt security- en compliance-eisen dankzij auditing, toegangscontrole en lifecyclebeheer.

- **Keys**: voor encryptie, signing, key wrapping en integratie met services zoals Azure Storage Encryption of SQL TDE.  
- **Secrets**: wachtwoorden, tokens, API-sleutels, connection strings.  
- **Certificates**: beheer van SSL/TLS-certificaten, inclusief automatische vernieuwing.

### Toegangsbeheer

`Access Policies`: Per Key Vault definieer je welke identiteit welke acties mag uitvoeren op sleutels, geheimen of certificaten (bijv. *get*, *list*, *set*, *encrypt*, *import*).  

- Configuratie per individuele Key Vault  
- Minder granular  
- Klassiek model

### RBAC

Role-Based Access Control biedt fijnmazigere en gecentraliseerde machtigingen. Voorbeelden van rollen:

- *Key Vault Secrets User*  
- *Key Vault Crypto Officer*  
- *Key Vault Administrator*  

Voordelen:

- Toegang centraal via Azure RBAC  
- Consistenter beheer  
- Aanbevolen voor nieuwe implementaties

Applicaties authenticeren meestal via:

- **Managed Identity** (aanbevolen): geen secrets nodig; de identiteit krijgt direct toegang volgens RBAC of Access Policies.  
- **Service Principal**: gebruikt clientId + secret of certificate (oudere methode).

Voordelen:

- Geen gevoelige info in code  
- Versiebeheer en rotatie van secrets  
- Sterke auditing en toegangscontrole

### Wanneer Key Vault gebruiken

- Backend/API’s die secrets of certificaten nodig hebben  
- SSL/TLS-certificaatbeheer voor apps of containers  
- Encryptiesleutels voor data-at-rest (BYOK/HSM)  
- Omgevingen met strenge compliance-eisen (ISO, SOC, GDPR)

Dus je hebt een applicatie en je wilt toegang tot azure vault moet je de volgende stappen volgen:

1. Maak een Managed Identity aan voor je applicatie (bijv. een Azure Function, VM, App Service).
2. Ken de juiste rol toe aan die Managed Identity in Key Vault via RBAC of Access Policies.
3. In je applicatiecode, gebruik de Azure SDK om een token op te halen voor de Managed Identity.
4. Gebruik dat token om toegang te krijgen tot Key Vault en de benodigde geheimen, sleutels of certificaten op te halen.

## Microsoft Sentinel

### SIEM en SOAR (Microsoft Sentinel)

Microsoft Sentinel is een cloud-native SIEM (Security Information and Event Management) oplossing die beveiligingsdata centraliseert en analyseert. Het verzamelt loggegevens uit uiteenlopende bronnen, zoals identiteiten (Azure AD, Entra ID), applicaties, servers, firewalls, endpoints, cloudresources, SaaS-applicaties en on-premises systemen. Door deze data te correleren detecteert Sentinel afwijkend gedrag, misconfiguraties en potentiële aanvallen die anders onopgemerkt blijven.

Sentinel maakt gebruik van ingebouwde bedreigingsmodellen, machine learning en AI om risico’s te prioriteren. Dit helpt om te bepalen welke alerts echt kritisch zijn en welke minder urgent zijn. Analisten krijgen inzicht in aanvalspaden door middel van incidentcorrelatie en grafische weergaven van de aanvalsketen (Kill Chain / MITRE ATT&CK mapping). Dit versnelt triage, detectie en onderzoek.

Naast detectie ondersteunt Sentinel ook actieve verdediging via automatisering. Dit valt onder SOAR (Security Orchestration, Automation and Response). SOAR in Sentinel gebruikt playbooks die zijn gebouwd met Azure Logic Apps. Deze playbooks kunnen automatisch reageren op alerts zonder menselijke tussenkomst. Voorbeelden van geautomatiseerde acties zijn: het blokkeren van een verdacht account in Entra ID, het isoleren van een endpoint via Defender for Endpoint, het blokkeren van een IP in een firewall, het escaleren naar een SOC-team via Teams of e-mail, of het automatisch openen en bijwerken van tickets in systemen zoals ServiceNow en Jira.

Sentinel kan externe datastromen toevoegen via Data Connectors, zoals Microsoft 365, Azure workload logs, security appliances (bijvoorbeeld Palo Alto, Fortinet, Cisco), AWS CloudTrail of syslog vanuit Linux-servers. Met behulp van KQL (Kusto Query Language) kunnen analisten real-time queries uitvoeren voor hunting, incidentanalyse, anomaliedetectie en rapportage. Deze queries vormen de basis voor rules, dashboards en workbooks.
Hierdoor kan ik gaan hunting doen en proactief op zoek gaan naar bedreigingen in plaats van alleen te reageren op alerts. Sentinel biedt ook ingebouwde compliance-rapporten voor standaarden zoals GDPR, ISO 27001, NIST en HIPAA. Dit helpt organisaties om aan regelgeving te voldoen door beveiligingscontroles te monitoren en rapporteren.

## Azure Dedicated Host

Standaard is Azure multi-tenant, wat betekent dat jouw virtuele machines (VM's) op gedeelde fysieke servers draaien samen met VM's van andere klanten. Dit is kostenefficiënt en schaalbaar, maar sommige organisaties hebben strengere isolatie- of compliance-eisen.
Azure Dedicated Host biedt fysieke servers die exclusief aan jouw organisatie worden toegewezen. Dit betekent dat jouw workloads niet worden gedeeld met andere klanten, wat extra isolatie en controle biedt. Dedicated Hosts zijn ideaal voor organisaties met strenge compliance- of beveiligingseisen, omdat ze volledige controle hebben over de fysieke hardware waarop hun virtuele machines draaien. Dit wordt ook wel bare-metal hosting genoemd. 

`Host Fault Domains`: Binnen een Host Group kunnen Dedicated Hosts worden verdeeld over meerdere Fault Domains. Dit helpt bij het minimaliseren van de impact van hardwarestoringen door ervoor te zorgen dat VM's op verschillende fysieke servers worden geplaatst.
`Host Groups`: Een Dedicated Host wordt geplaatst binnen een Host Group, wat een logische container is voor één of meer Dedicated Hosts. Host Groups helpen bij het organiseren en beheren van Dedicated Hosts binnen een specifieke regio.
`FDI` (Fault Domain Isolation): Met Dedicated Hosts kun je VM's toewijzen aan specifieke Fault Domains binnen de host. Dit helpt bij het verbeteren van de beschikbaarheid door ervoor te zorgen dat VM's niet allemaal op dezelfde fysieke server worden geplaatst.

`Isolated vm types`: Sommige VM-groottes zijn zo groot dat je zeker bent dat ze niet gedeeld worden met andere klanten, zelfs in een multi-tenant omgeving. Deze VM-types bieden een vorm van isolatie zonder dat je een volledige Dedicated Host hoeft te gebruiken. Voorbeelden zijn de Mv2-serie (grote geheugenoptimaliseerde VM's) en de Esv3-serie (grote algemene doeleinden VM's).

## Beveiligingsstrategieën & beveiligingsoplossingen

Defence in Depth is een beveiligingsstrategie die meerdere lagen van verdediging implementeert om systemen en gegevens te beschermen. In de context van Azure Dedicated Host betekent dit dat je niet alleen vertrouwt op fysieke isolatie, maar ook aanvullende beveiligingsmaatregelen neemt, zoals netwerkbeveiliging, toegangsbeheer, encryptie en monitoring. Dit zorgt ervoor dat als één laag wordt doorbroken, er nog steeds andere lagen zijn die bescherming bieden tegen bedreigingen.

Er zijn verschillende lagen van beveiliging die je kunt implementeren als onderdeel van een Defence in Depth-strategie:

- Data: Encryptie van gegevens in rust en tijdens overdracht.
- Application: Beveiliging van applicaties door middel van veilige codering, regelmatige updates en patching.
- Compute: Beveiliging van virtuele machines en containers met firewalls, endpointbeveiliging en regelmatige updates.
- Network: Gebruik van Network Security Groups (NSG's), firewalls en virtuele netwerksegmentatie om netwerkverkeer te controleren en te beperken.
- Perimeter: Beveiliging van de rand van je netwerk met firewalls, DDoS-bescherming en VPN's.
- Identity en Access Management: Implementatie van sterke authenticatie- en autorisatiemechanismen, zoals Multi-Factor Authentication (MFA) en Role-Based Access Control (RBAC).
- Physical: Fysieke beveiliging van datacenters en hardware, inclusief toegangscontrole en bewaking.

`Zero trust`: Een belangrijk concept binnen Defence in Depth is het Zero Trust-principe, waarbij geen enkele entiteit, zowel binnen als buiten het netwerk, automatisch wordt vertrouwd. Toegang wordt alleen verleend op basis van strikte verificatie en autorisatie, ongeacht de locatie van de gebruiker of het apparaat.

### Zero Trust

Zero Trust is een beveiligingsmodel dat uitgaat van het principe "nooit vertrouwen, altijd verifiëren". In plaats van automatisch vertrouwen te schenken aan gebruikers of apparaten binnen het netwerk, vereist Zero Trust dat elke toegangspoging strikt wordt geverifieerd en gevalideerd, ongeacht de locatie van de gebruiker of het apparaat.

Belangrijke principes van Zero Trust zijn onder andere:

- **Verify explicitly**: Elke toegangspoging moet worden geverifieerd op basis van meerdere factoren, zoals gebruikersidentiteit, apparaatstatus, locatie en het type toegang dat wordt aangevraagd.
- **Least privilege access**: Gebruikers en apparaten krijgen alleen de minimale toegangsrechten die nodig zijn om hun taken uit te voeren. Dit beperkt de potentiële schade bij een beveiligingsinbreuk.
- **Assume breach**: Het model gaat ervan uit dat het netwerk al is gecompromitteerd, waardoor voortdurende monitoring en analyse van activiteiten essentieel zijn om verdachte gedraging te detecteren.

We hebben 3 belangrijke pijlers binnen Zero Trust:

- **Identity**: Sterke authenticatie- en autorisatiemechanismen, zoals Multi-Factor Authentication (MFA) en Role-Based Access Control (RBAC).
- **Endpoint**: Beveiliging van apparaten met endpointbeveiligingsoplossingen, zoals Defender for Endpoint.
- **Network**: Gebruik van Network Security Groups (NSG's), firewalls en virtuele netwerksegmentatie om netwerkverkeer te controleren en te beperken.

### NSG

Een **Network Security Group (NSG)** in Azure bepaalt welk
netwerkverkeer is toegestaan of geblokkeerd. Elke NSG-regel bevat
eigenschappen die bepalen **van waar naar waar** verkeer mag gaan, via
**welke poorten**, met **welk protocol**, en in **welke volgorde** de
regels worden toegepast.

- **Naam**: Een unieke naam voor de regel binnen de NSG.
- **Prioriteit**: Bepaalt de volgorde waarin regels worden geëvalueerd. Waarde tussen 100 -- 4096, waarbij een lagere waarde hogere prioriteit heeft. Zodra verkeer matcht met een regel, stopt de evaluatie.
- **Bron (Source)**: Het IP-adres, een IP-bereik, een Application Security Group (ASG) of een service tag van waar het verkeer afkomstig is. Kan ook `Any` zijn.
- **Bronpoortbereik (Source Port Range)**: De poort of het poortbereik aan de bronzijde. Meestal `Any`, omdat clients willekeurige uitgaande poorten gebruiken.
- **Bestemming (Destination)**: Het IP-adres, een IP-bereik, een ASG of service tag waar het verkeer naartoe gaat. Kan ook `Any` zijn.
- **Bestemmingspoortbereik (Destination Port Range)**: De poort of het poortbereik aan de doelzijde, zoals `80`, `443`, `8000-9000` of `Any`.
- **Protocol**: Het netwerkprotocol dat de regel moet evalueren: `TCP`, `UDP`, `ICMP` of `Any`.
- **Actie (Action)**: Bepaalt of verkeer wordt toegestaan (`Allow`) of geblokkeerd (`Deny`).
- **Richting (Direction)**: Geeft aan of de regel van toepassing is op **Inbound** verkeer of **Outbound** verkeer.
- **Beschrijving (Description)**: Een optionele tekstuele uitleg van de regel.
- **Service Tag**: Vooraf gedefinieerde netwerkgebieden zoals `Internet`, `VirtualNetwork`, `AzureLoadBalancer`, `Storage`, `AppService`.

> Het zijn een set van regels die bepalen welk netwerkverkeer is toegestaan of geblokkeerd naar Azure-resources. Ze helpen bij het implementeren van beveiligingsmaatregelen zoals Zero Trust door alleen het noodzakelijke verkeer toe te staan en ongeautoriseerd verkeer te blokkeren.
> Het is mogelijk aan een NIC toe te wijzen maar dan maak je het moeilijker om te beheren. Het is beter om het op subnet niveau te doen zodat alle VM's in dat subnet dezelfde regels hebben.
> Deze is op laag 4 (Transportlaag) van het OSI-model. Het kijkt naar IP-adressen en poorten.

### Azure Firewall

Azure Firewall is een first party network application firewall service die volledig beheerd wordt door Azure. Het begrijpt alle laag 7 protocollen (Application Layer) en kan dus veel gedetailleerder filteren dan een NSG. Het kan bijvoorbeeld HTTP-verkeer inspecteren en filteren op URL-patronen, domeinen, HTTP-methoden (GET, POST, etc.) en zelfs op basis van inhoud in de payload. Dit maakt het mogelijk om zeer specifieke beveiligingsregels toe te passen die verder gaan dan alleen IP-adressen en poorten. Het heeft een basis begrip van Layer 4 (Transport Layer) protocollen zoals TCP en UDP, maar de kracht van Azure Firewall ligt in zijn vermogen om diepgaande inspectie uit te voeren op Layer 7 (Application Layer) protocollen zoals HTTP, HTTPS, SQL, en meer.

Er zijn user-defined routes (UDR's) nodig om het verkeer naar de firewall te sturen. Dit betekent dat je in je route tabellen regels moet toevoegen die bepalen dat verkeer naar bepaalde bestemmingen via de Azure Firewall moet gaan. Zonder deze UDR's zal het verkeer niet automatisch naar de firewall worden geleid.

Je kan application rules, FQDN, catagories, network rules, 

Premium Azure Firewall heeft extra functies zoals TLS-inspectie, IDPS (Intrusion Detection and Prevention System), URL-filtering op basis van categorieën, en integratie met Microsoft Defender for Cloud voor geavanceerde bedreigingsdetectie. Deze functies bieden een diepere beveiligingslaag door het verkeer te inspecteren op kwaadaardige activiteiten, ongeacht of het verkeer versleuteld is of niet. Dnetting 

### Azure DDoS Protection

Er zijn veel verschillende DDoS aanvallen, ze zijn gemaakt om je netwerk neer te halen door het te overspoelen met verkeer. Azure DDoS Protection helpt bij het beschermen van je Azure-resources tegen deze aanvallen door automatisch verdachte verkeerspatronen te detecteren en te mitigeren.

`Volumetrische aanvallen`: Deze aanvallen proberen je netwerk te overspoelen met een enorme hoeveelheid verkeer, zoals UDP-floods of ICMP-floods.
`Protocol-aanvallen`: Deze aanvallen richten zich op zwakke plekken in netwerkprotocollen, zoals SYN-floods of fragmentatie-aanvallen.
`Applicatie-aanvallen`: Deze aanvallen richten zich op specifieke applicaties of services.
Het punt is om de availability van de services neerer te halen door ze onbereikbaar te maken.

Bij Azure hebben we `Basic DDoS Protection` die automatisch is ingeschakeld voor alle Azure-resources zonder extra kosten. Dit biedt basisbescherming tegen veelvoorkomende volumetrische aanvallen. Deze is meer gemaakt om de Azure infrastructuur te beschermen & richt zich op hele grote aanvallen. Je kan het niet aanpassen, metrics zien of rapporten krijgen.

`Standard DDoS Protection` is een betaalde service die geavanceerdere bescherming biedt. Het biedt aangepaste mitigatie op basis van de specifieke behoeften van jouw applicaties, gedetailleerde rapportage en metrics, en integratie met Azure Monitor voor real-time waarschuwingen. Dit is meer gemaakt om jouw specifieke applicaties te beschermen tegen DDoS aanvallen. Het maakt gebruik van machine learning om te detecteren wat een normaal gebruikspatroon is en afwijkingen daarvan te mitigeren. Je kan hiermee ook SLA's krijgen voor beschikbaarheid tijdens een DDoS aanval, Je kan deze koppelen aan een virtueel netwerk (VNet) om alle resources binnen dat VNet te beschermen. Het kan zelfs aan meerdere VNets in dezelfde regio worden gekoppeld.


