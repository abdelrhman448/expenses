import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {

  // Singleton instance
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;
  SharedPreferencesHelper._internal();

  static SharedPreferences? _prefs;


  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save a String value
  Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Get a String value
  String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  // Save an int value
  Future<void> saveInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Get an int value
  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  // Save a bool value
  Future<void> saveBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Get a bool value
  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  // Save a double value
  Future<void> saveDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  // Get a double value
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  // Remove a key
  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Clear all preferences
  Future<void> clear() async {
    await _prefs?.clear();
  }
}