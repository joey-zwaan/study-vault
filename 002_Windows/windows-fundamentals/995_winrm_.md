### WinRM - Windows Remote Management  

**Wat is WinRM?**  
WinRM is een Windows-service gebaseerd op **WS-Management** waarmee externe apparaten veilig kunnen worden beheerd via **PowerShell of CMD**. Het gebruikt poort **5985 (HTTP)** en **5986 (HTTPS)**.  

#### WinRM inschakelen  
```powershell
winrm quickconfig
```
- Start de WinRM-service als deze nog niet actief is  
- Staat externe verbindingen toe met bevestiging  

#### WinRM Listener handmatig instellen  
**Voor alle IP-adressen via HTTP:**  
```powershell
winrm create winrm/config/Listener?Address=*+Transport=HTTP @{Port="5985"}
```
**Voor een specifiek IP-adres via HTTPS:**  
```powershell
winrm create winrm/config/Listener?Address=192.168.1.10+Transport=HTTPS @{Port="5986";CertificateThumbprint="THUMBPRINT"}
```

#### Huidige configuratie controleren  
```powershell
winrm enumerate winrm/config/listener
```

#### WinRM verwijderen of aanpassen  
**Een bestaande listener verwijderen:**  
```powershell
winrm delete winrm/config/listener?Address=*+Transport=HTTP
```
**Instellingen aanpassen:**  
```powershell
winrm set winrm/config/service @{AllowUnencrypted="true"}
winrm set winrm/config/service/auth @{Basic="true"}
```

#### WinRM testen  
**Lokaal testen:**  
```powershell
Test-WSMan
```
**Extern testen:**  
```powershell
Test-WSMan -ComputerName dc1.zjlocal.test
```

#### Externe verbinding maken met een andere machine  
```powershell
Enter-PSSession -ComputerName dc1.zjlocal.test -Credential Administrator
```

#### GPO en WinRM  
- **In een GPO-serverbeheerinstelling moet IPv4 op `*` of een specifiek IP-adres staan, anders blijft het leeg (default = uitgeschakeld).**  
- **WinRM kan via GPO worden ingeschakeld onder:**  
  `Computerconfiguratie > Beheersjablonen > Windows-componenten > Windows Remote Management (WinRM)`