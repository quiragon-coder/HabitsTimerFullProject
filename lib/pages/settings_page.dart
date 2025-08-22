// lib/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers_settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(settingsNotifierProvider);
    final notifier = ref.read(settingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: ListView(
        children: [
          const _SectionHeader('Apparence'),
          DropdownTile<AppThemeMode>(
            title: 'Thème',
            value: s.themeMode,
            values: const [AppThemeMode.system, AppThemeMode.light, AppThemeMode.dark],
            labels: const ['Système', 'Clair', 'Sombre'],
            onChanged: notifier.setThemeMode,
          ),

          const Divider(height: 24),

          const _SectionHeader('Langue'),
          DropdownTile<AppLocaleMode>(
            title: 'Langue',
            value: s.localeMode,
            values: const [AppLocaleMode.system, AppLocaleMode.fr, AppLocaleMode.en],
            labels: const ['Système', 'Français', 'English'],
            onChanged: notifier.setLocaleMode,
          ),

          const Divider(height: 24),

          const _SectionHeader('Activités'),
          DropdownTile<ActivitiesSort>(
            title: 'Tri des activités',
            value: s.activitiesSort,
            values: const [ActivitiesSort.newestFirst, ActivitiesSort.oldestFirst],
            labels: const ['Plus récentes d’abord', 'Plus anciennes d’abord'],
            onChanged: notifier.setActivitiesSort,
          ),

          const Divider(height: 24),

          const _SectionHeader('Affichage & contrôle'),
          SwitchListTile(
            title: const Text('Tuiles compactes'),
            value: s.compactListTiles,
            onChanged: notifier.setCompactListTiles,
          ),
          SwitchListTile(
            title: const Text('Afficher les secondes'),
            value: s.showSecondsInBadges,
            onChanged: notifier.setShowSecondsInBadges,
          ),
          SwitchListTile(
            title: const Text('Haptique sur les contrôles'),
            value: s.hapticsOnControls,
            onChanged: notifier.setHapticsOnControls,
          ),
          SwitchListTile(
            title: const Text('Confirmer l’arrêt'),
            value: s.confirmStop,
            onChanged: notifier.setConfirmStop,
          ),
          SwitchListTile(
            title: const Text('Mini heatmap sur l’accueil'),
            value: s.showMiniHeatmapHome,
            onChanged: notifier.setShowMiniHeatmapHome,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Petit composant générique pour un ListTile + DropdownButton
class DropdownTile<T> extends StatelessWidget {
  const DropdownTile({
    super.key,
    required this.title,
    required this.value,
    required this.values,
    required this.labels,
    required this.onChanged,
  }) : assert(values.length == labels.length, 'values et labels doivent avoir la même longueur');

  final String title;
  final T value;
  final List<T> values;
  final List<String> labels;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<T>(
        value: value,
        items: List.generate(values.length, (i) {
          return DropdownMenuItem<T>(
            value: values[i],
            child: Text(labels[i]),
          );
        }),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: style),
    );
  }
}
