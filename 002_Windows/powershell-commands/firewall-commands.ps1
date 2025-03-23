#Instellen Firewall rules via Powershell
Get-Command *Firewall*
Get-help Get-NetFirewallRule -Examples
Get-NetFirewallRule -Name *Remote* | Format-Table -AutoSize
# --> alle firewall rules met Remote in de naam

Get-NetFirewallRule | where {$_.Enabled -eq "True"} | Format-Table -AutoSize
# --> alle firewall rules die enabled zijn
Get-NetFirewallRule | where {$_.Direction -eq "Inbound"} | Format-Table -AutoSize
# --> alle inbound firewall rules
Get-NetFirewallRule | Where-Object {$_.Displayname -like "Windows Remote Management*"}  | Format-Table -AutoSize
# --> alle firewall rules met Windows Remote in de naam
Get-NetFirewallRule -Name "WINRM-HTTP-In-TCP" 
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True
# --> enable de firewall rule
Set-NetFirewallRule -Name "WINRM-HTTP-In" -Enabled True -RemoteAddress 192.168.153.10
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-NoScope" -Enabled False -RemoteAddress 192.168.153.10 -Profile Domain,Private
#--> Als je een regel zou maken kan je ook kiezen op welke Profile hij van toepassing is.

Get-NetFirewallProfile
# --> Toon de firewall profielen op een client
