# Cloud

## Wat is de cloud?

Cloud computring is het leveren van verschillende diensten via het internet, waaronder opslag, databases, servers, netwerken, software en meer. In plaats van fysieke hardware te bezitten en te onderhouden, kunnen gebruikers en bedrijven deze middelen huren van cloudproviders. Ze bieden ook dingen bovenop de traditionele IT zoals IOT, ML, en AI.

Het gebruik van Cloud biedt verschillende voordelen:

- Schaalbaarheid: Resources kunnen snel worden opgeschaald of afgeschaald op basis van de vraag.
- Kostenbesparing: Betalen voor wat je gebruikt, zonder grote initiële investeringen in hardware.
- Betrouwbaarheid: Cloudproviders zorgen voor hoge beschikbaarheid en back-up van data.

## Cloud service categorieën

`IAAS` (Infrastructure as a Service) is waar de cloud provider de basis infrastructuur beheert & onderhoudt. Hierbij denken we aan netwerk, opslag , computing power. De gebruiker is verantwoordelijk voor het besturingssysteem, middleware, runtime, data en applicaties.
`PAAS` (Platform as a Service) is een dienst waarbij de cloud provider niet alleen de infrastructuur beheert, maar ook het besturingssysteem, middleware en runtime. De gebruiker hoeft zich alleen bezig te houden met de data en applicaties. Dit maakt het eenvoudiger om applicaties te ontwikkelen en te implementeren zonder zich zorgen te maken over de onderliggende infrastructuur. Er is wel veel minder controle over de omgeving.
`SAAS` (Software as a Service) is een dienst waarbij de cloud provider de volledige stack beheert, inclusief infrastructuur, besturingssysteem, middleware, runtime, data en applicaties. Gebruikers krijgen toegang tot de software via het internet, meestal via een webbrowser. Dit model is ideaal voor eindgebruikers die geen technische kennis nodig hebben om de software te gebruiken, zoals bij e-maildiensten, CRM-systemen en kantoorapplicaties. Voorbeelden zijn Microsoft 365, Google Workspace, en Salesforce.

> Serverless : In serverless betaal je per uitvoering van je code, functie of trigger (bijv. per request, per event, per compute-seconde), en niet voor de onderliggende servers, VM’s of idle computing power. De cloudprovider beheert die infrastructuur volledig en rekent alleen het effectieve gebruik aan. Je beheert ook enkel en alleen je code.

### Shared Responsibility Model

In een traditioneel on-premises datacenter is het bedrijf volledig verantwoordelijk voor alle onderdelen: de fysieke ruimte, beveiliging, stroom, koeling, netwerk, hardware-onderhoud, patching, en alle software en infrastructuur. Alles valt onder de verantwoordelijkheid van de interne IT-afdeling.

In de cloud verschuiven deze verantwoordelijkheden. De cloudprovider neemt taken op zich zoals fysieke beveiliging, stroom, koeling en netwerkconnectiviteit — logisch, want de klant bevindt zich niet in het datacenter.
De consument blijft echter verantwoordelijk voor zijn eigen data en toegangsbeheer: wie toegang krijgt, hoe accounts beveiligd worden, en wat er met de opgeslagen informatie gebeurt.

Voor sommige onderdelen hangt de verantwoordelijkheid af van de gekozen dienst. Een beheerde SQL-database (PaaS) wordt door de provider onderhouden, maar de data blijft de verantwoordelijkheid van de klant. Wanneer je zelf een VM beheert en daarop een database installeert, ben je zelf verantwoordelijk voor patches, updates en databeheer.

On-premises: alles is de verantwoordelijkheid van de organisatie.

Cloud: verantwoordelijkheden worden gedeeld.
IaaS: meeste verantwoordelijkheid ligt bij de consument.
PaaS: gedeelde verantwoordelijkheid.
SaaS: meeste verantwoordelijkheid ligt bij de cloudprovider.
Het Shared Responsibility Model toont dus duidelijk wie verantwoordelijk is voor welke onderdelen, afhankelijk van het gekozen cloudservicemodel.

Wat altijd de verantwoordelijkheid van de klant is ongeacht het model:

- Informatie & data
- Mobiele apparaten & endpoints
- Accounts & Identiteiten

Gedeelde verantwoordelijkheid (afhankelijk van het model):

- Identiteitsbeheer (SAAS & PAAS)
- Applicaties (PAAS)
- Netwerk controles (PAAS)

Wat altijd de verantwoordelijkheid van de cloudprovider is ongeacht het model:

- Fysieke datacenter
- Fysieke netwerk
- Fysieke infrastructuur

<img src="/assets/shared-responsibility.svg" alt="Shared Responsibility Model" size="600x400">  

### Consumptie modellen

Wanneer we IT infrastructuur modellen vergelijken zijn er twee type van kosten die we moeten bekijken: CapEx (Capital Expenditure) en OpEx (Operational Expenditure).

