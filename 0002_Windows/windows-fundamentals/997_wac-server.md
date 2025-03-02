## WAC

Om een WAC-server te installeren moeten we op de server eerst WAC installeren.

Invoke-WebRequest -Uri "https://aka.ms/WACDownload" -OutFile .\wac.exe
Om hem dan te runnen gebruiken we het volgende commando 

.\wac.exe

Op target computer volgend command uitvoeren
winrm quickconfigure of eventueel een GPO instellen

Voor GPO 
--> Firewall rules inbound activeren voor WINRM
--> Allow Remote Management

<img src="/assets/Capture d&apos;écran 2025-03-02 155322.png" width="600">