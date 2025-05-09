# Community-General Module

De `community.general` collectie is een onderdeel van het Ansible-pakket en bevat veel modules en plugins die worden ondersteund door de Ansible-community. Deze modules zijn niet opgenomen in meer gespecialiseerde community-collecties.

Meer informatie: [community.general documentatie](https://docs.ansible.com/ansible/latest/collections/community/general/index.html)

---

## Installatie van de Collectie

Gebruik het volgende commando om de `community.general` collectie te installeren:

```bash
ansible-galaxy collection install community.general
```

---

## Voorbeeldmodule: `community.general.timezone`

De `community.general.timezone` module wordt gebruikt om de tijdzone van een systeem te configureren.

### Voorbeeldgebruik

```yaml
- name: Stel tijdzone in naar {{ timezone }}
  become: true
  community.general.timezone:
    name: "{{ timezone }}"
```

> **Opmerking:** We gebruiken hier een variabele zodat we, indien nodig, bij hergebruik van deze rol een andere tijdzone kunnen instellen. Deze variabele wordt standaard ingesteld in defaults van de rol.