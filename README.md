# Habits Timer — Flutter Skeleton v0.1

## Ce que contient ce ZIP
- `pubspec.yaml` prêt avec les dépendances (Riverpod, fl_chart, Drift…).
- Arborescence `lib/` propre avec `main.dart`, `HabitsTimerApp`, écrans Home & Détails.
- Providers Riverpod de base (liste d'activités en mémoire), termes *cohérents* (Activity, Session, Pause, Goal, TimerState).
- Utilisable tel quel (sans DB) : l’app compile et affiche un écran de démarrage fonctionnel.

## Installation (PowerShell)
1. **Créer le projet Flutter (génère Android/iOS/web)** :
   ```powershell
   flutter create --org com.habitstimer --project-name habits_timer --platforms android habits_timer
   cd habits_timer
   ```
2. **Copier le contenu de ce ZIP dans le dossier du projet** (remplacer les fichiers quand demandé), en particulier :
   - remplacez `pubspec.yaml`
   - remplacez le dossier `lib/`
3. **Installer les dépendances** :
   ```powershell
   flutter pub get
   ```
4. **Lancer l’application** :
   ```powershell
   flutter run
   ```

> Note : La base SQLite/Drift sera ajoutée dans l’étape suivante. Ce squelette n’utilise pas de génération de code et compile tel quel.

## Cohérence des termes (canon)
- **Activity (Activité)** : une habitude/activité traquée (ex : Dessin).
- **Session** : une période suivie avec début/fin et pauses.
- **Pause** : interruption interne à une Session.
- **Goal (Objectif)** : heures/semaine, jours/semaine, heures/jour.
- **TimerState** : `idle`, `running`, `paused`.
- **Events** : `play`, `pause`, `resume`, `stop`.
- **Providers** : `activitiesProvider`, `activeTimerProvider`, `statsProvider`, `goalsProvider`.

## Prochaines étapes
- Intégrer Drift/SQLite (entités, DAOs) puis les providers `sessions`, `stats`, `goals`.
- Ajouter `fl_chart` sur l’écran Détails (courbes/heatmap) — paquets déjà référencés.
