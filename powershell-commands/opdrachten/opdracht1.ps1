# 1. Get dependend service of the service you have chosen
# 2. Get the 20 most recent entries from Get-Eventlog
# 3. Get-command of all types
# 4. Create folder called content.
# get-content to display content of txt file
# 5.  clear first & last command of powershelll afterwards delete all
# 6. Get-Alias , how can you figure out the alias for get-service
# 7. how to stop start bits service
# 8. display installed version of powershell
# 9. How to count number of aliases in current session of powershell
Get-Service WSearch -DependentServices
Get-Eventlog -LogName System -Newest 20
Get-Command -Type Cmdlet -Name "*network*"
Get-Content test1.txt
#clear history
Get-History
Clear-History -count 1
# oudste command verwijderen
Clear-History -count 1 -Newest
# nieuwste verwijderen
Clear-History
# alles verwijderen
Get-Alias -Definition Get-service
# Bits - service
get-service -name bits
Stop-Service bits
Start-Service bits
Restart-Service bits
# Powershell versie vragen
Get-Host | Select-Object Version
# Aantal Aliasen vragen
Get-Alias | Measure-Object | Select-Object Count
