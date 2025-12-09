# Azure Core Services

## Regions

Azure verdeeld zijn datacenters over de hele wereld in verschillende regio's. Elke regio bestaat uit meerdere datacenters die dicht bij elkaar liggen.
Dit is om de latency te verminderen, hoe verder de data moet reizen hoe langer het duurt omdat het nog altijd een fysieke afstand moet afleggen. Het is sneller maar niet instant.

We hebben meerdere regio's voor de latency & ook voor de betrouwbaarheid. Als de ene data center uitvalt door een natuuramp of dergelijke kan een andere regio aan de andere kant van de wereld de service overnemen. Elke datacenter heeft een **REGIONAL PAIR** Ook als ik een applicatie met gebruikers maak die bijvoorbeeld gebruikers heeft in Europa & US dan moet ik ook een kopie maken in een datacenter in de regio zodat ze een goede ervaring hebben en geen vertragingen ondervinden.

Er zijn ook speciale overheidsregio's die voldoen aan strengere beveiligings- en compliance-eisen.

> German Cloud
> China Cloud
> US Cloud

### Availability Zones

Elke subscriptie krijgt 3 Availability zones per regio.
Een availability zone is een fysiek gescheiden locatie binnen een regio deze heeft zijn eigen stroom, netwerk en koeling. Per subscriptie kan het verschillend zijn aan welk fysiek locatie je toegewezen wordt. Dit is om je te beschermen tegen een datacenter level storing. Als een datacenter uitvalt in een regio kan een andere availability zone in dezelfde regio de service overnemen.

`Zone resources` zijn resources die specifiek zijn toegewezen aan een bepaalde availability zone.
`Zone-redundant resources` zijn resources die automatisch worden gerepliceerd over meerdere availability zones binnen dezelfde regio. Dit biedt een hogere beschikbaarheid en veerkracht tegen uitval van een enkele zone. Er is een automatische failover tussen de zones.

## Azure Cost Management

## Resource Groups

Een resource group is een container die gerelateerde Azure-resources groepeert. Dit maakt het eenvoudiger om resources te beheren. Het is een logische groepering, geen fysieke. Er kunnen resources uit verschillende regio's in dezelfde resource group zitten. Er kunnen ook verschillende types van resources in dezelfde resource group zitten. Er kan gebruik worden gemaakt van tags om resources binnen een resource group verder te categoriseren. Dit wordt niet automatisch toegepast op de resources binnen de resource group.

> Als je klaar bent met een project kan je de hele resource group verwijderen zodat alle resources in één keer verwijderd worden en er geen overbodige kosten meer gemaakt worden.

### Rescource Group management

Door rescource groups te gebruiken kan je het beheer van je rescources beter organiseren. Meestal als de rescources dezelfde levenscyclus hebben (bijvoorbeeld een applicatie en de bijbehorende database) is het makkelijk om zo Role based Access Control (RBAC) toe te passen op de hele groep in plaats van op individuele resources. Je kan ook eenvoudiger Policy's toepassen op een hele groep.
In een rescource group kan je ook een maximum budget instellen. Dit helpt om de kosten onder controle te houden en onverwachte uitgaven te voorkomen. Dit wordt automatisch toegepast ook op nieuwe resources die aan de groep worden toegevoegd.

### Rescource groups tags

Tags zijn labels die je kunt toewijzen aan Azure-resources en resource groups om ze te organiseren en categoriseren. Tags bestaan uit sleutel-waarde paren, bijvoorbeeld "Environment: Production" of "Department: Finance". Dit maakt het makkelijker om resources te vinden, beheren en rapporteren op basis van specifieke criteria. Tags worden niet inheerit door resources binnen een resource group, je moet ze afzonderlijk toepassen op elke resource als je dat wilt. Je kan het op een hele resource group toepassen maar dat betekent niet dat alle resources automatisch de tags krijgen.

### Azure resource manager (ARM)

Alles in Azure is een rescource. Als je een VM hebt dan zie je dat er meerdere resources zijn zoals de VM zelf, de schijf, het netwerk interface, het IP adres, etc. Zelfs een network-interface is een aparte rescource. De Azure Resource Manager (ARM) is de deployment en management service voor Azure. Het biedt een consistente manier om resources te creëren, bij te werken en te verwijderen. ARM gebruikt JSON-templates om de infrastructuur en configuratie van resources te definiëren. Dit maakt het mogelijk om infrastructuur als code te beheren, wat zorgt voor herhaalbaarheid en versiebeheer. Want als je alles via het portaal doet is het moeilijk om te weten wat je precies hebt gedaan en hoe je het later kan reproduceren.

Elke interactie met Azure, of het nu via de portal, CLI, PowerShell of SDK is, gaat via de Azure Resource Manager. ARM zorgt ook voor functies zoals toegangsbeheer, beleidstoepassing en resource-groepering.
Als je naar een rescource gaat kan je hem als template exporteren. Dit is een JSON bestand die je kan gebruiken om dezelfde rescource later opnieuw te maken.

Er is ook een nieuwe versie van ARM genaamd Bicep. Dit is een declaratieve taal die eenvoudiger te lezen en te schrijven is dan JSON. Bicep wordt uiteindelijk omgezet naar JSON-templates die door ARM worden gebruikt.

## Subscriptions

Een subscriptie kunnen we bekijken als een overeenkomst tussen jou en Microsoft om Azure-diensten te gebruiken. Het volgt een bepaald factureringsmodel, zoals pay-as-you-go of een maandelijks abonnement. Elke subscriptie heeft een uniek ID en is gekoppeld aan een account.

Azure gebruikt Azure Active Directory (AAD) voor het beheren van toegang tot resources binnen een subscriptie. Je kunt verschillende rollen en machtigingen toewijzen aan gebruikers en groepen om de toegang te beheren. Je kan een budget instellen en een policy toepassen om kosten te beheersen en naleving van regels te waarborgen.

### Meerdere Subscriptions

We kunnen verschillende subscripties hebben voor verschillende doeleinden, zoals ontwikkeling, testen en productie. Dit helpt bij het scheiden van omgevingen en het beheren van kosten. We kunnen ook subscripties gebruiken om verschillende projecten of teams binnen een organisatie te beheren. Op een test subscriptie gaan we meer rechten geven aan ontwikkelaars dan op een productie subscriptie.

> Rescource groups leven binnen een subscriptie. Je kan geen rescource group maken die meerdere subscripties omvat.

### Management groups

