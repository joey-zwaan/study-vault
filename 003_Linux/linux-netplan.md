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
