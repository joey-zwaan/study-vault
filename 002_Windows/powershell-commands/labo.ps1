#1 Indien de dag van de week overeenkomt met vandaag (bijvoorbeeld vrijdag = 5) dan toon een bericht.
get-date | Format-Table -AutoSize

$day = (Get-Date).DayOfWeek
if ($day -eq "Friday") {
    Write-Host "Het is vandaag vrijdag"
}


#2 Wanneer een server bereikbaar is (via Test-Connection) wil je een eigen gekozen bericht tonen in de console.
$server = "www.google.com"
if (Test-Connection -ComputerName $server -Count 1 -Quiet) {
    Write-Host "Server is bereikbaar"
}

#3 Herneem van hierboven maar je voegt een eigen gekozen bericht toe wanneer de server niet bereikbaar is.
$server = "www.google.com"
if (Test-Connection -ComputerName $server -Count 1 -Quiet) {
    Write-Host "Server is bereikbaar"
} else {
    Write-Host "Server is niet bereikbaar"
}

#4 Vraag een naam van een gebruiker op en geef een eigen gekozen bericht terug wanneer deze gebruik in AD gevonden wordt.
$naam = Read-Host "Geef een naam in"
if (Get-ADUser -Filter {Name -eq $naam}) {
    Write-Host "Gebruiker gevonden"
}

#5 Vraag een naam van een AD-gebruiker op. Vraag een bevestiging aan de uitvoerder van het
# script. Indien er een bevestiging werd ingegeven verwijder je de ingegeven AD gebruiker,
# indien er niet bevestigd werd verwijder je de AD-gebruiker niet. Bij beide opties geef je een
# eigen gekozen bericht terug.

$naam = Read-Host "Geef een naam in"
if (Get-ADUser -Filter {Name -eq $naam}) {
    $bevestiging = Read-Host "Ben je zeker dat je de gebruiker wilt verwijderen? (ja/nee)"
    if ($bevestiging -eq "ja") {
        Remove-ADUser -Identity $naam
        Write-Host "Gebruiker verwijderd"
    } else {
        Write-Host "Gebruiker niet verwijderd"
    }
}
    

#6 Maak een scriptje dat via de opstarttijd (te bekomen via het cmdlet Get-ComputerInfo)
# kijkt hoe lang je reeds aan het werk bent. Ben je 8 uur of langer aan het werk stuur je een
# boodschap, indien niet stuur je een boodschap om verder te werken.

# https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-operatingsystem

$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptime

if ($uptime -ge "08:00:00") {
    Write-Host "Je bent al 8 uur aan het werk"
} else {
    Write-Host "Je bent nog geen 8 uur aan het werk"
}

#1 Toon voor elk getal in de verzameling (100,200,300,400) de waarde in de console.
$verzameling = 100,200,300,400
foreach ($getal in $verzameling) {
    Write-Host $getal
}
# 2 Toon voor elk getal in de reeks 1 t.e.m. 100 de waarde van elk getal in console.

$verzameling = 1..100
foreach ($getal in $verzameling) {
    Write-Host $getal
}


#3 Toon voor elke schijf in je computer het serienummer (Tip: Voeg bijvoorbeeld 1 of
#meerdere USB-sticks toe om te testen).

$disks = Get-CimInstance Win32_DiskDrive
foreach ($disk in $disks) {
    Write-Host  $disks.model
    Write-Host  $disks.SerialNumber
}   

# https://learn.microsoft.com/en-us/windows/win32/cimwin32prov/win32-provider
# --> Om systeeminformatie te krijgen via powershell


get-date | Format-Table -AutoSize