Management groups zijn containers die meerdere subscripties kunnen groeperen. Dit maakt het makkelijker om beleid en toegangsbeheer op grote schaal toe te passen. We kunnen hiërarchieën van management groups maken om verschillende niveaus van organisatie binnen een bedrijf weer te geven. Beleid en toegangsrechten die op een management group worden toegepast, worden automatisch geërfd door alle onderliggende subscripties en resources. Het budget dat op een management group wordt ingesteld, geldt voor alle onderliggende subscripties.

Je hebt de ROOT management group die alle andere management groups en subscripties bevat. Alleen gebruikers met de juiste machtigingen kunnen deze beheren. deze is verbonden met de AD tenant. Voor elke organisatie is er maar één AD tenant en dus ook maar één root management group.

Voorbeeld hiërarchie:

```txt
- AD Tenant
- ROOT
  - Devs
    - Subscription 1
    - Subscription 2
  - Production
    - Subscription 3
```

Hier kunnen we beleid toepassen op de "Devs" management group die van toepassing is op Subscription 1 en 2, terwijl een ander beleid kan worden toegepast op de "Production" management group voor Subscription 3. Je kan hier ook rollen toewijzen op management group niveau om toegang te beheren voor alle onderliggende subscripties.

## Azure ARC

Azure ARC is een service die het mogelijk maakt om resources buiten Azure te beheren alsof ze binnen Azure zijn. We brengen de control-plane van Azure naar on-premises, multi-cloud en edge-omgevingen. Dit betekent dat we een uniforme beheerervaring hebben voor al onze resources, ongeacht waar ze zich bevinden.
ARC-enabled servers, Kubernetes clusters en datadiensten kunnen allemaal worden beheerd via de Azure Portal, CLI of API's.

## Virtual Machine resources

We hebben een subscriptie, binnen die subscriptie hebben we een resource group en binnen die resource group hebben we onze Virtual Machine.
Een Virtual Machine (VM) in Azure bestaat uit meerdere afzonderlijke resources die samenwerken om de VM te laten functioneren. Hier zijn de belangrijkste resources die deel uitmaken van een Azure VM:

1. **Virtual Machine Resource**: Dit is de hoofdresource die de VM zelf vertegenwoordigt. Het bevat configuratie-instellingen zoals grootte, besturingssysteem, en netwerkconfiguratie.
2. **Disks**: Elke VM heeft ten minste één schijf, de OS-schijf, waarop het besturingssysteem is geïnstalleerd. Daarnaast kunnen er extra datadisks worden toegevoegd voor opslag van gegevens.
3. **Network Interface (NIC)**: Dit is de netwerkadapter die de VM verbindt met een virtueel netwerk. De NIC heeft een IP-adres en andere netwerkconfiguraties.
4. **Virtual Network (VNet)**: Dit is het virtuele netwerk waarin de VM zich bevindt. Het VNet definieert het IP-adresbereik en de subnetten voor de VM.
5. **Public IP Address**: Als de VM toegankelijk moet zijn vanaf het internet, krijgt deze een openbaar IP-adres toegewezen.
6. **Network Security Group (NSG)**: Dit is een set van regels die het netwerkverkeer naar en van de VM regelt. Het fungeert als een firewall om ongeautoriseerd verkeer te blokkeren.

> Het is best practice om al deze resources binnen dezelfde resource group te houden voor eenvoudiger beheer en organisatie.

```txt
- Subscription
  - Resource Group
    - Virtual Machine
    - Disk (OS Disk)
    - Disk (Data Disk)
    - Network Interface
    - Public IP Address

- Virtual Network (subnet)
    - Network Security Group
```

Meerdere rescource groups kunnen hetzelfde virtuele netwerk gebruiken, dus daarom plaatsen we het virtuele netwerk buiten de rescource group van de VM zelf.

## Core Compute resources

Op basis van onze workload kiezen we de juiste SKU (Stock Keeping Unit) voor onze compute resources. Dit bepaalt de prestaties, capaciteit en kosten van de resources die we gebruiken. Je hebt verschillende compute rescources die geoptimaliseerd zijn voor verschillende doeleinden zoals memory-intensive, compute-intensive, general-purpose, etc. Op basis van de behoeften van onze applicatie kunnen we de juiste compute resource selecteren die past bij onze workload.
Een virtuele machine kan je bekijken als een bouwsteen. Het is de perfecte oplossing als je on-premise een workload hebt die je naar de cloud wilt migreren zonder grote wijzigingen aan te brengen. Je hebt volledige controle over het besturingssysteem en de software die erop draait. Je bent verantwoordelijk voor het beheer van de VM, inclusief updates, patches en beveiliging VM's bevinden zich op IaaS-niveau (Infrastructure as a Service).

Containers kunnen super snel worden gestart en gestopt, waardoor ze ideaal zijn voor toepassingen met variabele workloads. Containers delen de kernel van het host-besturingssysteem, wat betekent dat ze minder overhead hebben dan VM's. Dit maakt ze efficiënter in termen van resourcegebruik. Containers bevinden zich op PaaS-niveau (Platform as a Service). Als we denken aan een container maakt hij een soort sandbox aan waarin de applicatie draait. De container gebruikt de kernel van het host-besturingssysteem maar heeft zijn eigen gebruikersruimte.

### Azure container instances

Azure Container Instances (ACI) is een service die het mogelijk maakt om containers direct in Azure te draaien zonder dat je een volledige virtuele machine hoeft te beheren. ACI is ideaal voor scenario's waarin je snel containers wilt implementeren zonder de overhead van het beheren van infrastructuur. Je moet enkel een klein deel zelf beheren zoals het container image en de configuratie, container images kunnen worden opgeslagen in Azure Container Registry (ACR) of andere container registries zoals Docker Hub.

### Azure Kubernetes Service

Azure Kubernetes Service (AKS) is een beheerde Kubernetes-service die het eenvoudiger maakt om containerized applicaties te implementeren, beheren en schalen met behulp van Kubernetes. AKS neemt veel van de complexiteit weg die gepaard gaat met het opzetten en beheren van een Kubernetes-cluster. Microsoft beheert de control-plane van het cluster, inclusief de API-server, etcd-database en andere kritieke componenten. Dit betekent dat ik me kan concentreren op het implementeren en beheren van mijn applicaties zonder me zorgen te maken over de onderliggende infrastructuur.

### App Service

