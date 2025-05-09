# Opbouw van een Role

Een role in Ansible heeft een vooraf bepaalde structuur die automatisch bestanden, taken, handlers en andere objecten inlaadt, zolang de opgelegde mappenstructuur wordt gerespecteerd.

---

## Structuur van een Role

De basisstructuur van een role ziet er als volgt uit:

```plaintext
roles/
├── common/               # Een role
│   ├── tasks/            # Taken
│   │   └── main.yml      # Takenbestand
│   ├── handlers/         # Handlers
│   │   └── main.yml      # Handlersbestand
│   ├── templates/        # Jinja2-templates
│   │   └── ntp.conf.j2   # Voorbeeld templatebestand
│   ├── files/            # Bestanden
│   │   ├── bar.txt       # Tekstbestand
│   │   └── foo.sh        # Scriptbestand
│   ├── vars/             # Variabelen
│   │   └── main.yml      # Variabelenbestand
│   ├── defaults/         # Standaardvariabelen
│   │   └── main.yml      # Standaardvariabelenbestand
│   ├── meta/             # Metadata
│   │   └── main.yml      # Metadata van de role
│   ├── library/          # Custom modules
│   ├── module_utils/     # Custom module utilities
│   └── lookup_plugins/   # Custom plugins
├── webtier/              # Tweede role
├── monitoring/           # Derde role
└── fooapp/               # Vierde role
```

> **Tip:** Gebruik het volgende commando om een nieuwe role aan te maken:
```bash
ansible-galaxy role init common
```

---

## Uitleg van Submappen

Hieronder een overzicht van de belangrijkste submappen binnen een role:

- **`tasks/`**: Bevat YAML-bestanden met de stappen die uitgevoerd worden.
- **`handlers/`**: Taken die enkel uitgevoerd worden wanneer ze expliciet worden aangeroepen.
- **`templates/`**: Jinja2-templatebestanden die gebruikt worden in taken.
- **`files/`**: Bestanden die gekopieerd of uitgevoerd worden op de hosts.
- **`vars/`**: Variabelen specifiek voor de role.
- **`defaults/`**: Standaardvariabelen met lagere prioriteit.
- **`meta/`**: Metadata zoals role dependencies.
- **`library/`**: Custom modules die door de role gebruikt worden.
- **`module_utils/`**: Custom utilities voor modules.
- **`lookup_plugins/`**: Custom plugins zoals lookup.

---

## Organiseren van Variabelen in `defaults/main/`

In plaats van één enkel `defaults/main.yml`-bestand te gebruiken, kun je variabelen beter organiseren door meerdere YAML-bestanden in een `defaults/main/`-map te plaatsen. Ansible laadt automatisch alle `.yml`-bestanden in deze map.

### Voorbeeldstructuur

```plaintext
roles/my-role/
└── defaults/
    └── main/
        ├── first_file.yml
        ├── second_file.yml
        └── subdir_1/
            └── foo.yml
        └── subdir_2/
            └── bar.yml
```

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

### Flow

1. De taak kopieert het bestand `sshd_config` naar `/etc/ssh/sshd_config`.
2. De taak roept de handler `Restart SSH service` aan.
3. De handler herstart de SSH-service.

---

## Playbook met Roles

Een playbook kan meerdere roles bevatten. Hier is een voorbeeld:

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

---

Met deze structuur en voorbeelden kun je eenvoudig Ansible-roles opzetten en beheren.