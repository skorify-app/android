import 'package:shared_preferences/shared_preferences.dart';

class AppDataStorage {
  AppDataStorage._();

  static SharedPreferencesWithCache? _prefs;
  static Future<SharedPreferencesWithCache> getPrefs() async {
    if (_prefs != null) return _prefs!;

    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{'account.full_name', 'account.email'},
      ),
    );
    return _prefs!;
  }

  static Future<dynamic> get(String key) async {
    return _prefs!.get(key);
  }

  static Future<void> set(String key, dynamic value) async {
    if (_prefs == null) return;

    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    }
  }

  static Future<void> remove(String key) async {
    await _prefs!.remove(key);
  }
}
