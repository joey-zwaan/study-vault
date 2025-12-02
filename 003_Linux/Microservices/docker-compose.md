# Docker Compose

## Docker Compose commands

```bash
docker compose up -d
docker compose -f mijn-bestand.yml up -d
docker compose down
docker compose ps
docker compose logs
docker compose top
docker compose stats
```

- `docker compose up -d`: Start alle services die zijn gedefinieerd in het `docker compose.yml` bestand in de achtergrond (detached mode).
- `docker compose -f mijn-bestand.yml up -d`: Start alle services die zijn gedefinieerd in het opgegeven `mijn-bestand.yml` bestand in de achtergrond.
- `docker compose down`: Stopt en verwijdert alle containers, netwerken en volumes die zijn gemaakt door `docker compose up`.
- `docker compose ps`: Toont de status van alle services die worden beheerd door Docker Compose.
- `docker compose logs`: Toont de loguitvoer van alle services die worden beheerd door Docker Compose.
- `docker compose top`: Toont de actieve processen binnen de containers die worden beheerd door Docker Compose.
- `docker compose stats`: Toont een realtime overzicht van de resourcegebruik (CPU, geheugen, netwerk I/O, schijf I/O) van de containers die worden beheerd door Docker Compose.

## Configureren van een Docker Compose bestand

Een Docker Compose bestand wordt meestal `docker compose.yml` genoemd en bevat de configuratie voor de verschillende services die je applicatie nodig heeft. Hier is een eenvoudig voorbeeld van een `docker compose.yml` bestand. Om te starten gebruiken we het commando `docker compose up -d` in de directory waar het bestand zich bevindt. Als het bestand een andere naam heeft kan je dat aangeven met de `-f` optie, bijvoorbeeld `docker compose -f mijn-bestand.yml up -d`.
Als we de containers weer willen stoppen gebruiken we `docker compose down`.

```yaml

name: joey

services:
  web:
    image: nginx:latest
    ports:
      - "8888:80"
    volumes:
      - ./html:/usr/share/nginx/html
    networks:
      - frontend


  db:
    image: mariadb:lts
    environment:
      - MARIADB_RANDOM_ROOT_PASSWORD=yes
    volumes:
      - test1:/var/lib/mysql
    networks:
      - frontend


networks:
  frontend:
    driver: bridge
    enable_ipv4: true
    enable_ipv6: false
    ipam:
      driver: default
      config:
        - subnet: 172.250.0.0/16
          ip_range: 172.250.5.0/24
          gateway: 172.250.5.254

volumes:
  test1:

```

- `services`: Hier definieer je de verschillende services (containers) die je applicatie nodig heeft. In dit voorbeeld zijn er twee services: `web` (Nginx) en `db` (MariaDB).
- `image`: De Docker-image die gebruikt wordt voor de service.
- `ports`: Hiermee koppel je poorten van de host aan de container. In dit geval wordt poort 8888 van de host gekoppeld aan poort 80 van de Nginx-container.
- `volumes`: Deze volume maak je aan om data persistent op te slaan. Je kan dit voor meerdere services gebruiken.
- `environment`: Hiermee stel je omgevingsvariabelen in voor de container. In dit geval wordt een willekeurig root-wachtwoord gegenereerd voor de MariaDB-container.

> Bij sommige variabelen zoals MARIADB_RANDOM_ROOT_PASSWORD werkt dit alleen op de eerste keer dat je de container opstart en daarna wordt het wachtwoord niet meer getoond. Als je de container verwijdert en opnieuw aanmaakt met dezelfde volume zal de database de oude data blijven gebruiken en dus hetzelfde wachtwoord.

## Opdracht 5 — multi-app-01

Doel: bouw een kleine multi-container demo met PHP (web), Redis en MariaDB. Lever een werkende `docker-compose.yml` en een eenvoudige `Dockerfile` voor de webservice. De PHP-app (index.php) is de test-app die verbinding maakt met MariaDB en Redis.

Plak of maak de volgende PHP-file als `index.php` in je projectmap.

