## Ansible  

Ansible is een open-source automatiseringstool die wordt gebruikt voor configuratiebeheer, applicatiedeployment, taakautomatisering en orkestratie

Het is heel belangrijk om de manuele handelingen goed te kennen voordat je automatiseert.
Dus goed bijhouden van procedures om iets te doen.

### Control node

Deze draait uitsluitend op een Linux-systeem (Windows wordt niet ondersteund). Het bevat de Ansible-software en wordt gebruikt voor het beheren van 'hosts' of 'managed nodes'. In combinatie met de inventory (de lijst van beheerde nodes) vormt dit de Control node. Op de managed nodes zelf is er geen extra software nodig, aangezien het agentless werkt. Bij default wordt SSH gebruikt als communicatiemiddel


Je hebt verschillende installatiemodus o.a :
- Ansible-core
enkel basismodules
- Ansible-community
grotere installatie, core + bijkomende modules

*--> Controleer de versie van je Ansible voordat je documentatie opzoekt.*
