## Selectie
Een PowerShell-structuur waarbij een actie pas wordt uitgevoerd wanneer of als een bepaalde conditie al dan niet is voldaan:

- Wanneer een machine bereikbaar is, schakel deze uit.
- Wanneer de schijf 90% vol is, start een opruimproces.
- Als de gebruiker een verkeerde waarde ingeeft, geef een melding.
- Schakel de gebruiker pas uit als er "ja" wordt ingegeven.

**Opbouw - IF .. THEN in PowerShell:**

```powershell
if ($true) {
    # uit te voeren actie
}

$getal=15
if ($getal -ge 10) {
    write-host "waarde is groter dan of gelijk aan 10"
}

$var = 5
if ($var -eq 6) {
    write-host "de getallen zijn gelijk"    
} else {
    write-host "de getallen zijn niet gelijk"
}
```

**Switch-structuur**
 
```powershell
$var = read-host "Wat is je leukste vak? 1: Windows 2: Linux 3: Ze zijn allemaal even leuk."
switch($var){
   1 {"Uiteraard!"}
   2 {"Kunnen we inkomen .."}
   3 {"'t Is uiteraard allemaal even leuk"}

}


```

## Iteratie

Sequentie 
- Opeenvolging van cmdlets waarbij ene kant gebruikt word als input voor een volgende.  

Selectie
- Keuzemogelijkheid

Iteratie 
- Herhalingstructuur
Bepaalde worde word x-maal herhaalt totdat een bepaalde voorwaarde is vervuld.-

## Foreach

Foreach is een herhalingstructuur
- Voor elk element in een reeks van elementen
- De beschreven acties worden uitgevoerd op elk element in de reeks 

```powershell

foreach($aaa in $bbb)

{
    # uit te voeren actie(s)
}


```
