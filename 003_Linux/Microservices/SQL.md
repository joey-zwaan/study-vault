# SQL

## Database beheren

### Database beheer via cli

```bash
# Exporteer een database naar een SQL-bestand
mysqldump -u username -p database_name > backup.sql 
# Exporteer alle databases naar een SQL-bestand
mysqldump -u username -p --all-databases > backup.sql
mysqldump -u joey-admin -p --databases APP1 APP2 APP3 > backup.sql
# importeer een database vanuit een SQL-bestand
mysql -u username -p database_name < backup.sql
# Lijst alle databases 
mariadb -u joey-admin -p -e "SHOW DATABASES;"
```

`-e`: Voer een SQL-opdracht uit vanuit de commandoregel zonder de interactieve shell te openen.
`--databases`: Hiermee kun je meerdere databases specificeren om te exporteren in plaats van slechts één.
`--all-databases`: Exporteer alle databases in één keer.
`>`: Hiermee geef je aan dat de uitvoer naar een bestand moet worden geschreven.
`<`: Hiermee geef je aan dat de invoer vanuit een bestand moet komen.

>LET OP: Soms moet je zelf de database aanmaken en soms staat dit al in het SQL-bestand. Want als je het eerst manueel aanmaakt en dan
>importeert maar er staat in de dump ook een CREATE DATABASE statement dan krijg je een foutmelding dat de database al bestaat.

### DDL (Data Definition Language)

Instructies die de structuur van de database definiëren, zoals het aanmaken, wijzigen en verwijderen van tabellen en indexen.

Voorbeelden:

```sql
-- Maak een eenvoudige tabel
CREATE TABLE users (
  id INT,
  name VARCHAR(100)
);

-- Voeg een kolom toe
ALTER TABLE users ADD COLUMN email VARCHAR(255);

-- Verwijder de tabel
DROP TABLE users;
```

- `VARCHAR(n)`: Een tekenreeks van variabele lengte met een maximum van n tekens.
- `INT`: Een geheel getal zonder decimale punten.
- `id`: Een kolom genaamd 'id' die gehele getallen opslaat.
-

### DML (Data Manipulation Language)

Instructies die worden gebruikt om gegevens in de database te manipuleren, zoals het invoegen, bijwerken en verwijderen van records. Ook het lezen van gegevens valt hieronder.

Voorbeelden:

```sql
-- Voeg een regel toe
INSERT INTO users (id, name) VALUES (1, 'Alice');
-- Lees alle regels
SELECT * FROM users;
-- Werk een regel bij
UPDATE users SET name = 'Alice Smith' WHERE id = 1;
-- Verwijder een regel
DELETE FROM users WHERE id = 1;
-- Maak gebruiker aan
CREATE USER 'joey-admin'@'localhost' IDENTIFIED BY 'securepassword';
```

#### Data opvragen (Querying Data)

Om gegevens uit een database op te vragen, gebruik je het `SELECT` statement. Hier zijn enkele voorbeelden:

```sql
-- Selecteer alle kolommen van alle rijen in de tabel 'users'
SELECT * FROM users;
-- Selecteer specifieke kolommen 
SELECT name, email FROM users;
-- Selecteer met voorwaarde dit toont enkel de rijen waar de kolom Host gelijk is aan 'localhost'
SELECT * FROM users WHERE Host = 'localhost';
-- selecteer met voorwaarde dit toont enkel de rijen waar de kolom User gelijk is aan 'joey-admin'
SELECT Host, Password FROM user WHERE User='joey-admin';
-- Beperk het aantal resultaten
SELECT * FROM users LIMIT 10;
-- Sorteer resultaten op basis van de kolom Host in oplopende volgorde
SELECT Host FROM mysql.user ORDER BY Host ASC;
-- Sorteer resultaten op basis van de kolom Host in aflopende volgorde
SELECT Host FROM mysql.user ORDER BY Host DESC;
-- Beperk het aantal resultaten en sorteer op basis van de kolom Host in aflopende volgorde
SELECT Host FROM mysql.user ORDER BY Host DESC Limit 2;
-- Toon de resultaten in een meer leesbaar formaat
SELECT * FROM mysql.user\G
-- Toon de gebruiker met de naam 'joey-admin'
SELECT User FROM mysql.user WHERE User='joey-admin';
-- Toon de host van de gebruiker 'joey-admin'
SELECT Host FROM mysql.user WHERE User='joey-admin';
-- Toon de drivers in Brussel met een status groter dan 10 en sorteer op alfabetische volgorde van naam
SELECT dno, dname, STATUS, city FROM drivers WHERE city="Brussels" AND STATUS >10 ORDER BY dname ASC;
-- Toon de artikelen met een gewicht tussen 5 en 30, gesorteerd op artikelnummer
SELECT ano, aname, weight FROM articles WHERE weight BETWEEN 5 AND 30 ORDER BY ano ASC;
-- Toon de artikelen met specifieke artikelnummers 
SELECT ano, aname , weight FROM articles WHERE ano IN ('A1', 'A2', 'A3');
-- Toon de artikelen zonder gewicht en met locatie Brussel
SELECT aname FROM articles WHERE city ='Brussels' AND weight IS NULL;
-- Toon de artikelen met een naam die begint met B of C
SELECT * FROM articles WHERE aname LIKE 'B%' OR aname LIKE 'C%';


```