Azure App Service is een volledig beheerde platform-as-a-service (PaaS) die het mogelijk maakt om webapplicaties, mobiele back-ends en RESTful API's te bouwen, implementeren en schalen. Met App Service hoef ik me geen zorgen te maken over de onderliggende infrastructuur, zoals servers of besturingssystemen, omdat Microsoft dit voor mij beheert. Ik kan eenvoudig mijn code implementeren via verschillende methoden, zoals Git, FTP of via Azure DevOps. App Service ondersteunt meerdere programmeertalen en frameworks, waaronder .NET, Java, Node.js, Python en meer. Het biedt ook ingebouwde functies zoals automatische schaling, beveiliging en integratie met andere Azure-diensten.

**Serverless functies**

Azure Functions is een serverless compute-service die het mogelijk maakt om code uit te voeren als reactie op gebeurtenissen. Met Azure Functions kan ik kleine stukjes code schrijven, bekend als "functies", die automatisch worden uitgevoerd wanneer ze worden geactiveerd door specifieke gebeurtenissen, zoals HTTP-aanvragen, timergebeurtenissen of berichten in een wachtrij. Ik betaal alleen voor de tijd dat mijn code wordt uitgevoerd, wat het kostenefficiënt maakt voor toepassingen met onregelmatige of onvoorspelbare workloads.

### Virtual machine scalesets

Virtual Machine Scale Sets (VMSS) zijn een Azure-service die het mogelijk maakt om een groep identieke, schaalbare virtuele machines te beheren. VMSS is ontworpen om automatisch te schalen op basis van de vraag, waardoor het ideaal is voor toepassingen met variabele workloads. Ik kan een template definiëren voor de VM's in de schaalset, inclusief het besturingssysteem, de grootte en de configuratie. Wanneer de vraag toeneemt, kan VMSS automatisch extra VM's toevoegen om de belasting aan te kunnen. Wanneer de vraag afneemt, kan VMSS automatisch VM's verwijderen om kosten te besparen. Ik kan ook deze configuratie aanpassen en instellen zoals:

- Als CPU-gebruik boven een bepaalde drempel komt, voeg dan meer VM's toe.
- Als CPU-gebruik onder een bepaalde drempel komt, verwijder dan overtollige VM's.

Op deze manier kan ik ervoor zorgen dat mijn applicatie altijd voldoende capaciteit heeft om aan de vraag te voldoen, terwijl ik tegelijkertijd kosten optimaliseer door alleen te betalen voor de resources die ik daadwerkelijk gebruik.

### Azure virtual desktop

Azure Virtual Desktop (AVD) is een cloudgebaseerde dienst die het mogelijk maakt om virtuele desktops en applicaties te leveren aan gebruikers vanaf elke locatie. Met AVD kunnen gebruikers toegang krijgen tot hun desktopomgeving en applicaties via een breed scala aan apparaten, waaronder pc's, Macs, tablets en smartphones. AVD biedt een flexibele en schaalbare oplossing voor remote werken, waardoor organisaties hun werknemers kunnen voorzien van een consistente en veilige desktopervaring, ongeacht waar ze zich bevinden. AVD integreert naadloos met andere Azure-diensten, zoals Azure Active Directory en Microsoft 365, waardoor het eenvoudig is om gebruikers te beheren en beveiligingsbeleid toe te passen.

## Azure Networking resources

Binnen een subscription kiezen we een regio waar we onze virtuele netwerken (VNet) willen implementeren. Deze bestaat in een specifieke regio & specifieke subscription. Deze is niet over meerdere subscriptions of regio's heen te gebruiken. Binnen een VNet kunnen we meerdere subnets maken om onze resources verder te segmenteren. Elk subnet kan zijn eigen netwerkbeveiligingsgroepen (NSG's) hebben om het verkeer te regelen.

Virtual Networks (VNet) zorgt ervoor dat elke rescource zijn eigen private IP-adres krijgt binnnen het VNnet. Resources binnen hetzelfde VNet kunnen direct met elkaar communiceren via hun private IP-adressen, tenzij er netwerkbeveiligingsregels zijn die dit verkeer blokkeren. Resources in verschillende VNets kunnen ook met elkaar communiceren, maar hiervoor moeten we een VNet-peering of een VPN-gateway instellen. Dit is niet automatisch bereikbaar van het publieke internet.
Binnen dezelfde regio kan de VNET over verschillende availability zones worden verspreid en toch als één VNet functioneren.

**Belangrijk**: Bij Azure verlies je altijd 5 iP-adressen per subnet. Het eerste IP-adres in het subnet is het netwerkadres, het laatste is het broadcast-adres, en daarnaast reserveert Azure nog drie extra adressen 1 voor de gateway en 2 voor DNS.

Als we een 2e subscription nog een VNET nemen en we willen dat die met elkaar kunnen communiceren, dan moeten we VNET peering instellen. Dit kan zowel binnen dezelfde regio als tussen verschillende regio's. We moeten wel opletten dat er geen IP-adres overlap is tussen de twee VNets omdat ze anders niet met elkaar kunnen communiceren.

### Azure VPN

We hebben 2 types van VPN's in Azure:

1. Route based VPN: Dit type VPN maakt gebruik van IP-routes om het verkeer te routeren tussen de on-premises netwerken en het Azure VNet. Het is flexibeler en ondersteunt meerdere tunnels en protocollen. Dit type wordt meestal gebruikt voor site-to-site VPN's.

2. Policy based VPN: Dit type VPN maakt gebruik van statische IPsec-beleidsregels om het verkeer te routeren. Het is eenvoudiger, maar minder flexibel dan route-based VPN's. Dit type wordt meestal gebruikt voor point-to-site VPN's.

We vermijden het gebruiken van een policy based VPN omdat deze minder flexibel is en niet goed schaalbaar is voor grotere netwerken. We gebruiken dit enkel voor legacy systemen die dit vereisen.

### ExpressRoute

Een ExpressRoute-verbinding is een private, dedicated connectie tussen de on-premises omgeving en Microsoft Azure, zonder gebruik van het publieke internet. De fysieke koppeling gebeurt via een ExpressRoute-locatie (peering location), een colocatie-datacenter waar Microsoft’s edge-apparatuur aanwezig is.

Hoewel Microsoft de term Meet-Me Room (MMR) niet gebruikt, werkt een ExpressRoute-locatie functioneel hetzelfde: het is een plek in een datacenter waar providers, carriers en Microsoft via cross-connects met elkaar worden gekoppeld. Hierdoor loopt ExpressRoute in de praktijk via een colocatie-interconnectieruimte, maar deze wordt door Microsoft niet formeel als MMR aangeduid.

Binnen ExpressRoute zijn er verschillende peering types:

