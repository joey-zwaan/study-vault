# Ansible Ad-Hoc Commando's

## Ansible Command Options

### De `-a` Optie
De `-a` optie in Ansible wordt gebruikt om argumenten door te geven aan de module die wordt uitgevoerd. Bijvoorbeeld, het specificeert het commando of de parameters voor de `command` module, zoals `hostnamectl` in `ansible localhost -a 'hostnamectl'`.

### De `-m` Optie
De `-m` optie in Ansible specificeert welke module moet worden gebruikt. Als je geen module opgeeft, wordt standaard de `command`-module gebruikt. Bijvoorbeeld, `-m ansible.builtin.command` geeft expliciet aan dat de `command`-module moet worden gebruikt.

## Commando: ansible -m ping localhost

```bash
# Test de connectiviteit met localhost met behulp van Ansible
ansible -m ping localhost
```

Dit commando gebruikt de `ping`-module om de connectiviteit met de `localhost` te testen. Het controleert of Ansible verbinding kan maken met de doelmachine en opdrachten kan uitvoeren. Bij succes bevestigt dit dat de Ansible-controleknoop kan communiceren met de doelknoop.

## Commando: `ansible -m setup localhost`

```bash
# Haal systeeminformatie op van localhost met behulp van Ansible
ansible -m setup localhost
```

Dit commando gebruikt de `setup`-module van Ansible om gedetailleerde systeeminformatie (facten) van de `localhost` op te halen. Deze facten bevatten gegevens zoals netwerkconfiguratie, besturingssysteemdetails, en hardware-informatie. Het is handig voor het verzamelen van diagnostische informatie of het voorbereiden van geautomatiseerde taken.

## Commando: `ansible localhost -a 'hostnamectl'`

```bash
# Voer het commando 'hostnamectl' uit op localhost met behulp van Ansible
ansible localhost -a 'hostnamectl'
ansible -m ansible.builtin.command localhost -a 'hostnamectl'
```

Dit commando gebruikt Ansible om het `hostnamectl`-commando uit te voeren op de `localhost`. Het `hostnamectl`-commando geeft informatie over de hostnaam en het besturingssysteem, zoals de statische en dynamische hostnaam, het besturingssysteemtype, en de kernelversie. Dit is nuttig voor het snel ophalen van hostnaam- en systeemdetails.

### Verschillen tussen de twee commando's

- **Eerste commando**: Dit commando gebruikt impliciet de standaardmodule van Ansible, namelijk de `command`-module. Hierdoor hoeft de module niet expliciet te worden vermeld.
- **Tweede commando**: Hier wordt de `command`-module expliciet gespecificeerd met `-m ansible.builtin.command`. Dit kan handig zijn voor duidelijkheid of wanneer je een specifieke module wilt gebruiken.

## Commando: `ansible-doc -t module ansible.builtin.command`

```bash
# Bekijk documentatie over de ingebouwde command-module in Ansible
ansible-doc -t module ansible.builtin.command
```

Dit commando toont documentatie over de `command`-module, inclusief functionaliteit, parameters en voorbeelden. Handig om snel te begrijpen hoe de module werkt.




