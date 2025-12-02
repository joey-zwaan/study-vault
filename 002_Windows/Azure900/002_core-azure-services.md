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

Een resource group is een container die gerelateerde Azure-resources groepeert. Dit maakt het eenvoudiger om resources te beheren. Het is een logische groepering, geen fysieke. Er kunnen resources uit verschillende regio's in dezelfde resource group zitten. Er kunnen ook verschillende types van resources in dezelfde resource group zitten.

> Als je klaar bent met een project kan je de hele resource group verwijderen zodat alle resources in één keer verwijderd worden en er geen overbodige kosten meer gemaakt worden.

### Rescource Group management

Door rescource groups te gebruiken kan je het beheer van je rescources beter organiseren. Meestal als de rescources dezelfde levenscyclus hebben (bijvoorbeeld een applicatie en de bijbehorende database) is het makkelijk om zo Role based Access Control (RBAC) toe te passen op de hele groep in plaats van op individuele resources. Je kan ook eenvoudiger Policy's toepassen op een hele groep.
In een rescource group kan je ook een maximum budget instellen. Dit helpt om de kosten onder controle te houden en onverwachte uitgaven te voorkomen. Dit wordt automatisch toegepast ook op nieuwe resources die aan de groep worden toegevoegd.

### Rescource groups tags

Tags zijn labels die je kunt toewijzen aan Azure-resources en resource groups om ze te organiseren en categoriseren. Tags bestaan uit sleutel-waarde paren, bijvoorbeeld "Environment: Production" of "Department: Finance". Dit maakt het makkelijker om resources te vinden, beheren en rapporteren op basis van specifieke criteria. Tags worden niet inheerit door resources binnen een resource group, je moet ze afzonderlijk toepassen op elke resource als je dat wilt. Je kan het op een hele resource group toepassen maar dat betekent niet dat alle resources automatisch de tags krijgen.

## Subscriptions

Een subscriptie kunnen we bekijken als een overeenkomst tussen jou en Microsoft om Azure-diensten te gebruiken. Het volgt een bepaald factureringsmodel, zoals pay-as-you-go of een maandelijks abonnement. Elke subscriptie heeft een uniek ID en is gekoppeld aan een account.

Azure gebruikt Azure Active Directory (AAD) voor het beheren van toegang tot resources binnen een subscriptie. Je kunt verschillende rollen en machtigingen toewijzen aan gebruikers en groepen om de toegang te beheren. Je kan een budget instellen en een policy toepassen om kosten te beheersen en naleving van regels te waarborgen.


### Meerdere Subscriptions

We kunnen verschillende subscripties hebben voor verschillende doeleinden, zoals ontwikkeling, testen en productie. Dit helpt bij het scheiden van omgevingen en het beheren van kosten. We kunnen ook subscripties gebruiken om verschillende projecten of teams binnen een organisatie te beheren. Op een test subscriptie gaan we meer rechten geven aan ontwikkelaars dan op een productie subscriptie.

> Rescource groups leven binnen een subscriptie. Je kan geen rescource group maken die meerdere subscripties omvat.
