## WAC

Om een WAC-server te installeren moeten we op de server eerst WAC installeren.

Invoke-WebRequest -Uri "https://aka.ms/WACDownload" -OutFile .\wac.exe
Om hem dan te runnen gebruiken we het volgende commando 
.\wac.exe

**Als dit niet werkt is er nog een andere manier**

Start-BitsTransfer -Source "https://aka.ms/WACDownload" -Destination "C:\wac.exe"

Op target computer volgend command uitvoeren
winrm quickconfigure of eventueel een GPO instellen

Voor GPO 
--> Firewall rules inbound activeren voor WINRM
--> Allow Remote Management

<img src="/assets/Capture d&apos;écran 2025-03-02 155322.png" width="600">

## WINRM



Bij default gebruikt WINRM http.
Als we op een veilige manier willen communiceren via WAC moeten we https enablen.
Hiervoor moeten we een certificate thumbprint toevoegen

```powershell
Get-ChildItem -Path WSMan:\localhost\Listener
```

--> kijken of er al iets is ingesteld

```powershell
$thumbprint = "19C3836AAD369A72E674259A60A612D188BF6386"
$hostname = "dcl.ZJlocal.test"
```

New-Item -Path WSMan:\localhost\Listener -Address * -Transport HTTPS -Hostname $hostname -CertificateThumbprint $thumbprint -Force


--> Dit certificaat moet door een CA uitgegeven zijn die wordt vertrouwd door WAC

Voor het terug te verwijderen is het volgende commando goed

```powershell
Remove-Item -Path WSMan:\localhost\Listener\Listener_*+5986 -Recurse -Force
```
