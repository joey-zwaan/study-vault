# Containers Intro

## Docker installeren & configureren

```bash

# Add Docker's official GPG key

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL <https://download.docker.com/linux/debian/gpg> -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install docker-ce
```


### Containers uitvoeren en beheren

#### Containers starten, stoppen, herstarten en verwijderen

```bash
docker start my_container
docker stop my_container
docker restart my_container
docker rm my_container
docker run fedora
docker run fedora sleep 5000
docker run -d fedora sleep 5000
docker run -p 82:82 -d --name joey nginx
docker exec -it xenodochial_joliot /bin/bash
sudo docker run -d -p 80:80 nginx
```

```bash
sudo docker rm $(sudo docker ps -a)
sudo docker stop $(sudo docker ps)
sudo docker image prune
sudo docker container prune
sudo docker system prune
```

`docker start my_container`: Start een gestopte container met de naam `my_container`.
`docker stop my_container`: Stopt een actieve container met de naam `my_container`.
`docker restart my_container`: Herstart een actieve container met de naam `my_container`.
`docker rm my_container`: Verwijdert een gestopte container met de naam `my_container`.
`docker run fedora`: Start een nieuwe container op basis van de Fedora-image. Hij downloadt de image indien deze nog niet lokaal aanwezig is.
`docker run fedora sleep 5000`: Start een nieuwe Fedora-container en laat deze 5000 seconden slapen.
`docker run -d fedora sleep 5000`: Start een nieuwe Fedora-container in de achtergrond en laat deze 5000 seconden slapen.
`docker exec -it xenodochial_joliot /bin/bash`: Start een interactieve bash-shell in de container met de naam `xenodochial_joliot`.
`docker run -d -p 80:80 nginx`: Start een nieuwe Nginx-container in de achtergrond en map poort 80 van de host naar poort 80 van de container.
`docker run -p 82:82 -d --name joey nginx`: Start een nieuwe Nginx-container in de achtergrond, map poort 82 van de host naar poort 82 van de container en geef de container de naam `joey`.
`sudo docker rm $(sudo docker ps -a)`: Verwijdert alle gestopte containers op het systeem.
`sudo docker stop $(sudo docker ps)`: Stopt alle actieve containers op het systeem.
`sudo docker image prune`: Verwijdert alle dangling (ongebruikte) Docker-images om schijfruimte vrij te maken.
`sudo docker container prune`: Verwijdert alle gestopte containers om schijfruimte vrij te maken.
`sudo docker system prune`: Verwijdert alle gestopte containers, ongebruikte netwerken, dangling images en build cache om schijfruimte vrij te maken.

> Je moet -d voor de image specificeren om de container in de achtergrond te laten draaien.
> Best practice om packages in de container altijd te updaten na het starten van de container.

#### Docker-informatie bekijken

```bash

docker ps
docker ps -a
docker image ls
docker logs my_container
docker network inspect bridge



`docker ps -a`: Toont alle containers, inclusief gestopte containers.
`docker image ls`: Toont alle beschikbare Docker-images op het systeem.
`docker logs my_container`: Toont de loguitvoer van de container met de naam `my_container`.
`docker network inspect bridge`: Toont gedetailleerde informatie over het standaard Docker-bridge-netwerk, inclusief verbonden containers en hun IP-adressen.
```

### Docker volumes

```bash
docker volume create my_volume
docker volume ls
docker volume inspect my_volume
docker volume rm my_volume
## We mounten een volume die we gemaakt hebben als een directory in de container 
sudo docker run -d --name joey-container --mount type=volume,src=joey,dst=/joey httpd:trixie
## MariaDB met een volume voor de database bestanden 
sudo docker run -d --name joey-zwaan -p 3306:3306 --mount type=volume,src=mariadb,dst=/var/lib/mysql -e MARIADB_RANDOM_ROOT_PASSWORD mariadb:lts

```

Volumes worden opgeslagen in `/var/lib/docker/volumes/` op de host.
Als we vanaf de host data willen toevoegen aan een volume kunnen we dat doen door naar die directory te navigeren. `root@mariadb-test:/var/lib/docker/volumes/joey/_data# ls` zien we de bestanden die we aangemaakt hebben in de container zelf, maar we kunnen hier ook bestanden in plaatsen die dan beschikbaar komen op de container.

`sudo docker run -d --name joey-container1 --mount type=volume,src=joey,dst=/usr/share/nginx/html nginx:latest`: Start een nieuwe Nginx-container in de achtergrond, mount het volume `joey` naar de directory `/usr/share/nginx/html` in de container. Deze directory wordt standaard gebruikt door Nginx om webinhoud te serveren.

### Docker Environment variables

Dit zijn variabelen die we kunnen meegeven aan een container bij het opstarten. Deze variabelen kunnen door de applicatie binnen de container worden gebruikt om configuratie-instellingen te bepalen.

Hier een voorbeeld van hoe je environment variables kunt instellen bij het starten van een Docker-container:

