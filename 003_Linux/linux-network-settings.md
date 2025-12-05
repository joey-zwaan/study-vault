# Netplan

## Static IP instellen

Netplan configuratiebestanden bevinden zich in de map `/etc/netplan/`. Meestal is er een bestand met de naam `01-netcfg.yaml` of iets dergelijks. We gaan dit bestand bewerken om een vast IP-adres in te stellen.

```bash
sudo nano /etc/netplan/01-netcfg.yaml
```

We passen het bestand aan om een vast IP-adres in te stellen. Hier is een voorbeeldconfiguratie:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - 192.168.20.52/24
      routes:
        - to: default
          via: 192.168.20.1
      nameservers:
        addresses:
          - 192.168.20.1
      match:
        macaddress: bc:24:11:54:6a:ed
      set-name: eth0
```

## Interfaces

### IPv6 Static IP instellen

Je kan ook het bestand `/etc/network/interfaces` gebruiken om netwerkinterfaces te configureren. Hier is een voorbeeld van hoe je een statisch IP-adres kunt instellen voor ipv6:

```bash
sudo nano /etc/network/interfaces
```
Voeg de volgende configuratie toe:

```plaintext
auto eth0
iface eth0 inet6 static
    address 2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

Dan enkel nog gevolgd door het commando :

```bash
 ip -6 route add default via fe80::92ec:77ff:fe8e:ee27 dev ens18 || true
```

Dit zal een standaard gateway toevoegen voor ipv6 verkeer.

### IPV4 Static IP instellen

Voor een statisch IPv4-adres, voeg je de volgende configuratie toe aan hetzelfde bestand:

```plaintext
allow-hotplug ens18
iface ens18 inet static
    address 192.168.20.11/24
    gateway 192.168.20.1
    dns-nameservers 192.168.20.1 
```
