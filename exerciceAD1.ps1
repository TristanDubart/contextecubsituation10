#NAME : ExerciceAD1.ps1
#AUTHOR : Dubart Tristan, CUB
#DATE : 03/03/2024
#
#VERSION : 1.1
#COMMENTS : Permet de créer une nouvelle unité d'organisation à la demande de l'utilisateur.

# Importer le module Active Directory
Import-Module ActiveDirectory

# Fonction pour demander à l'utilisateur s'il veut continuer
Function DemanderConfirmation {
    $reponse = Read-Host "Voulez-vous continuer à créer des unités d'organisation (OU) ? (O/N)"
    if ($reponse -eq "O" -or $reponse -eq "o") {
        return $true
    } elseif ($reponse -eq "N" -or $reponse -eq "n") {
        return $false
    } else {
        Write-Host "Veuillez répondre par 'O' pour Oui ou 'N' pour Non."
        DemanderConfirmation
    }
}

# Boucle pour créer des unités d'organisation (OU)
do {
    # Demander à l'utilisateur de saisir le nom de l'OU
    $nomOU = Read-Host -Prompt "Entrez le nom de l'unité d'organisation (OU) à créer"

    # Vérifier si l'OU existe déjà
    if (-not (Get-ADOrganizationalUnit -Filter {Name -eq $nomOU})) {
        # Créer l'OU
        New-ADOrganizationalUnit -Name $nomOU
        Write-Host "L'unité d'organisation '$nomOU' a été créée avec succès."
    } else {
        Write-Host "L'unité d'organisation '$nomOU' existe déjà."
    }
} while (DemanderConfirmation)