```bash
sudo docker run -d --name joey-container1000 --mount type=volume,src=joey,dst=/usr/share/nginx.html -e TEST_ENV=microservices -e VERSION=1.1.0 nginx:1.29.1
```
In dit voorbeeld worden twee environment variables ingesteld:
- `TEST_ENV` met de waarde `microservices`
- `VERSION` met de waarde `1.1.0`

Je kan in de container gaan met `docker exec -it joey-container1000 /bin/bash` en dan met het `echo` en 2x tab toetsen de variabelen bekijken:
```bash
root@joey-container1000:/# echo $TEST_ENV
microservices
root@joey-container1000:/# echo $VERSION
1.1.0
```

Hier zien we dat de environment variables succesvol zijn ingesteld en kunnen worden gebruikt binnen de container.
Bij de meeste officiële Docker-images worden bepaalde environment variables ondersteund om de applicatie binnen de container te configureren. Raadpleeg altijd de documentatie van de specifieke Docker-image voor meer informatie over ondersteunde environment variables en hun gebruik. Bij NGINX is dit bijvoorbeeld `$NGINX_VERSION` om de versie te bekijken.

We hebben PHP-myAdmin ook op deze manier opgezet met environment variables voor de database configuratie.
Hiermee verbinden we PHP-myAdmin met onze MySQL database container.

```bash
sudo docker run -d --name admin --link mysql:db -p 8080:80 phpmyadmin:5.2.3-apache
 ```

In dit voorbeeld wordt de `--link` optie gebruikt om de PHP-myAdmin-container te verbinden met een MySQL-container genaamd `mysql`. De alias `db` wordt gebruikt binnen de PHP-myAdmin-container om naar de MySQL-container te verwijzen. Hierdoor kan PHP-myAdmin verbinding maken met de database zonder dat we handmatig de hostnaam hoeven op te geven.

We hebben ook een MariaDB op de docker host draaien. Als we deze ook willen koppelen aan PHP-myAdmin kunnen we de volgende command gebruiken:
Dit werkt omdat de container & de docker host in hetzelfde netwerk zitten. Dit is ook de manier om met externe databases te verbinden.

```bash
sudo docker run -d --name admin-external -p 8081:80 -e PMA_HOST=172.17.0.1 phpmyadmin:5.2.3-apache
```

In dit voorbeeld wordt de environment variable `PMA_HOST` ingesteld op het IP-adres van de Docker-host.

### Dockerfile

#### Dockerfile voorbeeld

```Dockerfile
# Base image vanwaar we vertrekken
FROM node:25.0.0-bookworm

# Maak de code directory aan en voer onderstaande statements daarin uit
WORKDIR /app

# Kopieer alles uit de huidige directory naar je container
COPY .. 

# Voer de installatiestappen uit voor de nodejs applicatie. Dit zal de dependencies installeren waar nodig
RUN yarn install --production

CMD ["node", "src/index.js"]

# Definieer de poort waarop de code luistert

EXPOSE 3000
```

> Bij een dockerfile te maken is het heel belangrijk om bij COPY de . . uit elkaar te zetten. De eerste punt is de bron (huidige directory) en de tweede punt is de bestemming (workdir in de container).
> Bij CMD moeten we opletten op de spaties. Als we bijvoorbeeld `CMD ["node","src/index.js"]` zouden schrijven zonder spatie na de komma, zal dit een foutmelding geven bij het bouwen van de image omdat het dan als één woord wordt gezien. Bij instructies zoals FROM, RUN, COPY, WORKDIR en EXPOSE moet er een spatie na de instructie staan.

Na het maken van de dockerfile gaan we de image bouwen met `docker build .` en als we controleren of de image is aangemaakt gebruiken we `docker image ls`.

#### Dockerfile commands & build

- `FROM`: Specificeert de basisimage waarop de nieuwe image wordt gebouwd.
- `WORKDIR`: Stelt de werkdirectory in voor de volgende instructies in de Dockerfile.
- `COPY`: Kopieert bestanden of directories van de host naar de container.
- `RUN`: Voert een commando uit tijdens het bouwen van de image.
- `CMD`: Stelt het standaardcommando in dat wordt uitgevoerd wanneer een container wordt gestart op basis van de image.
- `EXPOSE`: Geeft aan welke poorten de container luistert tijdens runtime.
- `ENV`: Stelt environment variables in voor de container.

Om de image te bouwen met een specifieke tag (naam en versie), gebruiken we de volgende command
Als je dit niet doet dan krijgt de image een tag "none" & een willekeurige naam.

```bash
docker build -t joey:1.0.10 .
```

#### Dockerized FLASK APP

```Dockerfile

FROM python:3.14-trixie

WORKDIR /app

COPY . /app

RUN pip3 install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
```

We hebben zelf de requirements.txt aangemaakt met daarin de benodigde python packages:
Flask
Flask-CORS
requests

We bouwen de image met: `sudo docker build . -t python:100.1` en dan starten we de container met  `sudo docker run -d --name joey-zwaan1000 -p 7000:5000 python:100.1` nu kunnen we de flask app benaderen via poort 7000 op de docker host.
