import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

class SettingsService {
  static const _kDailyReminder = 'daily_reminder_enabled';
  static const _kWeeklyReminder = 'weekly_reminder_enabled';

  Future<bool> getDailyReminder() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_kDailyReminder) ?? false;
  }
  Future<void> setDailyReminder(bool value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kDailyReminder, value);
  }

  Future<bool> getWeeklyReminder() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_kWeeklyReminder) ?? false;
  }

  Future<void> setWeeklyReminder(bool value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_kWeeklyReminder, value);
  }
}
