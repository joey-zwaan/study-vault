# Symlinks

## Wat is een symlink?

Een symlink (symbolische link) is een verwijzing naar een andere locatie op het bestandssysteem, vergelijkbaar met een snelkoppeling. Voor applicaties lijkt het alsof de originele map of bestand nog bestaat, maar de data staat eigenlijk ergens anders.
Wanneer je rootpartitie (`/`) bijna vol is, maar je extra ruimte hebt op een andere partitie zoals `/home`, kun je grote datafolders verplaatsen en teruglinken met een symbolische link (symlink). Dit is een efficiënte manier om ruimte te besparen zonder je systeem te breken.


## Praktisch voorbeelden

### Plex-data verplaatsen

- Originele locatie: `/var/lib/plexmediaserver`
- Doellocatie met ruimte: `/home/plex`

**Stappen:**
```bash
sudo systemctl stop plexmediaserver
sudo mv /var/lib/plexmediaserver /home/plex
sudo ln -s /home/plex /var/lib/plexmediaserver
sudo systemctl start plexmediaserver
```

Controleer of de symlink correct is:
```bash
ls -l /var/lib | grep plex
# Verwachte uitvoer: plexmediaserver -> /home/plex
```


**Belangrijke aandachtspunten**

- **Stop eerst de service** om beschadiging tijdens verplaatsing te voorkomen.
- **Verplaats alles volledig** met `mv` of `rsync -aHAX` om rechten en eigenaarschap te behouden.
- **Behoud correcte permissies** op de nieuwe locatie.
- **Vermijd geneste symlinks** voor overzichtelijkheid.
- **Vermijd trailing slashes**: Gebruik `ln -s /home/plex /var/lib/plexmediaserver` (zonder `/` achteraan) want dit kan leiden tot verwarring over de werkelijke locatie van de bestanden.

---
