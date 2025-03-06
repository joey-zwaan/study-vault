Install-Module -Name Microsoft.OSConfig -Scope AllUsers -Repository PSGallery -Force
# --> Dit installeert de module Microsoft.OSConfig van de PowerShell Gallery voor alle gebruikers.
# --> De module is nodig om de baseline security te configureren.

Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer -Default
# --> Dit zet de gewenste configuratie van de baseline security voor een Windows Server 2022 Member Server.
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer
# --> Dit controleert of de gewenste configuratie van de baseline security voor een Windows Server 2022 Member Server correct is ingesteld.
Remove-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer
# --> Dit verwijdert de gewenste configuratie van de baseline security voor een Windows Server 2022 Member Server.

# Je hebt verschillende scenario's je hebt bijvoorbeeld ook voor een domaincontroller
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/DomainController -Default
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WS2025/MemberServer | ft Name, @{ Name = "Status"; Expression={$_.Compliance.Status} }, @{ Name = "Reason"; Expression={$_.Compliance.Reason} } -AutoSize -Wrap
# --> Dit controleert of de gewenste configuratie van de baseline security voor een Windows Server 2025 Member Server correct is ingesteld.