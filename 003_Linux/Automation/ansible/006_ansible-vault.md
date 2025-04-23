# Ansible Vault

Ansible Vault wordt gebruikt om gevoelige gegevens, zoals wachtwoorden, API-sleutels en certificaten, veilig op te slaan en te beheren in versleutelde bestanden.

---

## Veelgebruikte Commando's

### Een bestand versleutelen
```bash
ansible-vault encrypt <bestand>
```
Versleutelt een bestand zodat het alleen toegankelijk is met een wachtwoord.

### Een bestand ontsleutelen
```bash
ansible-vault decrypt <bestand>
```
Ontsleutelt een bestand en verwijdert de versleuteling.

### Een bestand bewerken
```bash
ansible-vault edit <bestand>
```
Opent een versleuteld bestand in een teksteditor voor bewerking.

### Een bestand opnieuw versleutelen met een nieuw wachtwoord
```bash
ansible-vault rekey <bestand>
```
Wijzigt het wachtwoord van een versleuteld bestand.

### Een playbook uitvoeren met een versleuteld bestand
```bash
ansible-playbook <playbook.yml> --ask-vault-pass
```
Voert een playbook uit en vraagt om het wachtwoord voor de versleutelde bestanden.

---

## Voorbeeld: Variabelen Versleutelen

### Versleuteld Bestand Maken
```bash
ansible-vault create vars.yml
```
Maakt een nieuw versleuteld bestand en opent het in een teksteditor.

### Voorbeeldinhoud van `vars.yml`
```yaml
# filepath: vars.yml
---
ansible_user: admin
ansible_password: geheimwachtwoord
```

---

## Voorbeeld: MySQL-server configureren met Vault

### Stap 1: Maak een versleuteld variabelenbestand
```bash
ansible-vault create mysql_vars.yml
```

### Inhoud van `mysql_vars.yml`
```yaml
# filepath: mysql_vars.yml
---
mysql_root_password: geheimwachtwoord
mysql_user: db_user
mysql_user_password: db_user_wachtwoord
```

---

### Stap 2: Playbook voor MySQL-configuratie

```yaml
# filepath: playbooks/mysql_setup.yml
---
- name: Configureer MySQL-server
  hosts: database
  become: true

  vars_files:
    - mysql_vars.yml  # Laad versleutelde variabelen

  tasks:
    - name: Installeer MySQL-server
      ansible.builtin.yum:
        name: mysql-server
        state: present

    - name: Start en activeer MySQL-service
      ansible.builtin.service:
        name: mysqld
        state: started
        enabled: true

    - name: Stel root wachtwoord in
      ansible.builtin.mysql_user:
        name: root
        host_all: true
        password: "{{ mysql_root_password }}"
        login_unix_socket: /var/lib/mysql/mysql.sock

    - name: Maak een nieuwe databasegebruiker aan
      ansible.builtin.mysql_user:
        name: "{{ mysql_user }}"
        password: "{{ mysql_user_password }}"
        priv: "*.*:ALL"
        state: present
```

---

### Stap 3: Voer het playbook uit
Gebruik het volgende commando om het playbook uit te voeren en de Vault-wachtwoordprompt te activeren:
```bash
ansible-playbook playbooks/mysql_setup.yml --ask-vault-pass
```

> **Tip:** Gebruik `--vault-password-file` om het wachtwoord automatisch te laden:
```bash
ansible-playbook playbooks/mysql_setup.yml --vault-password-file /path/to/vault_password_file
```

---

## Voorbeeld: MySQL-configuratie via Roles

### Stap 1: Role aanmaken
Maak een nieuwe role aan voor MySQL-configuratie:
```bash
ansible-galaxy role init mysql
```

### Stap 2: Role Structuur
De role structuur ziet er als volgt uit:
```plaintext
roles/
├── mysql/
│   ├── tasks/
│   │   └── main.yml
│   ├── vars/
│   │   └── main.yml
│   ├── defaults/
│   │   └── main.yml
│   ├── handlers/
│   │   └── main.yml
│   ├── meta/
│   │   └── main.yml
│   └── files/
```

---

### Stap 3: Role Configuratie

#### `roles/mysql/vars/main.yml`
```yaml
# filepath: roles/mysql/vars/main.yml
---
# Deze variabelen worden versleuteld met Ansible Vault
mysql_root_password: geheimwachtwoord
mysql_user: db_user
mysql_user_password: db_user_wachtwoord
```

Versleutel dit bestand met:
```bash
ansible-vault encrypt roles/mysql/vars/main.yml
```

---

### Stap 4: Playbook met Role en Vault

```yaml
# filepath: playbooks/mysql_setup_with_roles.yml
---
- name: Configureer MySQL-server via Role
  hosts: database
  become: true

  vars_files:
    - roles/mysql/vars/main.yml  # Laad versleutelde variabelen

  roles:
    - mysql
```

---

### Stap 5: Voer het Playbook uit
Gebruik het volgende commando om het playbook uit te voeren:
```bash
ansible-playbook playbooks/mysql_setup_with_roles.yml --ask-vault-pass
```

> **Tip:** Gebruik `--vault-password-file` om het wachtwoord automatisch te laden:
```bash
ansible-playbook playbooks/mysql_setup_with_roles.yml --vault-password-file /path/to/vault_password_file
```

---

## Voorbeeld: Gebruik van een Wachtwoordbestand

### Stap 1: Maak een wachtwoordbestand
Maak een bestand aan dat het wachtwoord bevat:
```bash
echo "mijnVaultWachtwoord" > /path/to/vault_password_file
```

Zorg ervoor dat het bestand alleen leesbaar is voor de eigenaar:
```bash
chmod 600 /path/to/vault_password_file
```

---

### Stap 2: Gebruik het wachtwoordbestand bij het uitvoeren van een playbook
Gebruik de `--vault-password-file` optie om het wachtwoord automatisch te laden:
```bash
ansible-playbook playbooks/mysql_setup_with_roles.yml --vault-password-file /path/to/vault_password_file
```

> **Opmerking:** Zorg ervoor dat het wachtwoordbestand niet wordt opgenomen in versiebeheer door het toe te voegen aan `.gitignore`:
```plaintext
/path/to/vault_password_file
```

---

## Tips en Best Practices

- **Gebruik een wachtwoordbestand:**  
  Maak een bestand met het wachtwoord en gebruik de `--vault-password-file` optie om het wachtwoord automatisch te laden:
  ```bash
  ansible-playbook <playbook.yml> --vault-password-file <wachtwoordbestand>
  ```

- **Beveilig het wachtwoordbestand:**  
  Zorg ervoor dat het wachtwoordbestand niet wordt gedeeld of opgenomen in versiebeheer (bijvoorbeeld door `.gitignore` te gebruiken).

- **Meerdere Vaults:**  
  Gebruik verschillende Vault-wachtwoorden voor verschillende omgevingen (bijvoorbeeld productie en test).

- **Controleer de versleuteling:**  
  Controleer of een bestand correct is versleuteld:
  ```bash
  ansible-vault view <bestand>
  ```

---

## Veelvoorkomende Fouten

- **Vergeten wachtwoord:**  
  Als je het wachtwoord vergeet, kun je het versleutelde bestand niet herstellen. Zorg ervoor dat je wachtwoorden veilig opslaat.

- **Onjuist gebruik van `--ask-vault-pass`:**  
  Vergeet niet deze optie toe te voegen bij het uitvoeren van playbooks met versleutelde bestanden.