```php
<?php
$mysqli = new mysqli(
    getenv('DB_HOST'),
    getenv('DB_USER'),
    getenv('DB_PASS'),
    getenv('DB_NAME')
);
    getenv('DB_HOST'),
    getenv('DB_USER'),
    getenv('DB_PASS'),
    getenv('DB_NAME')
);

if ($mysqli->connect_error) {
    die("MySQL Connection failed: " . $mysqli->connect_error);
}

$redis = new Redis();
$redis->connect(getenv('REDIS_HOST'), getenv('REDIS_PORT'));

$visits = $redis->incr('page_visits');

echo "<h1>PHP + MariaDB + Redis Example</h1>";
echo "<p>Connected to MariaDB successfully!</p>";
echo "<p>Page visits (tracked via Redis): $visits</p>";

$mysqli->close();
?>

```

De projectmap zou er als volgt uit moeten zien

<img src="/assets/opdracht5-tree.png" alt="tree" width="600">

Vereisten

- Geef het project de naam `multi-app-01` (gebruik `COMPOSE_PROJECT_NAME=multi-app-01` of `docker compose -p multi-app-01 ...`).
- Gebruik een apart bridge-netwerk met een eigen subnet (voorbeeld hieronder).
- De MariaDB service moet data persistenteren in een Docker volume.
- Mount de code (`index.php`) als een bind-mount in de webservice (geen COPY in compose; doel is dat je lokale wijzigingen direct zichtbaar zijn).
- De webservice wordt gebouwd met een `Dockerfile` (zorg dat mysqli en redis extensions aanwezig zijn). Gebruik recente, stabiele images.
- Exposeer de webservice op een hostpoort (bijv. 8080).

### STAP 1 : Dockerfile voor de webservice maken

We gaan voor de php script ons eigen Docker image maken met een Dockerfile.

```Dockerfile

FROM php:8.4.15RC1-zts-alpine3.21 


## `WORKDIR` is de directory waar de applicatie draait binnen de container. In dit geval is dat `/app`.
WORKDIR /app
## `COPY` kopieert de lokale `index.php` naar de container op de locatie `/app/index.php`.
COPY /php-site/index.php /app/index.php
## `RUN apk add --no-cache autoconf g++ make` installeert de benodigde build tools om de redis extensie te kunnen installeren. We gebruiken apk omdat we een alpine image gebruiken.
RUN apk add --no-cache autoconf g++ make
## `RUN docker-php-ext-install mysqli` installeert de mysqli extensie voor PHP. Dit is nodig om verbinding te maken met de MariaDB database.
RUN docker-php-ext-install mysqli
## `RUN pecl install redis && docker-php-ext-enable redis` installeert de redis extensie via PECL en activeert deze voor PHP. Dit is nodig om verbinding te maken met de Redis server.
RUN pecl install redis && docker-php-ext-enable redis
## `EXPOSE 8000` geeft aan dat de container luistert op poort 8000 voor inkomend verkeer.
EXPOSE 8000
## `CMD [ "php", "-S","0.0.0.0:8000", "-t", "/app" ]` start de PHP ingebouwde webserver op poort 8000 en stelt de document root in op `/app`.
## `-S` betekent dat we de ingebouwde webserver van PHP willen gebruiken.
## `-t` geeft de document root aan, oftewel de directory waar de webbestanden zich bevinden. in dit geval is dat `/app`.
## `php` geeft aan dat we het PHP commando willen uitvoeren.
CMD [ "php", "-S","0.0.0.0:8000", "-t", "/app" ]
```

We bouwen het image met het volgende commando in de directory waar de Dockerfile zich bevindt:

```bash
sudo docker build . -t opdracht5-php:0.1.0-alpha
```

- De `.` geeft aan dat de build context de huidige directory is.
- `-t opdracht5-php:0.1.0-alpha` geeft de naam en tag van de image aan die we willen maken. We kiezen voor de de officiele semver notatie.
We kunnen controleren of de image succesvol is aangemaakt met het commando `sudo docker images`.

### STAP 2 : docker-compose.yml maken

We maken nu een `docker-compose.yml` bestand aan in dezelfde directory als de Dockerfile.

