# Playbooks

## Standaard Structuur van Playbooks

```
my-ansible-project/
├── inventories/
│   └── production/
│       └── hosts
├── playbooks/
│   ├── deploy.yml
│   ├── setup.yml
├── roles/
│   └── myrole/
│       ├── tasks/
│       ├── handlers/
│       └── defaults/
├── group_vars/
│   └── all.yml
├── host_vars/
│   └── webserver.yml
└── ansible.cfg
```

---

## Commands

```bash
ansible-playbook -i /path/to/my_inventory_file -u my_connection_user -k -f 3 -T 30 -t my_tag -M /path/to/my_modules -b -K my_playbook.yml
```

**Beschrijving van de opties:**
- `-i`: Gebruikt `my_inventory_file` in het opgegeven pad voor de inventory.
- `-u`: Verbindt via SSH als `my_connection_user`.
- `-k`: Vraagt om een wachtwoord voor SSH-authenticatie.
- `-f`: Wijs 3 forks toe.
- `-T`: Stelt een timeout in van 30 seconden.
- `-t`: Voert alleen taken uit die gemarkeerd zijn met de tag `my_tag`.
- `-M`: Laadt lokale modules vanuit `/path/to/my/modules`.
- `-b`: Voert taken uit met verhoogde rechten (gebruik van `become`).
- `-K`: Vraagt de gebruiker om het `become`-wachtwoord.

---

### Veelgebruikte Ansible-commando's

- **Run een playbook voor alle groepen:**
  ```bash
  ansible-playbook -i hosts.ini <playbook-yml-file>
  ```

- **Run een playbook voor een specifieke groep:**
  ```bash
  ansible-playbook -i hosts.ini <playbook-yml-file> --limit <group-name>
  ```

- **Run een playbook voor een specifieke host:**
  ```bash
  ansible-playbook -i hosts.ini <playbook-yml-file> --limit <hostname>
  ```

- **Toon informatie over hosts:**
  ```bash
  ansible-playbook -i hosts.ini <playbook-yml-file> --list-hosts
  ```

- **Toon informatie over taken:**
  ```bash
  ansible-playbook -i hosts.ini <playbook-yml-file> --list-tasks
  ```

- **Controleer de syntax van een playbook:**
  ```bash
  ansible-playbook --syntax-check <playbook-yml-file>
  ```

---

## Voorbeelden Playbooks

### Voorbeeld 1: Ping met een Debug Optie

```yaml
---
- name: check if hosts are active
  hosts: test1  # Zorg ervoor dat 'test1' een gedefinieerde groep is in je inventorybestand

  tasks:
    - name: Ping naar hosts
      ansible.builtin.ping:
      register: ping_output  # Output van de taak opslaan in een variabele

    - name: Debug output
      ansible.builtin.debug:
        var: ping_output  # Gebruik 'var' om de geregistreerde variabele te debuggen

    - name: Print uptime
      ansible.builtin.shell:
        cmd: uptime  # Voer het 'uptime'-commando uit
      register: debug_uptime  

    - name: Debug uptime
      ansible.builtin.debug:
        var: debug_uptime.stdout  # Specifiek de stdout van de geregistreerde variabele debuggen


  

- name: Update linux
  hosts: test1
  become: true  # Voer taken uit met sudo-rechten

  tasks:
    - name: Run apt update
      ansible.builtin.apt:
        name: "*"  # Update alle pakketten
        state: latest
```

> **Belangrijk:**  
> - Je moet kiezen tussen `msg` of `var` in de debug module; beide kunnen niet samen worden gebruikt.  
> - `register` moet direct onder `cmd` staan omdat `ansible.builtin.shell` geen commando op zichzelf bevat.

Als we een wachtwoord willen meegeven, gebruiken we het volgende commando:
```bash
ansible-playbook playbooks/playbook1.yaml -i /home/joey/howest-labo/inventories/tests --ask-become-pass
```
Het is echter beter om een SSH-key te gebruiken.

---

## Services

```yaml
- name: Start service <service-name>, if not started
  service:
    name: <service-name>
    state: started

- name: Stop service <service-name>, if started
  service:
    name: <service-name>
    state: stopped

- name: Restart service <service-name>, in all cases
  service:
    name: <service-name>
    state: restarted

- name: Reload service <service-name>, in all cases
  service:
    name: <service-name>
    state: reloaded

- name: Enable service <service-name>, and not touch the state
  service:
    name: <service-name>
    enabled: yes
```

---

## File Basics

```yaml
- name: Change file ownership, group and permissions
  file:
    path: <filepath>
    owner: <username>
    group: <group-name>
    mode: <file-mode>

- name: Create a symbolic link
  file:
    src: <filepath-to-link-to>
    dest: <symlink-path>
    state: link

- name: Create an empty file
  file:
    path: <filepath>
    state: touch
    mode: <file-mode>

- name: Create a directory if it does not exist
  file:
    path: <dir-path>
    state: directory
    mode: <file-mode>

- name: Remove a file
  file:
    path: <filepath>
    state: absent

- name: Recursively remove directory
  file:
    path: <dir-path>
    state: absent
```

---

## File Copy

```yaml
- name: Copy file with owner and permissions
  copy:
    src: <src-filepath>
    dest: <dst-filepath>
    owner: <username>
    group: <group-name>
    mode: <file-mode>

- name: Copy using inline content
  copy:
    content: 'this is the file content'
    dest: <filepath>
```

---

## LineinFile

```yaml
- name: Add <line> to a file. Create the file if it doesn't exist
  lineinfile:
    path: <filepath>
    line: <line>
    create: yes

- name: If a line matches <line-pattern>, replace it with <line>
  lineinfile:
    path: <filepath>
    regexp: <line-pattern>
    line: <line>
```

---

## Commands

```yaml
- name: Execute a command, and send the output to a variable
  command: <command>
  register: <var-name>

- name: Run command in a specific directory
  command: <command>
  args:
    chdir: <dir>
```

---

## User

```yaml
- name: Add a specific user with a uid
  user:
    name: <username>
    uid: <uid>
    group: <group>

- name: Remove a user
  user:
    name: <username>
    state: absent
    remove: yes
```

---

## Debug

```yaml
- name: Print hostname and uuid
  debug:
    msg: System {{ inventory_hostname }} has uuid {{ ansible_product_uuid }}

- name: Print hostname and uuid conditionally
  debug:
    msg: System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}
  when: ansible_default_ipv4.gateway is defined
```
