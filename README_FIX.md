
# Quick fix notes

This project includes:
- `flutter_localizations` (SDK) in `pubspec.yaml`
- `intl`, `fl_chart`, `shared_preferences` in dependencies
- Riverpod providers defined in `lib/providers.dart`
- Custom heatmap in `lib/widgets/heatmap.dart` (use `onDayTap:`)

## Commands to run

```bash
flutter clean
flutter pub get
dart pub cache repair   # optional if analyzer still can't find packages
flutter analyze
flutter run
```

If your IDE still shows "Target of URI doesn't exist", ensure your **Dart SDK** is the one that ships with **Flutter** (not a standalone Dart).
