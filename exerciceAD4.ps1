#NAME : ExerciceAD4.ps1
#AUTHOR : Dubart Tristan, CUB
#DATE : 03/03/2024
#
#VERSION : 1.1
#COMMENTS : Permet de créer des comptes utilisateurs selon un fichier CSV importer.

# Chemin vers le fichier CSV contenant les noms et les logins des utilisateurs
$csvPath = "C:\chemin\vers\votre\fichier.csv"

# Lire le fichier CSV
$users = Import-Csv $csvPath

# Parcourir chaque ligne du fichier CSV
foreach ($user in $users) {
    # Extraire le nom et le login de l'utilisateur à partir du fichier CSV
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $login = $user.Login
    
    # Construire le nom complet de l'utilisateur
    $fullName = "$firstName $lastName"
    
    # Construire le nom d'utilisateur au format prenom.nom
    $username = "$firstName.$lastName"
    
    # Vérifier si l'utilisateur existe déjà dans Active Directory
    if (Get-ADUser -Filter { SamAccountName -eq $username }) {
        Write-Host "L'utilisateur $fullName ($username) existe déjà dans Active Directory."
    }
    else {
        # Créer l'utilisateur dans Active Directory
        New-ADUser -Name $fullName -SamAccountName $username -GivenName $firstName -Surname $lastName -AccountPassword (ConvertTo-SecureString "MotDePasse@123" -AsPlainText -Force) -Enabled $true -PassThru
        Write-Host "L'utilisateur $fullName ($username) a été créé avec succès dans Active Directory."
    }
}
 