- **Private peering**:
Private peering maakt het mogelijk om rechtstreeks verbinding te maken tussen het on-premises netwerk en Azure Virtual Networks (VNets)
- **Microsoft peering**:
Microsoft peering maakt het mogelijk om verbinding te maken met Microsoft-diensten zoals Office 365, Dynamics 365 en andere publieke Azure-diensten via de ExpressRoute-verbinding.
- **Public peering**:
Public peering was bedoeld om verbinding te maken met publieke Azure-diensten, maar is inmiddels verouderd en wordt niet meer aanbevolen voor nieuwe implementaties.

### Endpoints

Public endpoint betekent dat de Azure-dienst een endpoint heeft met een publieke IP-adres dat bereikbaar is via het internet. Veel diensten hebben een service firewall waarmee je het verkeer kunt beperken. We kunnen ook een subnet een bekende eniteit geven door een service endpoint toe te voegen. Hierdoor kan alleen dat subnet verbinding maken met de Azure-dienst.

Service endpoints zorgen ervoor dat een VNet direct kan communiceren met Azure-diensten via hun publieke endpoint, terwijl het verkeer toch volledig over het Microsoft-backbone netwerk loopt. De dienst zelf behoudt een publiek IP, maar kan zo worden geconfigureerd dat alleen verkeer vanuit het geselecteerde VNet/subnet toegang krijgt. Dit biedt eenvoudige, netwerkgebaseerde beveiliging zonder extra infrastructuur.
Public endpoints

Een private endpoint zorgt ervoor dat een Azure-dienst een privé IP-adres krijgt binnen een VNet. Hierdoor is de dienst alleen bereikbaar vanuit dat VNet, zonder dat er een publiek IP-adres nodig is.

## Azure Storage resources

Dit vormt de basis van andere Azure-diensten zoals databases, virtuele machines en back-ups. Het is een van de meest kritieke componenten van Azure, omdat bijna alle toepassingen en diensten opslag nodig hebben om gegevens op te slaan en te beheren.

### Storage accounts

Een storage account is een container voor verschillende Azure-opslagdiensten.  
Het bevat containers, shares en tabellen, en je kunt toegangsrechten per onderdeel instellen.
Er zijn verschillende soorten storage accounts, elk geoptimaliseerd voor specifieke gebruiksscenario's:

1. Blob Storage(Binary large object): Opslag voor ongestructureerde data zoals afbeeldingen, video's, documenten en back-ups. Zeer schaalbaar en ideaal voor grote bestanden en back-ups.

We hebbe nverschillende types blobs:

