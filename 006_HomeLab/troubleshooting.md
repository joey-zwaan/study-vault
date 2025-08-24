# IPv6 probleem – sommige sites laden niet (pfSense)

Via pfSense werkten sommige websites niet over IPv6, maar wel via IPv4.  
ICMP werkte, maar HTTPS-verbindingen liepen vast.  

Met debug bleek een **MTU-probleem**:  

```powershell
ping -6 -l 1465 promomeuble.be   # faalt
ping -6 -l 1420 promomeuble.be   # werkt
curl -6 -v https://promomeuble.be
```

### Instelling in pfSense

Ga naar **Interfaces → WAN** en stel **MTU = 1420** in.  
Sla op en klik **Apply Changes**.  
