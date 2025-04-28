# Ansible Built-in Modules

---

## Voorbeeldmodule: `ansible.builtin.file`

De `ansible.builtin.file` module wordt gebruikt om bestanden en directories te beheren.

### Mogelijke `state`-waarden:
- **`directory`**: Maak een directory aan.
- **`touch`**: Maak een leeg bestand aan.
- **`link`**: Maak een symlink aan.
- **`absent`**: Verwijder een bestand of directory als deze bestaat.

### Voorbeelden:
```yaml
- name: Maak een directory aan
  ansible.builtin.file:
    path: /path/to/directory
    state: directory

- name: Maak een leeg bestand aan
  ansible.builtin.file:
    path: /path/to/file.txt
    state: touch

- name: Maak een symlink aan
  ansible.builtin.file:
    src: /path/to/target
    dest: /path/to/symlink
    state: link

- name: Verwijder een bestand of directory
  ansible.builtin.file:
    path: /path/to/remove
    state: absent
```

---

## Voorbeeldmodule: `ansible.builtin.template`

De `ansible.builtin.template` module wordt gebruikt om een Jinja2-template naar een remote host te kopiëren.

### Voorbeeld:
```yaml
- name: Stel standaard MOTD in
  ansible.builtin.template:
    src: motd.j2
    dest: /etc/motd
    owner: root
    group: root
    mode: '0644'
  become: true
```

### Uitleg:
- **`src`**: Het pad naar het Jinja2-templatebestand (bijvoorbeeld `motd.j2`).
- **`dest`**: De locatie waar het bestand op de remote host wordt geplaatst.
- **`owner` en `group`**: De eigenaar en groep van het bestand.
- **`mode`**: De bestandsrechten (bijvoorbeeld `0644`).
- **`become: true`**: Zorgt ervoor dat de taak met verhoogde rechten wordt uitgevoerd.

> **Let op:** Zorg ervoor dat het bestand `motd.j2` zich in de `/templates` map van je role bevindt.

---

### Tips en Best Practices

1. **Gebruik duidelijke paden**: Zorg ervoor dat de `src`- en `dest`-paden correct zijn.
2. **Test lokaal**: Test je playbook in een testomgeving voordat je het in productie gebruikt.
3. **Gebruik variabelen in templates**: Maak je templates dynamisch door gebruik te maken van Jinja2-variabelen, bijvoorbeeld:
   ```plaintext
   ###################################################
#            Welcome to {{ ansible_hostname }}            #
###################################################

Hostname:           {{ ansible_hostname }}
Operating System:   {{ ansible_distribution }} {{ ansible_distribution_version }}
Current Date:       {{ ansible_date_time.date }} {{ ansible_date_time.time }}
Load Averages:      1m: {{ ansible_loadavg['1m'] }}, 5m: {{ ansible_loadavg['5m'] }}, 15m: {{ ansible_loadavg['15m'] }}

Memory:
  Total RAM:        {{ ansible_memtotal_mb }} MB
  Free RAM:         {{ ansible_memfree_mb }} MB
  Used RAM:         {{ ansible_memtotal_mb - ansible_memfree_mb }} MB}}!
   ```
4. **Beveilig gevoelige gegevens**: Gebruik Ansible Vault om gevoelige gegevens in templates te beschermen.