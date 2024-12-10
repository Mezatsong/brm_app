import 'package:hive_flutter/hive_flutter.dart';

class SettingService {
  static const _boxName = 'settings';
  static Box<dynamic>? _box_;

  static const _keyAppLock = 'app_lock';
  static const _keySyncFrequency = 'sync_frequency';
  static const _keyTimeToRing = 'time_to_ring';

  static Box get _box {
    if (_box_ != null) return _box_!;

    throw Exception('Call SettingService.ensureInitialized() first');
  }

  static Future<void> ensureInitialized() async {
    if (_box_ == null) {
      // Ensure Hive is initialized
      await Hive.initFlutter();

      // Open the settings box
      _box_ = await Hive.openBox(_boxName);
    }
  }

  // static Future<void> dispose() async {
  //   await _box_?.close();
  //   _box_ = null;
  // }

  // APP LOCK

  static bool getAppLock() => _box.get(_keyAppLock, defaultValue: false);

  static Future<void> setAppLock(bool enabled) {
    return _box.put(_keyAppLock, enabled);
  }

  // Sync FREQ
  static String getSyncFrequency() {
    return _box.get(_keySyncFrequency, defaultValue: 'weekly');
  }

  static Future<void> setSyncFrequency(String value) {
    return _box.put(_keySyncFrequency, value);
  }

  // Sync FREQ
  static int getTimeToRing() {
    return _box.get(_keyTimeToRing, defaultValue: 24);
  }

  static Future<void> setTimeToRing(int hours) {
    return _box.put(_keyTimeToRing, hours);
  }
}
