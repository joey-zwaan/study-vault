## Filosofie van Linux

De linux filosofie gaat over eenvoud , modulariteit en openheid. Het beveelt aan om single-purpose programs te gebruiken die 1 taak goed kunnen uitvoeren.

**Principes**

- Everything is a file
--> Alle configuratiebestanden voor de OS zijn 
bewaard in 1 of meer textbestanden

- Small, single-purpose programs
--> Linux bied verschillende tools aan waar we mee werken maar die kan gecombineerd worden met andere

- Ability to chain program together to perform complex task
--> De integratie en combinatie van verschillende tools stellen ons in staat grote en moeilijke taken uit te voeren.

- Avoid captive user interfaces
--> Ontworpen om voornamelijk met de shell te werken zodat de user meer controle heeft over de OS

- Configuration data stored in a text file
--> Voorbeeld is /etc/passwd file , het bewaard alle geregistreerde gebruikers op het systeem

**Componenten**



## /etc/motd - Message of the Day

- `/etc/motd` (Message of the Day) is een bestand dat automatisch getoond wordt bij het inloggen via een terminal of SSH.
- Wordt vaak gebruikt om meldingen, systeeminfo of waarschuwingen te tonen.
- Beheerders kunnen dit bestand handmatig aanpassen of automatisch bijwerken via tools zoals Ansible.
- Sommige systemen (zoals Ubuntu) gebruiken `/etc/update-motd.d/` voor dynamische MOTD's.