> LET OP: Bij IN kun je meerdere waarden specificeren om te filteren maar je moet ze tussen haakjes en aanhalingstekens zetten en gescheiden door komma's.

WHERE-operatoren kunnen worden gebruikt om specifieke voorwaarden te definiëren bij het opvragen van gegevens. Enkele veelgebruikte WHERE-operatoren zijn:

- `=`: Gelijk aan
- `<>`: Niet gelijk aan
- `>`: Groter dan
- `<`: Kleiner dan
- `>=`: Groter dan of gelijk aan
- `<=`: Kleiner dan of gelijk aan
- `BETWEEN`: Tussen twee waarden
- `AND`: Logische EN
- `OR`: Logische OF
- `LIKE`: Voor patroonvergelijking (vb: LIKE 'J%')
- `IN`: Voor het specificeren van meerdere waarden
  Bijvoorbeeld: `SELECT Host, User FROM mysql.user WHERE Host IN ('localhost', '127.0.0.1');` Dit beperkt de resultaten tot rijen waar de kolom Host gelijk is aan 'localhost' *of* '127.0.0.1'.
- `IS [NOT] NULL`: Controleert op (niet) null-waarden

<img src="/assets/DML-sql-voorbeeld.png" alt="DML SQL Voorbeeld">

### DCL (Data Control Language)

Instructies die de toegang tot de gegevens in de database regelen, zoals het verlenen of intrekken van gebruikersrechten.

#### Privileges toekennen / intrekken

```sql
-- Geef specifieke rechten op één database
GRANT SELECT, INSERT, UPDATE ON example_db.* TO 'username'@'localhost';

-- Geef alle rechten op één database
GRANT ALL PRIVILEGES ON example_db.* TO 'username'@'localhost';

-- Geef wereldwijde admin-rechten (gebruik met zorg)
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

-- Geef specifieke rechten op één database
GRANT DELETE, CREATE, DROP ON example_db.* TO 'username'@'localhost';

-- Intrek alle rechten
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'username'@'localhost';

-- soms nodig om wijzigingen meteen toe te passen
FLUSH PRIVILEGES;
```

#### Veelvoorkomende privilegetypen

- `SELECT` — leesrechten
- `INSERT` — rijen toevoegen
- `UPDATE` — rijen aanpassen
- `DELETE` — rijen verwijderen
- `CREATE` — databases/tables aanmaken
- `ALTER` — tabelstructuur aanpassen
- `DROP` — verwijderen van tabellen/databases
- `GRANT OPTION` — gebruiker mag privileges toekennen (gebruik met zorg)

> Let op: host-specificatie is belangrijk. `user1@localhost` en `user1@%` worden als verschillende accounts gezien.

### Terminologie

- **CRUD**: Create, Read, Update, Delete — de vier basisbewerkingen voor gegevensbeheer.
- **Statement**: Een enkele SQL-instructie die een specifieke taak uitvoert.
- **Clause / clausule**: Een onderdeel van een SQL-statement dat een specifieke functie vervult en optioneel is.
- **Query**: Een statement die een resultaat oplevert.
- **Identifier**: De naam van een database-object zoals een tabel, kolom of index.
- **Keywords**: Gereserveerde woorden in SQL die speciale betekenis hebben, zoals SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, GRANT, REVOKE.

Voorbeeld Clause:

```sql
SELECT Host, User, Password FROM mysql.user; -- Hier zijn SELECT en FROM keywords, terwijl Host, User, Password en mysql.user -- identifiers zijn.
SELECT username, email FROM TB_USERS WHERE CITY="Brugge"; -- Hier zijn SELECT, FROM en WHERE keywords, terwijl username, email, TB_USERS en CITY -- identifiers zijn.
```