*CapEX* is de eenmalige upfront investering in fysieke hardware , licenties, gebouwen, en andere vaste activa. Dit model vereist aanzienlijke initiële uitgaven en langetermijnplanning.

*OpEx* daarentegen zijn doorlopende operationele kosten voor het gebruik van diensten en middelen. Dit model biedt flexibiliteit, omdat organisaties alleen betalen voor wat ze gebruiken, zonder grote initiële investeringen. Het is zoals een voertuig leasen, een gebouw huren voor een evenement, of een abonnement nemen op een streamingdienst. Cloud computing valt onder het OpEx model omdat cloud computing op een pay-as-you-go basis werkt. Je betaalt alleen voor de resources die je daadwerkelijk gebruikt, zonder grote upfront kosten. Als je deze maand geen IT resources nodig hebt, betaal je er ook niet voor.
Dit heeft enkele aanzienlijke voordelen:

- Lagere initiële kosten: Geen grote investeringen vooraf.
- Schaalbaarheid: Resources kunnen snel worden aangepast aan de vraag. Bijvoorbeeld, tijdens piekperiodes kan je snel extra capaciteit toevoegen en deze weer verminderen wanneer de vraag afneemt.
- Flexibiliteit: Gemakkelijk toegang tot de nieuwste technologieën zonder langdurige verplichtingen.

### Type Clouds

Er zijn drie hoofdtypen cloudmodellen:

1. Private Cloud: Een private cloud is een cloudomgeving die exclusief wordt gebruikt door één organisatie. Deze kan on-premises worden gehost of door een derde partij worden beheerd. Private clouds bieden meer controle en beveiliging, wat ze geschikt maakt voor gevoelige gegevens en bedrijfskritische toepassingen.
2. Public Cloud: In een public cloud worden diensten geleverd via het openbare internet en gedeeld door meerdere organisaties. Voorbeelden van public cloudproviders zijn Amazon Web Services (AWS), Microsoft Azure en Google Cloud Platform (GCP). Public clouds zijn kostenefficiënt en schaalbaar, waardoor ze ideaal zijn voor algemene toepassingen en workloads.
3. Hybrid Cloud: Een hybrid cloud combineert private en public cloudomgevingen, waardoor gegevens en toepassingen tussen beide kunnen worden gedeeld. Dit model biedt flexibiliteit, omdat organisaties gevoelige gegevens in een private cloud kunnen houden terwijl ze profiteren van de schaalbaarheid van de public cloud voor minder kritieke workloads.
4. Multi-Cloud: Multi-cloud verwijst naar het gebruik van meerdere cloudservices van verschillende providers binnen een enkele architectuur. Dit kan helpen om afhankelijkheid van één enkele provider te verminderen, de beste diensten van elke provider te benutten en veerkracht te vergroten.

**Azure ARC**

Is een set van technologieën die je helpt met het beheren van je cloud-omgevingen. Je kan het gebruiken ongeacht of je een publiekje cloud, private cloud, hybrid cloud of zelfs een multi-cloud omgeving hebt. Er bestaat ook een oplossing voor VMware.

## High Availability & Scalability

`High Availability (HA)` verwijst naar systemen die ontworpen zijn om continu operationeel te blijven met minimale downtime. Dit wordt bereikt door redundantie, failover-mechanismen en gedistribueerde architecturen. In de cloud wanneer je een oplosisng maakt die hoge beschikbaarheid nodig heeft dan gebruik je meestal gebruik van een `SLA` (Service Level Agreement) die een bepaalde uptime garandeert, bijvoorbeeld 99.9%, 99,99 of zelfs 99,999%. Hiermee garandeert de cloudprovider dat hun diensten beschikbaar zullen zijn volgens het afgesproken percentage. Als ze dit niet halen, kunnen klanten compensatie krijgen. Dit is natuurlijk wel veel duurder naarmate de SLA hoger is.

`Scalability` verwijst naar het vermogen van een systeem om efficiënt te reageren op veranderingen in de vraag door resources toe te voegen of te verwijderen. In de cloud kan dit automatisch gebeuren via `autoscaling`, waarbij systemen automatisch worden opgeschaald tijdens piekperiodes en afgeschaald wanneer de vraag afneemt. Dit zorgt voor optimale prestaties en kostenbeheer, omdat je alleen betaalt voor de resources die je daadwerkelijk gebruikt.

Je hebt 2 manieren om op te schalen:

