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