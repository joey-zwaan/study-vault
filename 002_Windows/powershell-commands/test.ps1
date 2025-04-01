$csvPath = "C:\Users\joey-admin\Document\ou.csv"
$ouList = Import-Csv -Path $csvPath

# Loop through each row in the CSV and create the OUs
foreach ($ou in $ouList) {
    $ouName = $ou.OU
    $ouDN = $ou.DN

    # Check if the OU already exists
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouDN'" -ErrorAction SilentlyContinue)) {
        # Create the OU
        #New-ADOrganizationalUnit -Name $ouName -Path $ouDN -ProtectedFromAccidentalDeletion $true
        Write-Host "Created OU: $ouName in $ouDN"
    } else {
        Write-Host "OU already exists: $ouName in $ouDN"
    }
}