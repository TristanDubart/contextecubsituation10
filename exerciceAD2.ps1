#NAME : ExerciceAD2.ps1
#AUTHOR : Dubart Tristan, CUB
#DATE : 03/03/2024
#
#VERSION : 1.1
#COMMENTS : Permet de créer un compte avec toutes les informations que l'utilisateur saisi.

# Importer le module Active Directory
Import-Module ActiveDirectory

# Fonction pour demander à l'utilisateur de saisir des informations utilisateur
Function SaisirInfosUtilisateur {
    $infosUtilisateur = @{}

    $infosUtilisateur["NomUtilisateur"] = Read-Host -Prompt "Entrez le nom d'utilisateur"
    $infosUtilisateur["MotDePasse"] = Read-Host -Prompt "Entrez le mot de passe" -AsSecureString
    $infosUtilisateur["NomComplet"] = Read-Host -Prompt "Entrez le nom complet de l'utilisateur"
    $infosUtilisateur["Nom"] = Read-Host -Prompt "Entrez le nom de famille de l'utilisateur"
    $infosUtilisateur["Prenom"] = Read-Host -Prompt "Entrez le prénom de l'utilisateur"
    $infosUtilisateur["Description"] = Read-Host -Prompt "Entrez la description de l'utilisateur"
    $infosUtilisateur["NomComplet"] = $infosUtilisateur["Prenom"] + " " + $infosUtilisateur["Nom"]
    $infosUtilisateur["NomComplet"] = Read-Host -Prompt "Entrez le nom complet de l'utilisateur"

    return $infosUtilisateur
}

# Saisir les informations de l'utilisateur
$infosUtilisateur = SaisirInfosUtilisateur

# Créer l'utilisateur dans Active Directory
New-ADUser -SamAccountName $infosUtilisateur["NomUtilisateur"] `
           -Name $infosUtilisateur["NomComplet"] `
           -GivenName $infosUtilisateur["Prenom"] `
           -Surname $infosUtilisateur["Nom"] `
           -Description $infosUtilisateur["Description"] `
           -AccountPassword $infosUtilisateur["MotDePasse"] `
           -Enabled $true

Write-Host "L'utilisateur $($infosUtilisateur["NomUtilisateur"]) a été créé avec succès dans Active Directory."
