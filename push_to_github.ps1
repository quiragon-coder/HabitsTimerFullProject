Param(
  [string]$ProjectPath = "C:\Users\Quiragon\Desktop\Dev\HabitsTimerFullProject",
  [string]$RepoUrl = "https://github.com/quiragon-coder/HabitsTimerFullProject.git",
  [string]$Branch = "main"
)

Write-Host "ProjectPath = $ProjectPath"
Write-Host "RepoUrl     = $RepoUrl"
Write-Host "Branch      = $Branch"

if (-not (Test-Path $ProjectPath)) {
  Write-Error "Le dossier projet n'existe pas: $ProjectPath"
  exit 1
}

Set-Location $ProjectPath

# Vérifie Git
$gitVersion = git --version 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Error "Git n'est pas installé ou pas dans le PATH."
  exit 1
}

# Crée un .gitignore Flutter si absent
$gitignore = Join-Path $ProjectPath ".gitignore"
if (-not (Test-Path $gitignore)) {
@"
.dart_tool/
.packages
.pub-cache/
build/
**/GeneratedPluginRegistrant.*
.melos_tool/
android/local.properties
android/key.properties
*.keystore
*.jks
ios/Pods/
ios/Flutter/Generated.*
*.xcworkspace
DerivedData/
.vscode/
.idea/
*.iml
*.log
"@ | Out-File -FilePath $gitignore -Encoding utf8
  Write-Host ".gitignore créé"
}

# Init Git si pas déjà fait
if (-not (Test-Path ".git")) {
  git init
  Write-Host "Repo Git initialisé"
}

git add -A
git commit -m "Initial commit - Habits Timer Project" 2>$null

git branch -M $Branch

# Configure remote
$hasOrigin = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
  git remote set-url origin $RepoUrl
  Write-Host "Remote 'origin' mis à jour"
} else {
  git remote add origin $RepoUrl
  Write-Host "Remote 'origin' ajouté"
}

# Push
Write-Host "Push vers $RepoUrl ($Branch)..."
git push -u origin $Branch
if ($LASTEXITCODE -ne 0) {
  Write-Error "Le push a échoué. Utilise un Personal Access Token GitHub comme mot de passe."
  exit 1
}

Write-Host "Push terminé avec succès !"
