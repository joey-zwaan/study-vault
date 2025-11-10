# Find

## Zoeken van bestanden in Linux

### Bestanden zoeken op naam

Voor een opdracht voor mysql moesten we een bestand vinden met de naam `my.cnf`. Ik was al vergeten waar dit bestand normaal is te vinden.

```bash
sudo find / -type f -name "my.cnf"
```

- `sudo`: Voer de opdracht uit met root-rechten om toegang te krijgen tot alle bestanden.
- `find`: Het commando om bestanden te zoeken.
- `/`: De startdirectory voor de zoekopdracht (in dit geval de rootdirectory).
- `-type f`: Zoek alleen naar bestanden (niet naar directories).7
- `-type d`: Zoek alleen naar directories.
- `-name "my.cnf"`: Zoek naar bestanden met de exacte naam "my.cnf".

wildcards kunnen ook worden gebruikt:

```bash
sudo find / -type f -name "*.cnf"
```

- `*.cnf`: Zoekt naar alle bestanden die eindigen op `.cnf`.
