# Handige Tools voor Verschillende Toepassingen

---

## xfreerdp

Gebruik `xfreerdp` om verbinding te maken met Windows-servers via RDP.

```bash
xfreerdp /u:gebruikersnaam /p:wachtwoord /v:doel_ip
```

---

## smbclient

Met `smbclient` kun je verbinding maken met SMB-shares.

- **Lijst met shares op een server:**
  ```bash
  smbclient -L SERVER_IP -U gebruiker
  ```

- **Verbinden met een specifieke share:**
  ```bash
  smbclient '\\SERVER_IP\Share' -U gebruiker
  ```

---


### Configuratie

#### Oh My Zsh installeren
Installeer Oh My Zsh met het volgende script:
```bash
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

#### Auto-suggesties inschakelen
- Clone de repository:
  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```
- Voeg `zsh-autosuggestions` toe aan de plugins in `~/.zshrc`:
  ```bash
  plugins=(... zsh-autosuggestions)
  ```
- Herstart ZSH:
  ```bash
  zsh
  ```

#### Syntax highlighting inschakelen
- Clone de repository:
  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```
- Voeg `zsh-syntax-highlighting` toe aan de plugins in `~/.zshrc`:
  ```bash
  plugins=(... zsh-syntax-highlighting)
  ```
- Herstart ZSH:
  ```bash
  zsh
  ```

#### Powerlevel10k installeren
- Clone de repository:
  ```bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  ```
- Wijzig het thema in `~/.zshrc`:
  ```bash
  ZSH_THEME="powerlevel10k/powerlevel10k"
  ```
- Herstart ZSH en doorloop de configuratiewizard.

> **Opmerking:** Als je niet tevreden bent met je keuzes, kun je de configuratie opnieuw starten met:
```bash
p10k configure
```

### ZSH als standaard shell instellen
Stel ZSH in als standaard shell:
```bash
chsh
```
Voer het pad naar ZSH in:
```bash
/bin/zsh
```

---

## SCP (Secure Copy Protocol)

`scp` is een veilige manier om bestanden tussen een lokale en een externe machine over SSH te kopiëren.

### Basis Syntax
```bash
scp [opties] bron doel
```
- **bron**: Het bestand of de map die je wilt kopiëren.
- **doel**: De bestemming waar het bestand naartoe moet.

### Veelgebruikte Opties
- `-r`: Kopieer mappen (recursief).
- `-P [poort]`: Specificeer een andere poort.
- `-v`: Gedetailleerde uitvoer.
- `-q`: Stille modus.

---

### Voorbeelden

1. **Bestanden uploaden naar een externe machine**
   ```bash
   scp [lokale_bestand] [gebruiker@externe_host:/pad/naar/doel]
   ```
   Voorbeeld:
   ```bash
   scp C:\Users\FemkJoeye\Documents\zsh_backup.tar.gz joey@192.168.1.10:/home/joey/backups/
   ```

2. **Bestanden downloaden van een externe machine**
   ```bash
   scp [gebruiker@externe_host:/pad/naar/bestand] [lokale_pad]
   ```
   Voorbeeld:
   ```bash
   scp joey@192.168.1.10:/home/joey/howest-labo/zsh_backup.tar.gz C:\Users\FemkJoeye\Documents\
   ```

3. **Mappen uploaden naar een externe machine**
   Gebruik de `-r` optie:
   ```bash
   scp -r [lokale_map] [gebruiker@externe_host:/pad/naar/doel]
   ```
   Voorbeeld:
   ```bash
   scp -r C:\Users\FemkJoeye\Documents\my_folder joey@192.168.1.10:/home/joey/backups/
   ```