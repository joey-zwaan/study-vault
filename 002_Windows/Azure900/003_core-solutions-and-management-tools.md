# Core Solutions and Management Tools

Azure geeft een breed scala aan oplossingen en beheertools die organisaties helpen bij het beheren van hun cloudinfrastructuur en -diensten. In deze sectie bespreken we enkele van de belangrijkste oplossingen en tools die beschikbaar zijn in Azure.

## Azure Management Tools

### Azure Portal

`Azure Portal` is een webgebaseerde interface waarmee gebruikers Azure-resources kunnen beheren en configureren. Het biedt een intuïtieve gebruikerservaring voor het uitvoeren van verschillende taken, zoals het maken van virtuele machines, het beheren van opslagaccounts en het configureren van netwerken. Het nadeel is dat het minder geschikt is voor geautomatiseerde taken en grootschalig beheer. Omdat je alles manueel moet doen kan je niet garandeerd zijn dat alles consistent is en opschalen is ook moeilijker.

`Mobile App`: Azure biedt ook een mobiele app waarmee gebruikers hun Azure-resources kunnen beheren vanaf hun mobiele apparaten. Het is heel handig om snel alerts te bekijken of eenvoudige beheertaken uit te voeren terwijl je onderweg bent.

> Dit zijn de grafische tools die je kan gebruiken om Azure resources te beheren.

### Azure CLI & PowerShell

`Azure CLI` en `Azure PowerShell` zijn commandoregeltools waarmee gebruikers Azure-resources kunnen beheren via scripts en geautomatiseerde processen. Deze tools zijn krachtig voor het uitvoeren van repetitieve taken, het implementeren van infrastructuur als code (IaC) en het integreren van Azure-beheer in CI/CD-pijplijnen. Powershell is cross-platform en kan dus ook op Linux en MacOS gebruikt worden.
Je vertelt deze tools wat je wil doen via commando's en parameters. Dit maakt het mogelijk om taken te automatiseren en te herhalen, wat vooral handig is in grote omgevingen. Dit is vooral om te automatiseren en scripts te maken.

> Geen enkele van deze opties is de best-practice way om rescources te imoplemeteren in Azure. De best-practice is om gebruik te maken van Infrastructure as Code (IaC) tools zoals ARM templates.

### Azure Advisor

`Azure Advisor` is een gratis service die aanbevelingen doet om de prestaties, beveiliging en kosten van Azure-resources te optimaliseren. Het analyseert de configuratie en het gebruik van resources en biedt inzichten om best practices te implementeren.

### ARM Templates

`Azure Resource Manager (ARM) Templates` zijn JSON-bestanden die de infrastructuur en configuratie van Azure-resources definiëren. Met ARM-templates kunnen gebruikers infrastructuur als code implementeren, waardoor het mogelijk is om resources consistent en herhaalbaar te creëren. Dit is de best-practice manier om resources te implementeren in Azure. Je kan deze templates gebruiken in combinatie met Azure CLI, PowerShell of via CI/CD-pijplijnen om geautomatiseerde implementaties uit te voeren.
Het is declaratief, wat betekent dat je beschrijft wat je wil in plaats van hoe je het moet doen. Azure zorgt er dan voor dat de resources worden aangemaakt zoals beschreven in de template. Als er iets veranderd is in de template, zal Azure alleen die veranderingen toepassen zonder de hele infrastructuur opnieuw te creëren.

Het krachtige aan deze tool is dat je deze files in je github repository kan steken en zo versiebeheer kan toepassen op je infrastructuur. Je kan het dan deployen via een CI/CD pipeline.

`Biceps`: Biceps is een nieuwe taal van Microsoft die het schrijven van ARM-templates vereenvoudigt. Het is een domeinspecifieke taal (DSL) die meer leesbaar en onderhoudbaar is dan traditionele JSON-templates. Het is typescript-achtig en ondersteunt functies zoals variabelen, loops en conditionals, waardoor het eenvoudiger wordt om complexe infrastructuren te definiëren.

`Terraform`: Terraform is een populaire open-source IaC-tool die door HashiCorp is ontwikkeld. Het ondersteunt meerdere cloudproviders, waaronder Azure. Met Terraform kunnen gebruikers infrastructuur definiëren in HCL (HashiCorp Configuration Language) en deze implementeren op verschillende platforms. Het biedt een consistente manier om infrastructuur te beheren, ongeacht de cloudprovider.

> ARM templates is de best-practice manier om Azure resources te implementeren. Biceps is een nieuwere en verbeterde manier om ARM templates te schrijven. Terraform is een third-party tool die ook veel gebruikt wordt voor IaC in multi-cloud omgevingen.

