# Docker Compose

## Wat is Docker Compose?

Docker Compose is een tool waarmee je multi-container Docker applicaties kunt definiëren en beheren met behulp van een YAML-bestand. Hiermee kun je de services, netwerken en volumes die je applicatie nodig heeft, eenvoudig configureren en met één enkele opdracht starten, stoppen en beheren.

### Docker Compose commands

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

### Configureren van een Docker Compose bestand

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

#### Uitleg van het bestand

- `services`: Hier definieer je de verschillende services (containers) die je applicatie nodig heeft. In dit voorbeeld zijn er twee services: `web` (Nginx) en `db` (MariaDB).
- `image`: De Docker-image die gebruikt wordt voor de service.
- `ports`: Hiermee koppel je poorten van de host aan de container. In dit geval wordt poort 8888 van de host gekoppeld aan poort 80 van de Nginx-container.
- `volumes`: Deze volume maak je aan om data persistent op te slaan. Je kan dit voor meerdere services gebruiken.
- `environment`: Hiermee stel je omgevingsvariabelen in voor de container. In dit geval wordt een willekeurig root-wachtwoord gegenereerd voor de MariaDB-container.

> Bij sommige variabelen zoals MARIADB_RANDOM_ROOT_PASSWORD werkt dit alleen op de eerste keer dat je de container opstart en daarna wordt het wachtwoord niet meer getoond. Als je de container verwijdert en opnieuw aanmaakt met dezelfde volume zal de database de oude data blijven gebruiken en dus hetzelfde wachtwoord.

### Opdracht 5 — multi-app-01

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

Aanlevering (deliverables)

- `docker-compose.yml` (werkend)
- `Dockerfile` voor de webservice

Tips en best practices

- Gebruik environment variables voor DB/Redis host, user, pass, and DB name.
- Gebruik een named volume voor MariaDB data (bv. `db_data:/var/lib/mysql`).
- Gebruik `docker-php-ext-install mysqli` en `pecl install redis && docker-php-ext-enable redis` in je Dockerfile.
- Test lokaal op een apart netwerk en port-forward naar je host.

#### STAP 1 : Dockerfile voor de webservice maken

We gaan voor de php script ons eigen Docker image maken met een Dockerfile.

```Dockerfile

FROM php:8.4.15RC1-zts-alpine3.21 

WORKDIR /app

COPY /php-site/index.php /app/index.php

RUN apk add --no-cache autoconf g++ make

RUN docker-php-ext-install mysqli

RUN pecl install redis && docker-php-ext-enable redis

EXPOSE 8000

CMD [ "php", "-S","0.0.0.0:8000", "-t", "/app" ]
```

- `WORKDIR` is de directory waar de applicatie draait binnen de container. In dit geval is dat `/app`.
- `COPY` kopieert de lokale `index.php` naar de container op de locatie `/app/index.php`.
- `RUN apk add --no-cache autoconf g++ make` installeert de benodigde build tools om de redis extensie te kunnen installeren. We gebruiken apk omdat we een alpine image gebruiken.
- `RUN docker-php-ext-install mysqli` installeert de mysqli extensie voor PHP. Dit is nodig om verbinding te maken met de MariaDB database.
- `RUN pecl install redis && docker-php-ext-enable redis` installeert de redis extensie via PECL en activeert deze voor PHP. Dit is nodig om verbinding te maken met de Redis server.
- `EXPOSE 8000` geeft aan dat de container luistert op poort 8000 voor inkomend verkeer.
- `CMD [ "php", "-S","0.0.0.0:8000", "-t", "/app" ]` start de PHP ingebouwde webserver op poort 8000 en stelt de document root in op `/app`.
-S betekent dat we de ingebouwde webserver van PHP willen gebruiken.
-t geeft de document root aan, oftewel de directory waar de webbestanden zich bevinden. in dit geval is dat `/app`.
php geeft aan dat we het PHP commando willen uitvoeren.

We bouwen het image met het volgende commando in de directory waar de Dockerfile zich bevindt:

```bash
sudo docker build . -t opdracht5-php:0.1.=

De `.` geeft aan dat de build context de huidige directory is.
`-t opdracht5-php:0.1.0-alpha` geeft de naam en tag van de image aan die we willen maken. We kiezen voor de de officiele semver notatie.
We kunnen controleren of de image succesvol is aangemaakt met het commando `sudo docker images`.