```yaml
name: joey

services:
  web:
    image: opdracht5-php:0.1.0-alpha 
    ports:
      - "8005:8000"
    hostname: opdracht5-php
    depends_on:
      - redis
      - db
    environment: 
      - DB_HOST=mariadb-db ## Verwijst naar de service naam van de database in hetzelfde netwerk
      - DB_USER=joey-admin ## Gebruiker die we gebruiken om in te loggen
      - DB_PASS=53596635 ## Wachtwoord voor de database gebruiker om in te loggen
      - DB_NAME=opdracht5 ## Naam van de database die we willen gebruiken
      - REDIS_HOST=redis ## Verwijst naar de redis service in hetzelfde netwerk
      - REDIS_PORT=6379 ## Poort van de redis service
    volumes:
      - php1:/app/php-sites ## Bind mount voor de php code
    networks:
      - frontend ## Verwijst naar het netwerk dat moet worden gebruikt



  redis:
    image: redis:8.2.3-bookworm ## Image voor de redis service
    hostname: redis ## Hostname voor de redis service
    networks:
      - frontend



  db:
    image: mariadb:12.0
    hostname: mariadb-db
    volumes: mariadb:/var/lib/mysql ## Volume voor persistente data opslag
    environment:
      - MARIADB_DATABASE=opdracht5 ## Naam van de database die we willen aanmaken
      - MARIADB_RANDOM_ROOT_PASSWORD=yes ## Willekeurig root wachtwoord genereren
      - MARIADB_USER=joey-admin ## Gebruiker die we willen aanmaken
      - MARIADB_PASSWORD=53596635 ## Wachtwoord voor de gebruiker die we willen aanmaken
    networks:
      - frontend

networks:
  frontend:
    driver: bridge
    enable_ipv4: true
    enable_ipv6: false
    ipam:
      driver: default
      config:
        - subnet: 172.18.10.0/24
          ip_range: 172.18.10.0/24
          gateway: 172.18.10.1

volumes:
  php1:
  mariadb:
```

- `depends_on`: Hiermee geef je aan dat de `web` service afhankelijk is van de `redis` en `db` services. Docker Compose zorgt ervoor dat deze services eerst worden gestart voordat de `web` service wordt.

### STAP 3 : Docker Compose up

Nu kunnen we de multi-container applicatie starten met het volgende commando:

```bash
docker compose up -d ## Start de services in de achtergrond
```

We controlleren of alle containers draaien met:

```bash
docker compose ps ## Toont de status van alle services die gestart zijn via docker compose
```

## docker-compose multi-container

We hebben in de vorige opdracht een eenvoudige multi-container setup gemaakt met PHP, Redis en MariaDB. Hieronder vind je een uitgebreider voorbeeld van een `docker-compose.yml` bestand dat meerdere services bevat, waaronder een PostgreSQL database, een webapplicatie (Peppermint), een Nginx reverse proxy met Let's Encrypt ondersteuning, een MediaWiki installatie met MariaDB en Uptime Kuma voor monitoring.

### docker-compose.yml voorbeeld

