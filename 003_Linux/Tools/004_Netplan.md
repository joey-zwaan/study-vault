# Netplan

netplan is een configuratiehulpmiddel voor netwerkinterfaces in Linux-systemen, vooral gebruikt in Ubuntu en andere Debian-gebaseerde distributies. Het maakt het mogelijk om netwerkconfiguraties op een declaratieve manier te beheren via YAML-bestanden.


## Basisconfiguratie

Een eenvoudige netplan-configuratie kan er als volgt uitzien:


**Statische IP-configuratie:**

```yaml
network:
    version: 2
    ethernets:
        eth0:
            addresses:
              - 192.168.20.28/24
              - 2a02:a03f:e85a:8f08:be24:11ff:fea5:cffd/64
            routes:
            - to: default
              via: 192.168.20.1
            match:
                macaddress: bc:24:11:a5:cf:fd
            set-name: eth0
```

Let op!
> IPV6 hoeft geen `routes` te hebben als je deze informatie via RA (Router Advertisement) ontvangt.
> Vergeet de CIDR notatie niet bij de IP-adressen, zoals `/24` voor IPv4 en `/64` voor IPv6.


**DHCP-configuratie:**

```yaml
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: true
            dhcp6: true
            match:
                macaddress: bc:24:11:a5:cf:fd
            set-name: eth0
```

