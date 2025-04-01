## Active Directory

#### Vertrouwensrelatie client <--> domaincontroller

Vandaag is er het probleem geweest dat de vertrouwensrelatie tussen client en domain-controller er opeens niet meer was. Bij nader inspectie bleek dat de OU waar de computers waren verwijderd met de computer erin. Hierdoor was het niet meer mogelijk om in te loggen met een domain-admin account.

De oplossing was heel simpel eigenlijk. Je moet de hostname weten van de computer en deze dan manueel toevoegen in active directory via de server of via een management client.

```powershell
New-ADComputer -Name "WAC1" -SamAccountName "WAC1" -Path "OU=Computers,DC=zjlocal,DC=test" -Enabled $true
```

Hierna de computer herstarten en het probleem zou opgelost moeten zijn.

