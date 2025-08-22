# Se placer dans le dossier du projet
Set-Location "C:\Users\Quiragon\Desktop\Dev\HabitsTimerFullProject"

# Vérifier si le repo git est déjà initialisé
if (!(Test-Path ".git")) {
    git init
}

# Ajouter le remote GitHub (forcer la mise à jour si déjà présent)
$remoteUrl = "https://github.com/quiragon-coder/HabitsTimerFullProject.git"
if (git remote get-url origin 2>$null) {
    git remote set-url origin $remoteUrl
} else {
    git remote add origin $remoteUrl
}

# Ajouter tous les fichiers
git add .

# Créer un commit (avec date/heure pour éviter doublons)
$commitMsg = "Update project - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $commitMsg

# Pousser sur la branche main
git branch -M main
git push -u origin main
