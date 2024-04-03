#NAME : ExerciceDNS1.ps1
#AUTHOR : Dubart Tristan, CUB
#DATE : 03/03/2024
#
#VERSION : 1.1
#COMMENTS : Demande à l'utilisateur la zone DNS qu'il veut créer.

# Demander à l'utilisateur de saisir le nom de la zone DNS
$zoneName = Read-Host "Entrez le nom de la zone DNS (par exemple : mondomaine.com)"

# Vérifier si la zone DNS existe déjà
if (-not (Get-DnsServerZone -Name $zoneName -ErrorAction SilentlyContinue)) {
    # Demander le type de zone
    $zoneType = Read-Host "Entrez le type de zone DNS (Primaire/Secondaire/ActiveDirectoryIntegrated)"
    
    # Créer la zone DNS en fonction du type choisi
    switch ($zoneType.ToLower()) {
        "primaire" {
            Add-DnsServerPrimaryZone -Name $zoneName -ZoneFile "$zoneName.dns" -PassThru
            Write-Host "La zone DNS primaire $zoneName a été créée avec succès."
        }
        "secondaire" {
            $masterIP = Read-Host "Entrez l'adresse IP du serveur DNS maître"
            Add-DnsServerSecondaryZone -Name $zoneName -MasterServers $masterIP -PassThru
            Write-Host "La zone DNS secondaire $zoneName a été créée avec succès."
        }
        "activedirectoryintegrated" {
            Add-DnsServerPrimaryZone -Name $zoneName -ZoneFile "$zoneName.dns" -ReplicationScope "Forest" -PassThru
            Write-Host "La zone DNS Active Directory intégrée $zoneName a été créée avec succès."
        }
        default {
            Write-Host "Type de zone DNS non reconnu."
        }
    }
} else {
    Write-Host "La zone DNS $zoneName existe déjà."
}

