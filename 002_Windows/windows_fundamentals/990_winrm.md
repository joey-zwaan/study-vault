# WinRM - Windows Remote Management  

**Wat is WinRM?**  
WinRM is een Windows-service gebaseerd op **WS-Management** waarmee externe apparaten veilig kunnen worden beheerd via **PowerShell of CMD**. Het gebruikt poort **5985 (HTTP)** en **5986 (HTTPS)**.  

---

## WinRM inschakelen  
Gebruik het volgende commando om WinRM in te schakelen:  
```powershell
winrm quickconfig
```
- Start de WinRM-service als deze nog niet actief is.  
- Staat externe verbindingen toe met bevestiging.  

---

## WinRM Listener handmatig instellen  

**Voor alle IP-adressen via HTTP:**  
```powershell
winrm create winrm/config/Listener?Address=*+Transport=HTTP @{Port="5985"}
```

**Voor een specifiek IP-adres via HTTPS:**  
```powershell
winrm create winrm/config/Listener?Address=192.168.1.10+Transport=HTTPS @{Port="5986";CertificateThumbprint="THUMBPRINT"}
```

### Listener instellen met een certificaat  

```powershell
New-Item -Path WSMan:\localhost\Listener -Address * -Transport HTTPS -Hostname $hostname -CertificateThumbprint $thumbprint -Force
```
> **Opmerking:** Dit certificaat moet door een CA worden uitgegeven die wordt vertrouwd door Windows Admin Center (WAC).

## Firewallregels (manueel instellen)  

Voeg de volgende firewallregels toe om inkomend verkeer op de juiste poorten toe te staan:  
```powershell
netsh advfirewall firewall add rule name="WinRM HTTP" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM HTTPS" protocol=TCP dir=in localport=5986 action=allow 
```

---

## Huidige configuratie controleren  

Controleer de huidige WinRM-configuratie met:  
```powershell
winrm enumerate winrm/config/listener
```

**Een bestaande listener verwijderen:**  
```powershell
winrm delete winrm/config/listener?Address=*+Transport=HTTP
```

**Instellingen aanpassen:**  
```powershell
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
```

---

## WinRM testen  

**Lokaal testen:**  
```powershell
Test-WSMan
```

**Extern testen:**  
```powershell
Test-WSMan -ComputerName dc1.zjlocal.test
```

**Externe verbinding maken met een andere machine:**  
```powershell
Enter-PSSession -ComputerName dc1.zjlocal.test -Credential Administrator
```

---

## WinRM configureren via GPO  

WinRM moet correct worden geconfigureerd in Group Policy Object (GPO) om externe beheerverbindingen mogelijk te maken.  

- In een GPO-serverbeheerinstelling moet IPv4 op `*` of een specifiek IP-adres staan, anders blijft het leeg (default = `*`).
- WinRM kan via GPO worden ingeschakeld onder:  
  ```
  Computerconfiguratie > Beheersjablonen > Windows-componenten > Windows Remote Management (WinRM)
  ```

Daarnaast moeten firewallregels worden geconfigureerd om inkomend verkeer op de juiste poorten toe te staan.

---

### Windows Firewall Rules via Group Policy (GPO)  

Om een nieuwe inbound firewallregel toe te voegen via GPO, volg je deze stappen:

1. Open **Group Policy Management Editor**.  
2. Navigeer naar:  
   **Computerconfiguratie** → **Beleidsregels** → **Windows-instellingen** → **Beveiligingsinstellingen** →  
   **Windows Defender Firewall met Geavanceerde Beveiliging** → **Inbound Rules**.  
3. Voeg een nieuwe regel toe met de volgende instellingen:

---

#### Nieuwe Inbound Regel Toevoegen  

| **Instelling** | **Waarde**                |
|----------------|---------------------------|
| **Protocol**   | TCP                       |
| **Poorten**    | 5985 (HTTP) / 5986 (HTTPS) |
| **Actie**      | Allow                     |
| **Profielen**  | Domain, Private, Public   |


New-Item -Path WSMan:\localhost\Listener -Address * -Transport HTTPS -Hostname $hostname -CertificateThumbprint $thumbprint -Force


--> Dit certificaat moet door een CA uitgegeven zijn die wordt vertrouwd door WAC

Voor het terug te verwijderen is het volgende commando goed

```powershell
Remove-Item -Path WSMan:\localhost\Listener\Listener_*+5986 -Recurse -Force
```
