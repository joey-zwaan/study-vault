## Windows Sessions

**Interactive**

Een interactieve sessie word door een gebruiker gestart die probeert in te loggen op een lokaal of domain account door zijn credentials in te geven. 

**Non-interactive**

Deze accounts hebben geen login credentials nodig.

- Local Systel Account
- Local Service Account
- Network Service Account
  
Deze worden meestal door het Windows operating system gebruikt om automatisch services the starten en te stoppen zonder interactie van de gebruiker.

<img src="/assets/systemaccounts.png" alt="share" width="600">


**GUI**

Dit is uitgevonden in de late jaren 70 om het makkelijker te maken voor gebruikers om met de OS te werken. Niet iedereen zal het makkelijk vinden om via de command line te werken.

Windows gebruikers hoeven zelfs nooit via command line te werken, de GUI verzorgd alles en neemt dit uit handen van de gebruiker.

**RDP**

Proprietary protocol van windows.
Dit zorgt ervoor dat een user remote met een windows systeem can connecteren via een GUI.

port 3389

RDP opent een dedicated port en als een user verbind met RDP is het alsof ze zelf achter de computer zouden zitten.

**Windows Command Line**

Geeft een gebruiker meer controle over zijn systeem en is ook ideaal voor scripting. Ditkan gebruikt worden voor dagelijkse administratieve taken en troubleshooting taken.


**CMD**

cmd.exe word gebruikt om commando's uit te voeren. Gebruikers kunnen een commando zoals ipconfig uitvoeren of meer geavanceerde taken zoals scripts of batch files.

win+r cmd
Opent de commandline en met "help" kan je zien welke commando's er allemaal zijn.


**Powershell**

Is een shell die ontwikkeld is door microsoft gericht naar systeembeheerders. Het heeft een interactieve promt en een sterk scripting environment. Het is gebouwd bovenop het .NET framework wat word gebruikt voor applicaties op windows te bouwen.

Powershell geeft directe toegang tot het bestandsysteem en een groot deel van de commando's zijn hetzelfde als een cmd shell.

**Execution Policy**


Soms zien we dat het systeem weigerd van een script te draaien. Dit is dankzij een security feature genaamd "execution policy" die voorkomt dat gevaarlijke scripts zomaar gerunt kunnen worden.

Om een powershell script te runnen moet je de executionpolicy aanpassen.
Het veiligste is om dit enkel voor de sessie te doen waar je het voor nodig hebt

powershell -ExecutionPolicy Bypass -File .\add_ou_opdracht1.ps1


<img src="/assets/execution-policy.png" alt="share" width="600">


