#NAME : ExerciceAD2.ps1
#AUTHOR : Dubart Tristan, CUB
#DATE : 03/03/2024
#
#VERSION : 1.1
#COMMENTS : Permet de créer un compte utilisateur avec toutes les informations que l'utilisateur saisi (+ l'OU ou créer l'utilisateur + continuer ou non à créer des utilisateurs).

# Importer le module Active Directory
Import-Module ActiveDirectory

# Fonction pour demander à l'utilisateur de saisir des informations utilisateur
Function SaisirInfosUtilisateur {
    $infosUtilisateur = @{}

    $infosUtilisateur["NomUtilisateur"] = Read-Host -Prompt "Entrez le nom d'utilisateur"
    $infosUtilisateur["MotDePasse"] = Read-Host -Prompt "Entrez le mot de passe" -AsSecureString
    $infosUtilisateur["Nom"] = Read-Host -Prompt "Entrez le nom de famille de l'utilisateur"
    $infosUtilisateur["Prenom"] = Read-Host -Prompt "Entrez le prénom de l'utilisateur"
    $infosUtilisateur["Description"] = Read-Host -Prompt "Entrez la description de l'utilisateur"
    $infosUtilisateur["NomComplet"] = $infosUtilisateur["Prenom"] + " " + $infosUtilisateur["Nom"]

    return $infosUtilisateur
}

# Fonction pour demander à l'utilisateur de choisir une unité d'organisation (OU)
Function ChoisirOU {
    $OU = Read-Host -Prompt "Entrez le chemin complet de l'unité d'organisation (OU) où créer l'utilisateur (ex: 'OU=MonOU,DC=domaine,DC=com')"
    return $OU
}

# Boucle pour créer des utilisateurs
do {
    # Saisir les informations de l'utilisateur
    $infosUtilisateur = SaisirInfosUtilisateur

    # Saisir l'unité d'organisation (OU) où créer l'utilisateur
    $OU = ChoisirOU

    # Créer l'utilisateur dans Active Directory
    New-ADUser -SamAccountName $infosUtilisateur["NomUtilisateur"] `
               -Name $infosUtilisateur["NomComplet"] `
               -GivenName $infosUtilisateur["Prenom"] `
               -Surname $infosUtilisateur["Nom"] `
               -Description $infosUtilisateur["Description"] `
               -AccountPassword $infosUtilisateur["MotDePasse"] `
               -Enabled $true `
               -Path $OU

    Write-Host "L'utilisateur $($infosUtilisateur["NomUtilisateur"]) a été créé avec succès dans l'OU '$OU'."

    # Demander à l'utilisateur s'il veut continuer
    $continuer = Read-Host "Voulez-vous continuer à créer des utilisateurs ? (O/N)"
} while ($continuer -eq "O" -or $continuer -eq "o")
