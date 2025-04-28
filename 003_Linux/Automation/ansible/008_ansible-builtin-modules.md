# Voorbeeldmodule: `ansible.builtin.file`

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
