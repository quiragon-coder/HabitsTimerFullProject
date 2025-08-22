// lib/providers_settings.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// --- Enums d'app ---
enum AppThemeMode { system, light, dark }
enum AppLocaleMode { system, fr, en }
enum ActivitiesSort { newestFirst, oldestFirst }

/// --- Etat immutable des réglages ---
@immutable
class AppSettings {
  final AppThemeMode themeMode;
  final AppLocaleMode localeMode;
  final ActivitiesSort activitiesSort;
  final bool compactListTiles;
  final bool showSecondsInBadges;
  final bool hapticsOnControls;
  final bool confirmStop;
  final bool showMiniHeatmapHome;

  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.localeMode = AppLocaleMode.system,
    this.activitiesSort = ActivitiesSort.newestFirst,
    this.compactListTiles = false,
    this.showSecondsInBadges = false,
    this.hapticsOnControls = true,
    this.confirmStop = true,
    this.showMiniHeatmapHome = true,
  });

  AppSettings copyWith({
    AppThemeMode? themeMode,
    AppLocaleMode? localeMode,
    ActivitiesSort? activitiesSort,
    bool? compactListTiles,
    bool? showSecondsInBadges,
    bool? hapticsOnControls,
    bool? confirmStop,
    bool? showMiniHeatmapHome,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      localeMode: localeMode ?? this.localeMode,
      activitiesSort: activitiesSort ?? this.activitiesSort,
      compactListTiles: compactListTiles ?? this.compactListTiles,
      showSecondsInBadges: showSecondsInBadges ?? this.showSecondsInBadges,
      hapticsOnControls: hapticsOnControls ?? this.hapticsOnControls,
      confirmStop: confirmStop ?? this.confirmStop,
      showMiniHeatmapHome: showMiniHeatmapHome ?? this.showMiniHeatmapHome,
    );
  }
}

/// --- Notifier ---
class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings());

  void setThemeMode(AppThemeMode v) => state = state.copyWith(themeMode: v);
  void setLocaleMode(AppLocaleMode v) => state = state.copyWith(localeMode: v);
  void setActivitiesSort(ActivitiesSort v) => state = state.copyWith(activitiesSort: v);
  void setCompactListTiles(bool v) => state = state.copyWith(compactListTiles: v);
  void setShowSecondsInBadges(bool v) => state = state.copyWith(showSecondsInBadges: v);
  void setHapticsOnControls(bool v) => state = state.copyWith(hapticsOnControls: v);
  void setConfirmStop(bool v) => state = state.copyWith(confirmStop: v);
  void setShowMiniHeatmapHome(bool v) => state = state.copyWith(showMiniHeatmapHome: v);
}

/// --- Provider consommé par l'UI ---
final settingsNotifierProvider =
StateNotifierProvider<SettingsNotifier, AppSettings>(
      (ref) => SettingsNotifier(),
);