```yaml
name: Multi-container setup
services:
  postgres:
    container_name: postgres
    image: postgres:18-bookworm
    env_file: docker.env ## Laad omgevingsvariabelen uit docker.env en plaats ze in de containeromgeving
    restart: unless-stopped
    volumes:
      - pgdata:/var/lib/postgresql
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_postgres_password
      POSTGRES_DB: peppermint
    secrets:
      - db_postgres_password ## Verwijst naar het secret dat we later definiëren
    networks:
      - nginx-proxy

  peppermint:
    container_name: peppermint
    image: pepperlabs/peppermint:latest
    env_file: docker.env
    restart: unless-stopped
    depends_on:
      - postgres
    environment:
      DB_HOST: "postgres"
      VIRTUAL_HOST: "helpdesk.joey-home.com"
      LETSENCRYPT_HOST: "helpdesk.joey-home.com"
      VIRTUAL_PORT: "3000"
    networks:
      - nginx-proxy

  nginx-proxy:
    container_name: nginx-proxy
    image: nginxproxy/nginx-proxy:1.9.0
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - certs:/etc/nginx/certs
      - html:/usr/share/nginx/html
      - /var/run/docker.sock:/tmp/docker.sock:ro ## Maakt communicatie met de Docker daemon mogelijk
    networks:
      - nginx-proxy

  nginx-proxy-acme:
    image: nginxproxy/acme-companion:2.6
    env_file: docker.env
    restart: unless-stopped
    depends_on:
      - nginx-proxy
    environment:
      NGINX_PROXY_CONTAINER: nginx-proxy
    volumes:
      - certs:/etc/nginx/certs
      - html:/usr/share/nginx/html
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - acme:/etc/acme.sh
    networks:
      - nginx-proxy


  mediawiki:
    image: joey-mediawiki:1.44
    env_file: docker.env
    container_name: mediawiki
    restart: unless-stopped
    environment:
      VIRTUAL_HOST: "wiki.joey-home.com"
      VIRTUAL_PORT: 80
      LETSENCRYPT_HOST: "wiki.joey-home.com"
      MEDIAWIKI_DB_HOST: "mariadb-wiki"
    volumes:
      - mediawiki:/var/www/html
      - mediawiki-data:/data
    networks:
      - nginx-proxy

  mariadb-wiki:
    image: mariadb:12.0
    env_file: docker.env
    container_name: mariadb-wiki
    restart: unless-stopped
    secrets:
      - db_mariadb_password
    environment:
      - MARIADB_DATABASE=mediawiki
      - MARIADB_RANDOM_ROOT_PASSWORD=yes
    networks:
      - nginx-proxy
    volumes:
      - mariadb-wiki:/var/lib/mysql

  uptime-kuma:
    container_name: uptime-kuma
    image: louislam/uptime-kuma:debian
    restart: unless-stopped
    environment:
      VIRTUAL_HOST: "uptime.joey-home.com"
      VIRTUAL_PORT: 3001
      LETSENCRYPT_HOST: "uptime.joey-home.com"
    networks:
      - nginx-proxy
    volumes:
      - uptime-kuma:/app/data
      - /var/run/docker.sock:/var/run/docker.sock ## Nodig voor container monitoring



networks:
  nginx-proxy:
    driver: bridge
    enable_ipv4: true
    enable_ipv6: false
    ipam:
      driver: default
      config:
        - subnet: 172.18.11.0/24
          ip_range: 172.18.11.0/24
          gateway: 172.18.11.1

volumes:
  html:
  certs:
  pgdata:
  acme:
  mariadb-wiki:
  mediawiki:
  mediawiki-data:
  uptime-kuma:
secrets:
  db_postgres_password:
    file: /home/joey/secrets/postgres/db_password.txt
  db_mariadb_password:
    file: /home/joey/secrets/mariadb/db_password.txt ## Pad naar het bestand met het wachtwoord
```

We gebruiken een apart `docker.env`-bestand om gevoelige informatie, zoals gebruikersnamen en wachtwoorden, op te slaan. Dit bestand wordt door de relevante services ingeladen via de env_file-directive. Hierdoor worden de variabelen rechtstreeks in de containeromgeving geïnjecteerd, zonder dat ze zichtbaar hoeven te zijn in het docker-compose.yml-bestand. Het nadeel is wel dat wachtwoorden via deze manier nog altijd zichtbaar zijn met het commando `docker inspect <container>`. Dus is niet zo veilig als secrets.

Dit verschilt van `.env`, dat enkel wordt gebruikt door docker-compose zelf om variabelen in het compose-bestand te vervangen, maar niet automatisch wordt doorgegeven aan containers.

### docker.env voorbeeld

```env  
MARIADB_USER=joey-admin
MARIADB_PASSWORD=Test123!
MEDIAWIKI_DB_USER=joey-admin1
MEDIAWIKI_DB_PASSWORD=Test123!
DB_USERNAME=peppermint
DB_PASSWORD=Test123!
POSTGRES_USER=peppermint
DEFAULT_EMAIL=joey@EXAMPLE.COM
```