1. Vertical Scaling (Scaling Up/Down): Dit houdt in dat je de capaciteit van een enkele resource verhoogt of verlaagt, zoals het toevoegen van meer CPU, RAM of opslag aan een bestaande server of virtuele machine. Dit is vaak eenvoudiger te implementeren, maar heeft beperkingen omdat er een maximum is aan hoe krachtig een enkele machine kan worden en ook krijg je hierdoor vaak downtime tijdens het opschalen. Deze methode wordt best vermeden voor toepassingen die hoge beschikbaarheid vereisen.
2. Horizontal Scaling (Scaling Out/In): Dit houdt in dat je het aantal resources verhoogt of verlaagt door extra machines of instances toe te voegen of te verwijderen. Bijvoorbeeld, in plaats van één container te hebben, kan je meerdere minder krachtige containers gebruiken die samenwerken om de belasting te verdelen. Dit biedt betere beschikbaarheid en flexibiliteit, omdat je gemakkelijk extra capaciteit kunt toevoegen zonder downtime. Het is de voorkeursmethode voor cloudomgevingen die hoge beschikbaarheid en schaalbaarheid vereisen.

### Reliability & predictability

`Reliability` verwijst naar de consistentie en stabiliteit van een systeem om zijn functies uit te voeren zonder fouten of onderbrekingen over een bepaalde periode. In de context van cloud computing betekent dit dat diensten en applicaties betrouwbaar beschikbaar zijn voor gebruikers, met minimale downtime en storingen.

- `Auto-healing`
Dit zorgt ervoor dat als bijvoorbeeld een VM faalt de cloudomgeving dit detecteert en zelf zonder tussenkomst van een beheerder een nieuwe VM opstart om de falende te vervangen.

- `Storage` wordt vaak gerepliceerd over meerdere fysieke locaties om dataverlies te voorkomen bij hardwarestoringen.

- `Auto-scaling` wordt gebruikt om automatisch extra resources toe te voegen tijdens piekbelastingen en deze weer te verwijderen wanneer de vraag afneemt. Dit helpt om prestaties consistent te houden, zelfs tijdens onverwachte verkeerspieken. Zonder tussenkomst van een beheerder.

`Predictability` verwijst naar het vermogen om de prestaties en kosten van een systeem nauwkeurig te voorspellen op basis van vooraf bepaalde parameters. In de cloud betekent dit dat organisaties in staat zijn om hun resourcegebruik, prestaties en uitgaven te plannen en te beheren op een manier die consistent is met hun verwachtingen en budgetten. Dit helpt bij het vermijden van onverwachte kosten en zorgt voor een betere afstemming van IT-resources op zakelijke behoeften.

- `SKU` (Stock Keeping Unit) zorgt ervoor dat je weet welke rescources je krijgt voor welke prijs. Er zijn verschillende modellen beschikbaar afhankelijk van je behoeften. Je weet dus vooraf wat je kan verwachten.

- `Templates` gebruiken in je deployments zorgt ervoor dat je altijd dezelfde omgeving krijgt en dat er geen onverwachte verschillen zijn tussen verschillende implementaties. Automatiseren is hier de sleutel.

`Performance` predictability draait om het garanderen dat een applicatie consistent en betrouwbaar presteert, ongeacht hoeveel gebruikers of verkeer er is. Cloudconcepten zoals autoscaling, load balancing en high availability spelen hierin een cruciale rol.
Wanneer de vraag plots stijgt, kan de cloudomgeving automatisch opschalen zodat er voldoende resources beschikbaar zijn. Daalt de belasting daarna weer, dan kan de omgeving afschalen om kosten te besparen zonder aan prestaties in te boeten. Hierdoor blijft de gebruikerservaring stabiel, zelfs tijdens pieken of onverwachte workloads.

`Cost` predictability draait om het beheersen en voorspellen van uitgaven in een cloudomgeving. Cloudproviders bieden vaak flexibele prijsmodellen, zoals pay-as-you-go, waarbij je alleen betaalt voor wat je daadwerkelijk gebruikt. Dit kan echter leiden tot onverwachte kosten als resources niet goed worden beheerd. Bij Azure kan je bijvoorbeeld budgetten instellen en waarschuwingen ontvangen wanneer je uitgaven een bepaald niveau bereiken. Daarnaast kun je gebruikmaken van kostenbeheer- en optimalisatietools zoals bijvoorbeeld Azure Cost Management om inzicht te krijgen in je uitgavenpatronen en mogelijkheden voor kostenbesparing te identificeren.

### Security & Governance

Op cloudproviders zoals Azure kan je gebruimaken van voorafingestelde templates en zorg je ervoor dat je uitgerolde rescources voldoen aan zowel bedrijfstandaarden als wettelijke vereisten. Wanneer deze standaarden veranderen kan je centraal en consistent alle bestaande rescources updaten om aan de nieuwe standaarden te voldoen. Cloud-gebaseerde auditing helpt om afwijkingen te detecteren en geeft duidelijke aanbevelingen om niet conforme resources te corrigeren.
Afhankelijk van het gekozen cloud model kan dit zelfs automatisch worden toegepast.

Op de kant van security kan je een cloudoplossing vinden die bij je security-beleid past.

## Veelgebruikte cloud termen

Data
APP
Runtime
OS
HIV
COMPUTE
NETWORK
Storage