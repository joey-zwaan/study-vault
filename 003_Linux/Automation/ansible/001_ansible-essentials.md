# Ansible

Ansible is een open-source automatiseringstool die wordt gebruikt voor:
- Configuratiebeheer
- Applicatiedeployment
- Taakautomatisering
- Orkestratie

> **Belangrijk:** Het is essentieel om de manuele handelingen goed te kennen voordat je automatiseert. Houd procedures zorgvuldig bij.

---

## Control Node

De Control Node draait uitsluitend op een Linux-systeem (Windows wordt niet ondersteund). Het bevat de Ansible-software en wordt gebruikt voor het beheren van 'hosts' of 'managed nodes'. 

> **Opmerking:** Op de managed nodes zelf is geen extra software nodig, aangezien Ansible agentless werkt. Standaard wordt SSH gebruikt als communicatiemiddel.

### Installatiemodi
- **Ansible-core:** Enkel basismodules.
- **Ansible-community:** Grotere installatie, core + bijkomende modules.

> **Tip:** Controleer de versie van je Ansible voordat je documentatie opzoekt.

---

## Inventory

- Inventories bevatten de lijst van te beheren hosts.
- Structurering mogelijk per functie of omgeving.
- Gebruik van geneste groepen en standaardgroepen (`all`, `ungrouped`).

In deze cursus maken we gebruik van de **INI-plugin** om een lokale inventory aan te leggen. Hoewel er nadelen zijn ten opzichte van YAML inventories, biedt de hogere leesbaarheid een groot voordeel.

### Standaard Inventory

De standaard inventory bevindt zich in:
```
/etc/ansible/hosts
```

### Gerelateerde commando's
- `man 1 ansible-inventory`: RTFM
- `ansible-doc -t inventory -l`: Lijst met inventory plugins.
- `ansible-doc -t inventory ini`: Documentatie over de INI-plugin.
- `ansible-inventory --list`: Output alle hostinformatie in JSON-formaat.
- `ansible-inventory --graph --vars`: Output als graph, inclusief toegepaste variabelen.

---

### Opbouw van een INI Inventory

Een inventory bestaat uit:
- **Groepen**
- **Hosts**
- (Optioneel) Variabelen die van toepassing zijn op de groep of individuele hosts.

#### Voorbeeld: Ad-hoc Commands
```
[exercises]
gallie ansible_host=gallie.snwb.howest.be ansible_user=alvin.demeyer
```

In dit voorbeeld heeft de groep `[exercises]` één host genaamd `gallie`.

---

### Groepen

Een inventory bevat meestal meerdere groepen. De groepsnaam wordt tussen vierkante haakjes `[]` geplaatst. Hieronder een voorbeeld waarbij hosts worden opgedeeld op basis van hun functie:

```
[howest:children]
howest_gitlab
howest_gitlab_runners
howest_opnsense

# --------------------
# Subgroepen
# --------------------

[howest_gitlab]
gitlab0.ti.howest.be         
gitlab-backup.ti.howest.be           
monitor.ti.howest.be
project-i.ti.howest.be
project-ii.ti.howest.be
sonarqube.ti.howest.be

[howest_gitlab_runners]
ada-lovelace.ti.howest.be
brendan-eich.ti.howest.be
charles-anthony-richard-hoare.ti.howest.be
danese-cooper.ti.howest.be
edsger-dijkstra.ti.howest.be

[howest_opnsense]
rudy.ti.howest.be
```

In dit voorbeeld zijn er vier groepen:
1. De groep `[howest:children]` bevat drie subgroepen.
2. Subgroepen: `[howest_gitlab]`, `[howest_gitlab_runners]`, en `[howest_opnsense]`.

> **Opmerking:** De speciale groep `[all]` verwijst naar alle hosts in de inventory.

---

### Hosts

In het eerste voorbeeld bevat de term `gallie` niet voldoende informatie om die host te kunnen bereiken, tenzij je `~/ssh/config` een entry bevat. Daarom is het nodig de FQDN of het IP-adres op te geven als `ansible_host` variabele. Ook de `ansible_user` kan als variabele worden meegegeven (of als 'User' in `~/.ssh/config`).

---

### Variabelen

Vaak zullen verschillende hosts onder dezelfde groep identieke instellingen nodig hebben. Enkele voorbeelden van nuttige variabelen:
- `ansible_user`: De gebruiker waarmee Ansible zal verbinden.
- `ansible_ssh_private_key_file`: De locatie van de SSH key waarmee Ansible zal verbinden.
- `ansible_ssh_port`: De SSH poort waarop Ansible zal verbinden.
- `ansible_become_user`: De gebruikersnaam die nodig is voor privilege elevation zoals met sudo.
- `ansible_become_password`: Het wachtwoord dat nodig is voor privilege elevation.

#### Groepsvariabelen
Variabelen kunnen in je inventory onder een aparte groep worden onderverdeeld door de modifier `:vars` aan de groepsnaam toe te voegen. Bijvoorbeeld:

```
[howest_opnsense:vars]
ansible_user=root
```

Variabelen in deze groep zijn van toepassing op alle hosts in `[howest_opnsense]`.

#### Hostspecifieke variabelen
Wil je een variabele aan één host toekennen, dan dien je de variabele ernaast weer te geven, zoals in het voorbeeld bij `gallie`.

---

### Opsplitsen van een Inventory

Meerdere inventory files kunnen via de command line als bron opgegeven worden via de `-i` parameter:
```
ansible-playbook install_fortune.yaml -i testing -i productie
```

Je kan ook een directory als inventory bron gebruiken. In dat geval zal Ansible alle bestanden erin alfabetisch bundelen tot één inventory. Bijvoorbeeld:

```
[defaults]
inventory = ~/ansible/inventory
```

> **Let op:** Bij het gebruik van een directory zal Ansible bestanden met de extensie `.ini` negeren! Gebruik gerust `.ini` bestanden, maar laat de extensie achterwege.

---

### Group_vars en Host_vars

Groeps- en hostvariabelen hoeven niet noodzakelijk in de inventory file zelf te staan. Je kan deze plaatsen in de standaard directories `group_vars` en `host_vars`. De locatie van deze directories is steeds relatief tot je inventory file. 

Bijvoorbeeld, als je inventory `~/ansible/hosts.ini` is, dan gaat het over `~/ansible/group_vars` en `~/ansible/host_vars`. Bestanden in deze directories zijn YAML files. Ze starten met drie dashes (`---`) en variabelen moeten de YAML syntax hebben (gebruik `:` in plaats van `=`).

#### Voorbeeld: Group_vars
Bestand: `~/ansible/inventory/group_vars/howest_gitlab.yaml`
```yaml
---
ansible_python_interpreter: /usr/bin/python3
ansible_user: root
```

