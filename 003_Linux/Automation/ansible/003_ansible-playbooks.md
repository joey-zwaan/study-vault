## Playbooks

standaard structuur van playbooks

my-ansible-project/
├── inventories/
│   └── production/
│       └── hosts
├── playbooks/
│   └── deploy.yml
│   └── setup.yml
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


### Voorbeelden playbooks
#### Voorbeeld 1: Ping met een debug optie

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
Als we een passwoord willen meegeven gebruiken we het volgende commando :
`playbooks/playbook1.yaml -i /home/joey/howest-labo/inventories/tests --ask-become-pass`
Veel beter is natuurlijk om gewoon een ssh-key te gebruiken.


***Belangrijk:*** *Je moet kiezen tussen `msg` of `var` ze kunnen niet allebei gebruikt worden met de debug module.*

*register moet onder cmd staan omdat `ansible.builtin.shell` geen commando op zijn eigen bevat en er dan ook niks geregistreerd wordt.*

####  playbook2 VARS & LOOPS