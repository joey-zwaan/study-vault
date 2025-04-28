# Variabele

Als we bijvoorbeeld apt update willen gebruiken werkt dit niet op een rhel systeem.
We kunnen hiervoor facts gebruiken om te bekijken welke variabelen we allemaal hebben.


```yaml
---
- name: update all packages
  hosts: test1  # Zorg ervoor dat 'test1' een gedefinieerde groep is in je inventorybestand
  become: true

  tasks:
    - name: debug facts
      ansible.builtin.ping:
      var: ansible_facts 
```

Nu gaan we ons playbook aanpassen zodat de andere host ook kan geupdate worden.
We gebruiken hiervoor een conditional.

```yaml
---
- name: Update all packages
  hosts: test1  # Zorg ervoor dat 'test1' een gedefinieerde groep is in je inventorybestand
  become: true

  tasks:
    - name: Update Debian hosts
      ansible.builtin.apt:
        name: "*"
        state: latest
      when: ansible_distribution == "Debian"

    - name: Update RHEL hosts
      ansible.builtin.yum:
        name: "*"
        state: latest
      when: ansible_distribution == "RedHat"
```

Je kan variabelen ook definieren in een inventory file en deze gebruiken in een play.
We kunnen ook bestanden kopieeren.

``` ini 
[servers_nginx]
192.168.20.51 hostname=debian_1
[slaves]
192.168.20.51
192.168.20.100
[test1]
192.168.20.51
192.168.20.100


[servers_nginx:vars]

```

```yaml
---
- name: Set hostname
  hosts: test1  # Zorg ervoor dat 'test1' een gedefinieerde groep is in je inventorybestand
  become: true

  tasks:
    - name: Set Hostname
      ansible.builtin.shell:
        cmd: "hostnamectl set-hostname {{ hostname }}"

- name: Copy configuration to hosts
  hosts: test1

  tasks:
    - name: copy file
      ansible.builtin.copy:
        src: ./files/production
        dst: ~/production

```

We kunnen ook een variable in de group_var aanmaken. 
Hier moet je een file maken die match met een groep in je inventory bestand.
Ansible laad dan automatisch dit bestand voor alle host in de groep.
Bij default gebruik je een all.yml bestand. Hier zet je globale variabelen.
De specifieke variabelen gezet in group_vars overschrijven de all.yml bestand.

inventory/
├── hosts
└── group_vars/
    └── test1.yml

| Variable                             | Description |
|--------------------------------------|-------------|
| `ansible_host`                       | The hostname or IP address to connect to. Defaults to the alias if not set. |
| `ansible_port`                       | The port to connect on. Defaults to port 22 if not set. |
| `ansible_user`                       | The SSH user for authentication. |
| `ansible_password`                   | Password for SSH authentication. |
| `ansible_ssh_private_key_file`       | Path to the private SSH key for authentication. |
| `ansible_ssh_common_args`            | Extra arguments for `sftp`, `scp`, and `ssh` commands. |
| `ansible_sftp_extra_args`            | Extra arguments for the `sftp` command. |
| `ansible_scp_extra_args`             | Extra arguments for the `scp` command. |
| `ansible_ssh_extra_args`             | Extra arguments for the `ssh` command. |
| `ansible_ssh_pipelining`             | Enable/disable SSH pipelining. |
| `ansible_ssh_executable`             | Override default SSH executable. |
| `ansible_become`                     | Enable privilege escalation (equivalent to `ansible_sudo`). |
| `ansible_become_method`              | Set the privilege escalation method (e.g., `sudo`, `su`). |
| `ansible_become_user`                | User to become when using privilege escalation. |
| `ansible_become_password`            | Password for privilege escalation (e.g., `sudo` password). |
| `ansible_become_exe`                 | Executable for the selected privilege escalation method. |
| `ansible_become_flags`               | Flags to pass to the privilege escalation method. |
| `ansible_shell_type`                 | The shell type on the target system. |
| `ansible_python_interpreter`         | Path to the Python interpreter on the target host. |
| `ansible_*_interpreter`              | Interpreter for other languages like Ruby, Perl, etc. |


We hebben ook state variabeles

State | What It Does
present | Ensures the package is installed
absent | Ensures the package is uninstalled
latest | Installs the latest version available
removed | Alias for absent
installed | Alias for present

## Loops


### STANDAARD LOOPS 

Een standaard loop zal itereren over een lijst van waarden. De task zal éénmaal uitgevoerd worden per 
entry in de lijst. Op die manier kan je bv. meerdere software packages in één task bundelen: 

Bij default gebruikt ansible {{ item }} voor een loop dat steeds vervangen worden door de waarde per keer dat de loop loopt.
Als we zelf een naam willen gebruiken pakken we het iets anders aan.

**Package is OS onafhankelijke module**

*loop met eigen variabele*

- name: Install common packages
  ansible.builtin.package:
    name: "{{ pkg }}"
    state: present
  loop: "{{ packages_to_install }}"
  loop_control:
    loop_var: pkg


*Standaard loop*
---
- name: Install software packagers using a loop
  hosts: docker-nodes
  become: true
  gather_facts: no

  vars:
    packages_to_install:
        - python3
        - firewalld
        - htop
        - vim


  tasks:
    - name:
      ansible.builtin.package:
        name: "{{ item }}"
        state: present
      loop: "{{ packages_to_install }}"


*Complexe loop*

- name: User Management
  hosts: tests
  become: true


  tasks:
    - name: Add several users
      ansible.builtin.user:
        name: "{{ item.name }}"
        state: present
        groups: "{{ item.groups }}"
      loop:
        - { name: 'testuser1', groups: 'sudo' }
        - { name: 'testuser2', groups: 'users' }

*Complexere variant 1*

<img src="/assets/ansible-playbook-complex.png" alt="share" width="600">

*Complexere variant 2*

<img src="/assets/ansible-playbook-complex1.png" alt="share" width="600">