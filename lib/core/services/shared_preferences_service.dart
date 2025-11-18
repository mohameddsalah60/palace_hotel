import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late final SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is double) return sharedPreferences.setDouble(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    }
    return false;
  }

  static int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  static double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  static String getString(String key) {
    return sharedPreferences.getString(key) ?? '';
  }

  static List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }

  static Future<bool> remove(String key) async {
    return sharedPreferences.remove(key);
  }

  static Future<bool> clear() async {
    return sharedPreferences.clear();
  }
}