## Azure Monitor

Azure Monitor is het centrale platform binnen Azure voor het verzamelen,
analyseren en verwerken van telemetriegegevens. Het biedt inzicht in de
prestaties, beschikbaarheid en beveiliging van Azure-resources,
applicaties en identiteitsdiensten (Azure AD / Entra ID).

### Identiteit & Toegang (Azure AD / Entra ID)

Azure Monitor biedt monitoringmogelijkheden voor identity- en
toegangsactiviteiten via Azure AD/Entra ID-logs.

`Sign-in Logs`:

- Gedetailleerde informatie over alle aanmeldingspogingen.
- Inclusief succes/foutstatus, locatiegegevens, apparaatinformatie en gebruikte authenticatie.
- Geschikt voor het opsporen van verdachte activiteiten en het onderzoeken van beveiligingsincidenten.

`Audit Logs`:

- Registreert alle wijzigingsacties binnen Azure AD/Entra ID.
- Voorbeelden: gebruikersbeheer, groepswijzigingen, rolwijzigingen applicatieconfiguratie.
- Wordt gebruikt voor compliance, troubleshooting en auditing.

### Subscriptie-niveau

Azure Monitor verzamelt activiteiten op abonnementsniveau via `Activity Logs`:

- Registreert alle resource-beheeractiviteiten (aanmaken, wijzigen,verwijderen).
- Wordt automatisch door Azure gegenereerd.
- Geeft inzicht in *wie wat heeft gedaan* binnen de omgeving.
- Belangrijk voor troubleshooting, auditing en beveiligingscontrole

Azure Monitor biedt ook `Service Health`-meldingen:

- Incidenten, serviceonderbrekingen, advisories en gepland onderhoud.
- Gericht op de status van Azure-diensten, **niet** op jouw eigen resources.
- Helpt bij het identificeren of een probleem veroorzaakt wordt door Azure zelf.

### Resource-niveau

Azure Monitor biedt gedetailleerde monitoring voor individuele
Azure-resources.

`Metrics`:

- Getimede, numerieke waarden zoals CPU-gebruik, schijf-IO, latency of throughput.
- Geschikt voor dashboards, waarschuwingen en realtime inzichten.

`Logs`:

- Diepgaande, gestructureerde loggegevens.
- Vereist vaak een **Log Analytics Workspace**.
- Geschikt voor uitgebreide analyses en Kusto Query Language (KQL)-queries.

> Logs bestaan niet bij default. Je moet dit expliciet inschakelen door een Log Analytics Workspace aan te maken en je resources te configureren om logs daar naartoe te sturen.

### Diagnostics settings

`Diagnostics settings` in Azure Monitor stelt gebruikers in staat om diagnostische gegevens van Azure-resources te configureren en te verzenden naar verschillende bestemmingen voor analyse en bewaking. Er zijn 3 bestemmingen:

- **Log Analytics Workspace**: Hiermee kunnen gebruikers loggegevens en metrische gegevens naar een Log Analytics Workspace sturen voor geavanceerde analyse met behulp van Kusto Query Language (KQL). Dit is handig voor het uitvoeren van queries, het maken van dashboards en het opzetten van waarschuwingen op basis van de verzamelde gegevens. Er is retentie mogelijkheid tot 2 jaar.
- **Event Hub**: Hiermee kunnen gebruikers diagnostische gegevens naar een Event Hub sturen voor integratie met externe systemen of real-time verwerking. Dit is nuttig voor scenario's waarbij gegevens moeten worden doorgestuurd naar SIEM-systemen, data lakes of andere analysetools.
- **Storage Account**: Hiermee kunnen gebruikers diagnostische gegevens opslaan in een Azure Storage-account voor langdurige bewaring of latere analyse. Dit is handig voor compliance-doeleinden of wanneer gebruikers de gegevens offline willen analyseren.

Je wilt natuurlijk niet altijd alles in de gaten houden, het is mogelijk om alerts in te stellen op basis van bepaalde voorwaarden. Bijvoorbeeld als de CPU load van een VM boven een bepaalde waarde komt, of als er een bepaald aantal mislukte aanmeldingen is binnen een bepaalde tijdspanne. Deze alerts kunnen dan meldingen sturen via e-mail, SMS, of andere kanalen zoals webhooks of integraties met ITSM-tools. Dan kan je onderzoeken wat er aan de hand is.
Je kan ook actions koppelen aan deze alerts, zoals het automatisch schalen van resources, het starten van een Azure Function, of het uitvoeren van een Logic App.
