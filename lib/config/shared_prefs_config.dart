import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsConfig {
  static late SharedPreferences _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save methods
  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  // Get methods
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  static List<String> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  // Remove methods
  static Future<void> removeKey(String key) async {
    await _prefs.remove(key);
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  // User data keys
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserId = 'userId';
  static const String keyUserName = 'userName';
  static const String keyUserEmail = 'userEmail';
  static const String keyUserRole = 'userRole';
  static const String keyAccessToken = 'accessToken';
  static const String keyRefreshToken = 'refreshToken';
  static const String keyThemeMode = 'themeMode';
  static const String keyLanguage = 'language';

  // User data methods
  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    required String userRole,
    required String accessToken,
    String? refreshToken,
  }) async {
    await saveString(keyUserId, userId);
    await saveString(keyUserName, userName);
    await saveString(keyUserEmail, userEmail);
    await saveString(keyUserRole, userRole);
    await saveString(keyAccessToken, accessToken);
    if (refreshToken != null) {
      await saveString(keyRefreshToken, refreshToken);
    }
    await saveBool(keyIsLoggedIn, true);
  }

  static Future<void> clearUserData() async {
    await removeKey(keyUserId);
    await removeKey(keyUserName);
    await removeKey(keyUserEmail);
    await removeKey(keyUserRole);
    await removeKey(keyAccessToken);
    await removeKey(keyRefreshToken);
    await saveBool(keyIsLoggedIn, false);
  }

  static bool isUserLoggedIn() {
    return getBool(keyIsLoggedIn);
  }

  static Map<String, dynamic> getUserData() {
    return {
      'userId': getString(keyUserId),
      'userName': getString(keyUserName),
      'userEmail': getString(keyUserEmail),
      'userRole': getString(keyUserRole),
      'accessToken': getString(keyAccessToken),
      'refreshToken': getString(keyRefreshToken),
    };
  }

  // App settings methods
  static Future<void> setThemeMode(String mode) async {
    await saveString(keyThemeMode, mode);
  }

  static String getThemeMode() {
    return getString(keyThemeMode, defaultValue: 'system');
  }

  static Future<void> setLanguage(String language) async {
    await saveString(keyLanguage, language);
  }

  static String getLanguage() {
    return getString(keyLanguage, defaultValue: 'en');
  }
}