- Block blobs: Geschikt voor het opslaan van grote bestanden zoals media en documenten. Gebruikt voor de meeste scenario's.
- Append blobs: Geoptimaliseerd voor scenario's waarbij gegevens continu worden toegevoegd, zoals logbestanden.
- Page blobs: Gebruikt voor het opslaan van virtuele harde schijven (VHD's) en andere scenario's die snelle lees- en schrijfbewerkingen vereisen.

2. Azure Files: Gedeelde bestandsopslag toegankelijk via SMB- of NFS-protocollen.
Het is toegankelijk vanaf meerdere virtuele machines en on-premises systemen. Ideaal voor gedeelde configuratiebestanden, logs en applicatiegegevens.

3. Queue Storage  
Opslag voor berichten tussen applicatieonderdelen. Dit ondersteunt asynchrone communicatie en is geschikt voor wachtrijen en background tasks.

4. Table Storage  
NoSQL-opslag voor gestructureerde data zonder relationele database. Geschikt voor logs, IoT-data en configuraties  

5. Data Lake Storage  
Schaalbare opslag voor big-data en analytische workloads. Gebouwd bovenop Blob storage en is geoptimaliseert voor analyse met tools zoals Azure HDInsight en Azure Databricks. Dit is ideaal voor machine learning, data-analyse en rapportage.

### Redundancy opties

`Local-redundant storage (LRS):` Slaat drie kopieën van de gegevens op binnen één datacenter in een regio. Dit beschermt tegen hardwarestoringen, maar niet tegen datacenter-brede storingen.

`Zone-redundant storage (ZRS):` Slaat gegevens op in drie afzonderlijke beschikbaarheidszones binnen dezelfde regio. Dit biedt bescherming tegen datacenter-brede storingen binnen een regio.

`Geo-redundant storage (GRS):` Repliceert gegevens naar een secundaire regio, honderden kilometers verwijderd van de primaire regio. Dit beschermt tegen regionale storingen, maar er is een vertraging bij het repliceren van gegevens naar de secundaire regio. Er zijn nog steeds 3 kopieën in de primaire regio.
`Read-access geo-redundant storage (RA-GRS):` Dit is een uitbreiding van GRS die lees-toegang biedt tot de gerepliceerde gegevens in de secundaire regio. Dit betekent dat als de primaire regio niet beschikbaar is, je nog steeds toegang hebt tot je gegevens in de secundaire regio voor leesbewerkingen.

`Geo-zone-redundant storage (GZRS):` Combineert de voordelen van ZRS en GRS door gegevens eerst te repliceren naar meerdere beschikbaarheidszones binnen de primaire regio en vervolgens naar een secundaire regio. Dit biedt zowel bescherming tegen datacenter-brede storingen als regionale storingen.

### Access tiers

Azure Storage biedt verschillende access tiers om kosten te optimaliseren op basis van de toegankelijkheid en het gebruikspatroon van gegevens:

1. Hot Tier: Deze laag is bedoeld voor gegevens die vaak worden geraadpleegd. Het biedt de laagste latentie en de hoogste doorvoersnelheid, maar heeft hogere opslagkosten. Ideaal voor actieve gegevens die regelmatig worden gebruikt.
2. Cool Tier: Deze laag is bedoeld voor gegevens die minder vaak worden geraadpleegd, maar nog steeds snel toegankelijk moeten zijn. Het heeft lagere opslagkosten dan de hot tier, maar hogere toegangs- en bewerkingskosten. Geschikt voor gegevens die enkele keren per maand worden geraadpleegd.
3. Archive Tier: Deze laag is bedoeld voor gegevens die zelden worden geraadpleegd en waarvoor een langere toegangsduur acceptabel is. Het heeft de laagste opslagkosten, maar de hoogste toegangs- en bewerkingskosten. Gegevens in deze laag moeten eerst worden opgehaald voordat ze kunnen worden geraadpleegd, wat uren kan duren. Ideaal voor langdurige archivering van gegevens die zelden worden gebruikt

## Azure Database resources

Je hebt `Azure SQL Database`, een volledig beheerde relationele database-service gebaseerd op Microsoft SQL Server. Deze service neemt veel van het beheer en de onderhoudstaken uit handen, zoals patching, back-ups en schaling. Dit noemen we ook wel Platform as a Service (PaaS). Je kunt eenvoudig databases maken, beheren en schalen via de Azure Portal, CLI of API's.

`Azure SQL Managed Instance` is een andere variant van Azure SQL Database die meer compatibiliteit biedt met on-premises SQL Server-omgevingen. Het is ontworpen voor organisaties die hun bestaande SQL Server-workloads naar de cloud willen migreren zonder grote wijzigingen aan te brengen. Managed Instance biedt bijna volledige compatibiliteit met SQL Server, inclusief ondersteuning voor SQL Agent, cross-database queries en meer. Het is ook een PaaS-oplossing, wat betekent dat Microsoft het beheer en onderhoud van de onderliggende infrastructuur verzorgt.

`MYSQL` , `PostgreSQL` en `MariaDB` zijn populaire open-source relationele databasesystemen die ook beschikbaar zijn als volledig beheerde diensten in Azure. Azure Database for MySQL en Azure Database for PostgreSQL bieden vergelijkbare voordelen als Azure SQL Database.

- Citus: Is een hyperscale optie voor PostgreSQL binnen Azure. Het maakt het mogelijk om PostgreSQL-databases horizontaal te schalen door gegevens over meerdere knooppunten te verdelen.

`Cosmos DB` is een volledig beheerde NoSQL-database-service die is ontworpen voor schaalbaarheid, lage latentie en wereldwijde distributie. Het ondersteunt meerdere API's, waaronder SQL, MongoDB, Cassandra, Gremlin en Table API.

- Multi-model: Cosmos DB ondersteunt verschillende datamodellen, waaronder document, key-value, grafiek en kolom-georiënteerde modellen.
- Multi-consistency: Biedt vijf goed gedefinieerde consistentieniveaus om te kiezen, afhankelijk van de behoeften van de applicatie.

> NoSQL-databases worden zo genoemd omdat ze niet het traditionele relationele databasemodel volgen. Het zorgt ervoor dat je zoals Cosmos DB, MongoDB, Cassandra, etc. flexibeler bent in het opslaan van gegevens. In plaats van tabellen met rijen en kolommen, kunnen NoSQL-databases verschillende structuren gebruiken zoals documenten, key-value paren, grafieken of kolom-georiënteerde opslag.

`Azure Files` is een volledig beheerde bestandsdelingservice in Azure die toegankelijk is via het SMB- of NFS-protocol. Dit staat gelijk aan een gedeelde netwerkmap die je kunt gebruiken om bestanden op te slaan en te delen tussen meerdere virtuele machines en on-premises systemen. Azure Files is ideaal voor scenario's waarin je gedeelde configuratiebestanden, logs of applicatiegegevens wilt opslaan die toegankelijk moeten zijn vanaf verschillende locaties.

`Azure File Sync` is een service die het mogelijk maakt om bestanden te synchroniseren tussen on-premises bestandsservers en Azure Files. Dit zorgt voor een hybride opslagoplossing waarbij je lokale bestanden kunt behouden terwijl je profiteert van de schaalbaarheid en beschikbaarheid van Azure Files. Met Azure File Sync kun je ook meerdere on-premises locaties synchroniseren met dezelfde Azure File Share, waardoor het eenvoudig is om bestanden te delen en te beheren over verschillende locaties.

We hebben een scenario waar we on premise snmb share hebben en we willen deze migreren naar Azure Files. We kunnen dit doen met Azure File Sync. We installeren een agent op de on-premises server die de bestanden synchroniseert met Azure Files. Dit zorgt ervoor dat alle wijzigingen die lokaal worden aangebracht automatisch worden gesynchroniseerd met Azure Files, en vice versa. Hierdoor kunnen we geleidelijk migreren naar de cloud zonder downtime of gegevensverlies. We kunnen ook kiezen om ook gedeeltelijk lokaal te cachen zodat veelgebruikte bestanden snel toegankelijk zijn zonder dat ze telkens uit de cloud hoeven te worden opgehaald.

Het grote voordeel van deze werkwijze is dat je dan via Azure AD toegangscontrole kunnen regelen.

`Cloud Tiers` is een functie binnen Azure Files die het mogelijk maakt om automatisch bestanden te verplaatsen tussen verschillende opslaglagen op basis van hun gebruikspatronen. Dit helpt om opslagkosten te optimaliseren door minder vaak geraadpleegde bestanden naar goedkopere opslaglagen te verplaatsen, terwijl veelgebruikte bestanden snel toegankelijk blijven.

### Azure Storage Explorer

Azure Storage Explorer is een gratis, zelfstandige applicatie die het mogelijk maakt om Azure-opslagaccounts te beheren en te verkennen. Met Storage Explorer kunnen we eenvoudig bestanden uploaden, downloaden en beheren in verschillende Azure-opslagdiensten, zoals Blob Storage, Azure Files, Queue Storage en Table Storage. Goed voor een interactie waar we weinig data willen overzetten of beheren zonder dat we de Azure Portal hoeven te gebruiken. Het biedt een gebruiksvriendelijke interface waarmee we snel toegang hebben tot onze opslagresources en deze kunnen beheren vanaf onze lokale machine. Voor meerdere bestanden is het handiger om AzCopy te gebruiken.

### AzCopy

AzCopy is een command-line tool die is ontworpen voor het efficiënt kopiëren van data naar en van Azure Storage.

- Automatiseren: AzCopy kan worden geïntegreerd in scripts en geautomatiseerde workflows, waardoor het ideaal is voor regelmatige back-ups of gegevensmigraties.
- Copy/Sync: AzCopy ondersteunt zowel het kopiëren van bestanden als het synchroniseren van mappen tussen lokale systemen en Azure Storage. Dit maakt het eenvoudig om gegevens up-to-date te houden tussen verschillende locaties.
- Cloud to Cloud: AzCopy kan ook worden gebruikt om gegevens direct tussen verschillende Azure Storage-accounts te kopiëren, wat handig is voor het verplaatsen van gegevens tussen omgevingen of regio's.

### Azure Migrate

Azure Migrate is een dienst die helpt bij het plannen en uitvoeren van de migratie van on-premises workloads naar Azure. Het biedt tools en services om de huidige infrastructuur te beoordelen, migratie-opties te evalueren en de migratie zelf uit te voeren. Azure Migrate ondersteunt verschillende soorten workloads, waaronder virtuele machines, databases, applicaties en gegevens.

- VM-migratie: Azure Migrate biedt tools om on-premises virtuele machines te ontdekken, beoordelen en migreren naar Azure Virtual Machines.
- Database-migratie: Het ondersteunt ook de migratie van on-premises databases naar Azure
- Applicatiemigratie: Azure Migrate kan helpen bij het migreren van on-premises applicaties naar Azure App Service of andere Azure-diensten.
- Gegevensmigratie: Het biedt tools om grote hoeveelheden gegevens te migreren naar Azure Storage of andere Azure-diensten.

> Azcopy , Azure migrate , Azure Files, Azure File Sync, AzCopy zijn allemaal online-diensten. Je hebt een werkende internetverbinding nodig om deze te gebruiken.

### Azure Data Box

Azure Data Box is een fysieke apparaatoplossing die wordt aangeboden door Microsoft om grote hoeveelheden gegevens veilig naar Azure te migreren. Het is ontworpen voor scenario's waarin het overbrengen van gegevens via het internet onpraktisch of te tijdrovend is, zoals bij zeer grote datasets of beperkte netwerkbandbreedte.

- Disk : Dit is een kleiner apparaat dat geschikt is voor het overbrengen van enkele terabytes aan gegevens. Het apparaat wordt naar de klant gestuurd, die de gegevens erop kopieert en het vervolgens terugstuurt naar Microsoft voor upload naar Azure.
- Box : Is voor export en import van grotere datasets, tot 80 TB. Het apparaat heeft meerdere harde schijven en is ontworpen voor het veilig overbrengen van grote hoeveelheden gegevens.
- Data Box Heavy: Dit is een robuuster apparaat dat tot 770TB aan gegevens kan overbrengen. Het is bedoeld voor zeer grote datasets en biedt extra beveiligingsfuncties om de gegevens tijdens het transport te beschermen.

> Dit is offline data transfer. Je krijgt een fysieke apparaat opgestuurd van Microsoft, je sluit deze aan op je netwerk, kopieert de data erop en stuurt het apparaat terug naar Microsoft. Zij laden de data dan voor je in Azure. Als je er data wilt afhalen kan je hetzelfde doen maar dan in omgekeerde volgorde.

## Azure Marketplace

Azure Marketplace is een online winkel waar je duizenden vooraf gebouwde applicaties, diensten en oplossingen kunt vinden die zijn ontwikkeld door Microsoft en 3e partijen. Dit zijn kant & klare deployable oplossingen die je direct in je Azure-omgeving kunt implementeren.
Deze worden aangerekend op basis van licenses per uur maar er zijn ook waar je je eigen licentie voor moet hebben (BYOL - Bring Your Own License).

## Azure IOT services

Azure IoT (Internet of Things) services zijn een reeks cloudgebaseerde diensten die zijn ontworpen om IoT-oplossingen te bouwen, implementeren en beheren.
Het doel van IoT is om fysieke apparaten te verbinden met het internet, zodat ze gegevens kunnen verzamelen, verzenden en ontvangen. Dit voor telemetry gegevens, command & control en met andere apparaten communiceren. Dit brengt nieuwe problemen met zich mee qua veiligheid omdat deze apparaten vaak kwetsbaarder zijn dan traditionele IT-apparaten.

We willen graag sensors, identiteitsbeheer, data-analyse en integratie met andere systemen. Azure IoT biedt verschillende diensten die deze functionaliteiten ondersteunen, zoals:

### Azure IoT Hub

Azure IoT Hub is een beheerde service (PAAS) die fungeert als een centrale hub voor het verbinden, bewaken en beheren van IoT-apparaten. Het ondersteunt bidirectionele communicatie tussen apparaten en de cloud, waardoor je gegevens kunt verzamelen van apparaten en commando's kunt verzenden naar apparaten. IoT Hub biedt ook functies zoals apparaatregistratie, apparaatbeheer en beveiliging.

Device to cloud --> Metrics, Telemetry data
Device --> Cloud upload & request response
Cloud to device --> Command & Control & firmware updates

Device twins: Virtuele representaties van fysieke apparaten in de cloud. Hiermee kun je de staat en configuratie van apparaten bijhouden en synchroniseren tussen de cloud en de apparaten. Dit is een manier om met de apparaten te communiceren zonder dat je direct verbinding hoeft te maken. Dit wordt de verantwoordelijkheid van IoT Hub.

SDK's: IoT Hub biedt SDK's voor verschillende programmeertalen, waardoor het eenvoudiger wordt om IoT-toepassingen te ontwikkelen en apparaten te integreren met de hub. Ik moet enkel een applicatie maken die de SDK gebruikt om met IoT Hub te communiceren.

### Azure IoT Central

Azure IoT Central is een volledig beheerde (SAAS) IoT-applicatieplatform dat is ontworpen om het bouwen en implementeren van IoT-oplossingen te vereenvoudigen. Het biedt een gebruiksvriendelijke interface en vooraf gebouwde sjablonen om snel IoT-toepassingen te maken.  IoT Central gebruikt IoT Hub als de onderliggende communicatie- en apparaatbeheerlaag, maar voegt extra functionaliteiten toe zoals dashboards, rapportage, device templates en integraties met andere Azure-diensten. Dit is als je wilt dat het out-of-the-box werkt zonder dat je zelf veel moet ontwikkelen.

Je kan via een wizard instellen die bepaalde acties ondernemen wanneer een sensor een bepaalde waarde overschrijdt. Je kan dit volledig zelf samenstellen via een eenvoudige interface.

- Signal --> condition --> Action --> Email, SMS, Webhook, Function, Logic App

### Azure Sphere

Azure Sphere is een end-to-end beveiligde IoT-oplossing die bestaat uit drie geïntegreerde componenten:

- Een beveiligde microcontroller (MCU) met ingebouwde hardware-beveiliging.
- Een op Linux gebaseerd besturingssysteem (Azure Sphere OS) dat applicaties isoleert en beveiligde updates ondersteunt.
- AS3 – de Azure Sphere Security Service, de cloudgebaseerde beveiligingslaag die zorgt voor continue verificatie, certificaatbeheer en beveiligde OS- en applicatie-updates.

Dit is nodig als veiligheid cruciaal is voor je IoT-apparaten, zoals in industriële toepassingen, gezondheidszorg of kritieke infrastructuren.

## Big Data en Analytics

Azure biedt verschillende diensten voor big data en analytics, waarmee je grote hoeveelheden gegevens kunt verwerken, analyseren en visualiseren.

### Azure Data Factory

Azure Data Factory (ADF)

Azure Data Factory is een cloudgebaseerde gegevensintegratie- en orchestratieservice. Het maakt het mogelijk om gegevens uit verschillende bronnen te extraheren, te transformeren en te laden (ETL/ELT) naar diverse doelsystemen. Met ADF kunnen data pipelines worden opgebouwd, gepland, beheerd en geautomatiseerd via een visuele interface of code.

ADF fungeert als orchestrator het:

- Verplaatst data tussen systemen (copy activities).
- Voert dataworkflows uit volgens schema’s of triggers.
- Start berekeningen in andere platformen (zoals Spark, Databricks, HDInsight).
- Automatiseert ETL- en ELT-processen.
- Integreert met vrijwel elke Azure-dienst en veel externe systemen.

ADF is dus de dirigent van het dataverwerkingsproces en geen data opslag- of verwerkingsdienst op zich.

`Azure Synapse Analytics` is een geïntegreerd analytics-platform dat datawarehousing, big-data-verwerking en data-integratie combineert binnen één omgeving. Het bevat zowel SQL-gebaseerde analyse, Apache Spark-verwerking als Synapse Pipelines, die dezelfde technologie gebruiken als Azure Data Factory voor het bouwen van dataworkflows.
Synapse stuurt Azure Data Factory niet aan, maar bevat zelf ingebouwde orkestratiefuncties die functioneel vergelijkbaar zijn. Hierdoor kunnen zowel opslag, verwerking als integratie vanuit één centrale omgeving worden beheerd.

### Extract, Transform, Load (ETL)

ETL (Extract, Transform, Load)
Extract, Transform, Load (ETL) is een gegevensverwerkingsproces waarbij data vanuit één of meerdere bronnen wordt opgehaald, vervolgens wordt opgeschoond en omgevormd, en tenslotte wordt geladen in een doelsysteem. ETL is een kernonderdeel van data-integratie en vormt de basis voor analytische omgevingen zoals data warehouses en data lakes.

Het proces bestaat uit drie stappen:

- Extract – Het ophalen van data uit diverse bronnen (bijvoorbeeld applicaties, API’s, databases of sensoren).
- Transform – Het opschonen, verrijken en structureren van de data. Denk aan cleaning, wrangling en het toepassen van businessregels.
- Load – Het wegschrijven van de getransformeerde data naar een doelsysteem (de sink), zoals een SQL-database, Cosmos DB of een analytische omgeving.

In veel moderne architecturen wordt dit volledige proces aangestuurd door een orchestrator (zoals Azure Data Factory of Synapse Pipelines), die bepaalt wanneer welke stap wordt uitgevoerd.

`Data Lake` is een opslagomgeving waarin grote hoeveelheden gestructureerde, semi-gestructureerde en ongestructureerde data kunnen worden opgeslagen. In tegenstelling tot traditionele databases hoeft data niet vooraf te worden omgevormd; het kan in zijn oorspronkelijke RAW formaat worden opgeslagen.

Dit biedt belangrijke voordelen:

- Je kunt later verschillende analysemethoden toepassen.
- Nieuwe tools of machine-learningmodellen kunnen direct op de ruwe data worden gebruikt.
- De opslag is schaalbaar en flexibel.
- Een data lake fungeert daarmee vaak als tussenlaag of verzamelplaats binnen een ETL- of ELT-proces: data wordt eerst geparkeerd in het lake en van daaruit verder verwerkt of geanalyseerd.

### HDInsight

Azure HDInsight is een volledig beheerde cloudservice die het mogelijk maakt om big data- en analytische workloads uit te voeren met behulp van populaire open-source frameworks zoals Apache Hadoop, Spark, Hive, HBase, Storm en Kafka. Deze kan je bijvoorbeeld loslaten op data die is opgeslagen in Azure Data Lake Storage of Azure Blob Storage. HDInsight neemt veel van de complexiteit weg die gepaard gaat met het opzetten en beheren van big data-clusters, waardoor je je kunt concentreren op het analyseren van gegevens en het bouwen van data-intensieve toepassingen. 

`Hadoop` is een open-source big-data framework dat grote hoeveelheden gegevens verwerkt via gedistribueerde opslag en verwerking. Het bestaat uit twee kerncomponenten:
HDFS (Hadoop Distributed File System): Slaat data op over meerdere nodes, met automatische replicatie voor fouttolerantie en hoge beschikbaarheid.
MapReduce: Batchverwerkingsmodel dat taken opsplitst in kleine stukken, deze parallel uitvoert op het cluster en de resultaten samenvoegt.

`Apache Spark` is een open-source big-data verwerkingsframework dat ontworpen is voor snelle, in-memory data-analyse. In tegenstelling tot Hadoop MapReduce voert Spark berekeningen voornamelijk uit in RAM, waardoor het tot tintallen keren sneller kan zijn. Spark ondersteunt zowel batch- als near real-time verwerking binnen één uniform platform.
Belangrijke componenten binnen Spark zijn:

- Spark SQL: SQL-queries en gestructureerde data-analyse.
- Spark Streaming: Near real-time verwerking via micro-batching.
- MLlib: Bibliotheek voor machine learning-algoritmes op schaal.
- GraphX: Framework voor grafiek- en netwerk-analyses.

| Framework  | Type       | Gebruik                    | Snelheid  | Bijzonder                         |
| ---------- | ---------- | -------------------------- | --------- | --------------------------------- |
| **Hadoop** | Disk-based | Batch                      | Langzaam  | Zeer schaalbaar                   |
| **Spark**  | In-memory  | Batch + ML + Streaming     | Zeer snel | Unified engine                    |
| **Hive**   | Disk-based | SQL op big data            | Matig     | Bouwt op Hadoop (live-query)      |
| **HBase**  | Disk-based | NoSQL, random access       | Snel      | Lage latency, niet voor analytics |
| **Storm**  | In-memory  | True real-time streaming   | Zeer snel | Event-by-event verwerking         |
| **Kafka**  | Log-based  | Data pipelines & messaging | Zeer snel | Backbone voor streaming           |

`Azure data bricks` is een samenwerkingsplatform voor datawetenschap en engineering dat is gebouwd op Apache Spark. Het biedt een geïntegreerde omgeving voor het ontwikkelen, trainen en implementeren van machine learning-modellen en data-analyseworkflows. Azure Databricks combineert de kracht van Spark met gebruiksvriendelijke tools zoals notebooks, dashboards en geautomatiseerde workflows, waardoor teams efficiënter kunnen samenwerken aan data-intensieve projecten.

### AI services

Azure AI services zijn een reeks cloudgebaseerde diensten die kunstmatige intelligentie (AI) en machine learning (ML) functionaliteiten bieden.

Azure Machine Learning is een platform voor het bouwen, trainen en implementeren van machine learning-modellen. Het biedt tools voor dataverwerking, modeltraining, hyperparameterafstemming, AutoML en modelbeheer. Er is totale controle over het machine learning-proces, van data-preprocessing tot modeldeployment.

- Data ophalen: vanuit Azure Storage, Data Lake, databases of externe bronnen.
- Train & evalueer: modellen trainen op lokale of cloudcompute en evalueren met geregistreerde metrics.
- Pipelines: automatiseren van stappen zoals datavoorbereiding, training en validatie.
- Deploy: modellen uitrollen als API-services via AKS(Azure Kubernetes Service), ACI (Azure Container Instances) of managed endpoints.

### Azure Cognitive Services

Azure Cognitive Services is een verzameling van vooraf gebouwde AI-modellen en API's die ontwikkelaars kunnen gebruiken om intelligente functies toe te voegen aan hun applicaties zonder dat ze diepgaande kennis van machine learning nodig hebben. Deze diensten zijn onderverdeeld in verschillende categorieën, waaronder:

- Vision: Bevat API's voor beeldherkenning, gezichtsherkenning, objectdetectie en OCR (Optical Character Recognition).
- Speech: Biedt spraakherkenning, spraaksynthese, vertaling en spraaktranscriptie.
- Language: Omvat natuurlijke taalverwerking, sentimentanalyse, tekstanalyse en vertaling.
- Decision: Bevat diensten voor aanbevelingssystemen, anomaliedetectie en contentmoderatie.

### Azure Bot Services

Azure Bot Services is een platform voor het bouwen, implementeren en beheren van intelligente chatbots die kunnen communiceren met gebruikers via verschillende kanalen, zoals websites, mobiele apps, Microsoft Teams, Slack en meer. Het maakt gebruik van de Microsoft Bot Framework en integreert naadloos met andere Azure-diensten, zoals Cognitive Services, om geavanceerde AI-functionaliteiten toe te voegen aan de bots. Dit wordt veel gebruikt voor klantenservice, verkoopondersteuning en interne bedrijfsprocessen.

- Virtuele agenten: Bouwen van chatbots die natuurlijke taal begrijpen en reageren op gebruikersvragen.

### Serverless Technologies

Het is consumption based, wat betekent dat je alleen betaalt voor de compute resources die je daadwerkelijk gebruikt tijdens de uitvoering van je code. Er zijn geen vaste kosten voor inactiviteit. Ze worden aangestuurd door event-driven architectuur, wat betekent dat ze automatisch worden uitgevoerd als reactie op bepaalde gebeurtenissen, zoals HTTP-aanvragen, timergebaseerde triggers, berichten in een wachtrij of wijzigingen in een database.

`Azure Functions` is een serverless compute-service waarmee je kleine stukjes code (functies) kunt uitvoeren in reactie op gebeurtenissen zonder dat je je zorgen hoeft te maken over de onderliggende infrastructuur. Je kunt functies schrijven in verschillende programmeertalen, zoals C#, JavaScript, Python en meer. Azure Functions is ideaal voor het bouwen van microservices, het verwerken van gegevensstromen, het automatiseren van taken en het integreren van systemen.
Azure Functions is stateless, wat betekent dat elke uitvoering van een functie onafhankelijk is en geen informatie behoudt tussen oproepen.
Je hebt ook Durable Functions, een uitbreiding van Azure Functions die het mogelijk maakt om stateful workflows te bouwen binnen een serverless architectuur.

> Bij default is het stateless maar met Durable Functions kan je stateful workflows bouwen.

`Azure Logic Apps` is een cloudgebaseerde dienst waarmee je geautomatiseerde workflows kunt bouwen en beheren zonder code of een kleine hoeveelheid code te schrijven. Het biedt een visuele ontwerper waarmee je eenvoudig verschillende diensten en systemen kunt integreren via vooraf gebouwde connectors. Het is automatiseren op basis van een trigger (bijv. een inkomende e-mail, een bestand dat wordt geüpload, een timergebeurtenis) en vervolgens een reeks acties uitvoeren (bijv. gegevens verwerken, meldingen verzenden, API-aanroepen doen).

### Devops Technologies

Devops is een soort cultuur en een set van praktijken die de samenwerking en communicatie tussen softwareontwikkeling (Dev) en IT-operations (Ops) teams bevorderen. Het doel is om de softwareleveringscyclus te versnellen, de kwaliteit van de software te verbeteren en de betrouwbaarheid van systemen te waarborgen door automatisering, continue integratie en continue levering (CI/CD) toe te passen. Het is niet perse een tool maar er zijn wel tools die dit proces ondersteunen.

`Azure DevOps` is een cloudgebaseerd platform dat een reeks tools en diensten biedt voor softwareontwikkeling, samenwerking en continue integratie/continue levering (CI/CD). Het ondersteunt teams bij het plannen, bouwen, testen en implementeren van softwaretoepassingen. Azure DevOps omvat verschillende componenten, waaronder Azure Repos (broncodebeheer), Azure Pipelines (CI/CD), Azure Boards (projectbeheer), Azure Test Plans (testbeheer) en Azure Artifacts (pakketbeheer).

De bedoeling van Azure Repo's is om versiebeheer te bieden voor broncode en andere bestanden. Het ondersteunt zowel Git als Team Foundation Version Control (TFVC) als versiebeheersystemen. Met Azure Repos kunnen teams samenwerken aan code, wijzigingen bijhouden, branches beheren en pull requests gebruiken om code te beoordelen en samen te voegen. Ze kunnen ook lokale repositories klonen naar hun ontwikkelomgeving om offline te werken.

Er is wel een grotere speler in dit domein: `GitHub`. GitHub is een webgebaseerd platform voor versiebeheer en samenwerking dat is gebouwd rond het Git-versiebeheersysteem. Het stelt ontwikkelaars in staat om code op te slaan, te beheren en samen te werken aan projecten. GitHub biedt functies zoals pull requests, issues, project boards en integraties met andere tools en diensten. Het is een van de populairste platforms voor open-source en private softwareontwikkeling. Er is ook Github Actions, wat vergelijkbaar is met Azure Pipelines. Hiermee kan je CI/CD workflows bouwen die automatisch code bouwen, testen en implementeren op basis van gebeurtenissen zoals pushen naar een repository of het openen van een pull request.