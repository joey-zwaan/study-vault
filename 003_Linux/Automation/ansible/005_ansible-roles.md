# Opbouw van een Role

Een role bestaat uit een vooraf bepaalde structuur die toelaat om automatisch bestanden, tasks, handlers en andere Ansible-objecten in te laden. Dit gebeurt automatisch zolang je de opgelegde mappenstructuur respecteert.

---

## Structuur van een Role

```plaintext
roles/
├── common/               # Alles hieronder stelt een role voor
│   ├── tasks/            # Taken die uitgevoerd worden
│   │   └── main.yml      # Bestand met alle taken
│   ├── handlers/         # Handlers die opgeroepen worden door taken
│   │   └── main.yml      # Bestand met handlers
│   ├── templates/        # Templates in Jinja2-formaat
│   │   └── ntp.conf.j2   # Voorbeeld van een templatebestand
│   ├── files/            # Bestanden om te gebruiken in taken
│   │   ├── bar.txt       # Tekstbestand om te kopiëren
│   │   └── foo.sh        # Scriptbestand om uit te voeren
│   ├── vars/             # Variabelen gekoppeld aan de role
│   │   └── main.yml      # Variabelenbestand
│   ├── defaults/         # Lagere prioriteitsvariabelen
│   │   └── main.yml      # Standaardvariabelenbestand
│   ├── meta/             # Role dependencies
│   │   └── main.yml      # Metadata van de role
│   ├── library/          # Custom modules
│   ├── module_utils/     # Custom module utilities
│   └── lookup_plugins/   # Custom plugins zoals lookup
├── webtier/              # Tweede role met dezelfde structuur
├── monitoring/           # Derde role met dezelfde structuur
└── fooapp/               # Vierde role met dezelfde structuur
```

> **Tip:** Gebruik het volgende commando om een nieuwe role aan te maken:
```bash
ansible-galaxy role init common
```

---

## Uitleg van Submappen

- **`tasks/`**: Bevat één of meerdere YAML-bestanden met de stappen die uitgevoerd worden door de role.
- **`handlers/`**: Taken die enkel uitgevoerd worden wanneer ze opgeroepen worden vanuit andere taken.
- **`templates/`**: Bevat Jinja2-templatebestanden die gebruikt worden in taken.
- **`files/`**: Bestanden die gekopieerd of uitgevoerd worden op de hosts.
- **`vars/`**: Variabelen die specifiek zijn voor de role.
- **`defaults/`**: Standaardvariabelen met lagere prioriteit.
- **`meta/`**: Bevat metadata zoals role dependencies.
- **`library/`**: Custom modules die door de role gebruikt worden.
- **`module_utils/`**: Custom utilities voor modules.
- **`lookup_plugins/`**: Custom plugins zoals lookup.

---

## Voorbeeld: Gebruik van Handlers

### Handler Configuratie

```yaml
# filepath: roles/common/handlers/main.yml
- name: Restart SSH service
  ansible.builtin.service:
    name: sshd
    state: restarted
```

### Task Configuratie

```yaml
# filepath: roles/common/tasks/main.yml
- name: Copy SSH configuration file
  ansible.builtin.copy:
    src: files/sshd_config
    dest: /etc/ssh/sshd_config
  notify: Restart SSH service  # Roept de handler aan
```

### Uitleg

Met bovenstaande configuratie zal de handler `Restart SSH service` opgeroepen worden na het kopiëren van het bestand `sshd_config` uit de `files/` map naar de bestemming `/etc/ssh/sshd_config` op de host.

```plaintext
Flow:
1. De taak kopieert het bestand `sshd_config`.
2. De taak roept de handler `Restart SSH service` aan.
3. De handler herstart de SSH-service.
```

---

## Playbook met Roles

```yaml
# filepath: playbooks/webserver.yml
- name: Install roles for a webserver
  hosts: web
  become: true

  roles:
    - common
    - webserver
    - database
```