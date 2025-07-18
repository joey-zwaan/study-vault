## Windows 11 Netwerk Troubleshooting

### APIPA-adres wordt steeds toegekend aan de interface**

**Probleem**

- Het apparaat accepteerde geen statisch IP-adres en bleef automatisch een APIPA (Automatic Private IP Addressing) adres krijgen.
- Ook via DHCP werd geen adres verkregen, terwijl andere apparaten in het netwerk wel correct functioneerden.

**Oplossing**

Voer de volgende commando's uit in een PowerShell-venster met administratorrechten:

```powershell
netsh int ip reset
netsh winsock reset
```

Herstart daarna het apparaat.  
Na het uitvoeren van deze stappen kreeg het apparaat weer een correct IP-adres via DHCP en werkte handmatige toewijzing ook weer.