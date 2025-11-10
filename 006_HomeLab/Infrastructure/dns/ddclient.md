# ddclient

We gebruiken ddclient om onze dynamische IP-adressen bij te werken bij Namecheap zodat onze domeinen altijd naar het juiste IP-adres verwijzen.
We maken gebruik van een client die staat geïnstalleerd op onze HomeLab server die elke 5 minuten het IP-adres controleert en indien nodig bijwerkt.
Git repository: [https://github.com/ddclient/ddclient/tree/main](https://github.com/ddclient/ddclient/tree/main)

## ddclient installeren

Wij hebben ddclient geinstalleerd op een LXC container met Debian 12. Dit is op onze proxmox-host en dus gaat onze container enkel het minimale aantal packages bevatten. We gaan nog wat extra packages installeren die ddclient nodig heeft.

```bash
sudo apt update
sudo apt upgrade
sudo apt install -y autoconf automake libtool build-essential libio-socket-ssl-perl
```

Vervolgens downloaden we de correcte versie voor debian 12 (bookworm) van ddclient.

```bash
wget https://packages.debian.org/bookworm/source/ddclient
```

Na het downloaden pakken we het bestand uit en gaan we de directory in.

```bash
tar xvfa ddclient-3.10.0.tar.gz
cd ddclient-3.10.0
```

We gaan nu ddclient bouwen en installeren.

```bash
sudo ./autogen
sudo ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var
make
make VERBOSE=1 check
sudo make install
```

We gaan nu de configuratie file aanpassen.

```bash
sudo nano /etc/ddclient.conf
```

En vullen deze met de correcte gegevens voor Namecheap.

```plaintext
## NameCheap (namecheap.com)
##
protocol=namecheap,                     \
server=dynamicdns.park-your-domain.com,	\
login=joey-home.com,                      \
password=******          \
@,edge.joey-home.com
```
We gaan de systemd service file maken & zorgen dat ddclient automatisch opstart bij het booten van de container.

```bash
sudo nano /etc/systemd/system/ddclient.service

[Unit]
Description=Dynamic DNS Update Client
Wants=network-online.target
After=network-online.target nss-lookup.target

[Service]
Type=exec
Environment=daemon_interval=5m
ExecStart=/usr/bin/ddclient --daemon ${daemon_interval} --foreground
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

We gaan nu de service starten en controleren of alles correct werkt.

```bash
sudo systemctl daemon-reload ## Herlaad de systemd manager configuratie
sudo systemctl enable ddclient ## Zorgt dat ddclient automatisch opstart bij booten
sudo systemctl start ddclient ## Start de ddclient service
sudo systemctl status ddclient ## Controleer de status van de ddclient service
sudo journalctl -u ddclient -f ## Bekijk de logs van ddclient in real-time
```
