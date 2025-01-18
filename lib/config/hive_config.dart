import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {
  static Database? _database;
  static const String dbName = 'app_database.db';

  // Database version - increment this when schema changes
  static const int _version = 1;

  // Table and column names
  static const String tableUserData = 'user_data';
  static const String tableAppSettings = 'app_settings';

  // Initialize database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _createDB(Database db, int version) async {
    // User data table
    await db.execute('''
      CREATE TABLE $tableUserData (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');

    // App settings table
    await db.execute('''
      CREATE TABLE $tableAppSettings (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
  }

  // Save methods
  static Future<void> saveString(String table, String key, String value) async {
    final db = await database;
    await db.insert(
      table,
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String> getString(String table, String key,
      {String defaultValue = ''}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'key = ?',
      whereArgs: [key],
    );

    if (maps.isEmpty) return defaultValue;
    return maps.first['value'] as String;
  }

  static Future<void> removeKey(String table, String key) async {
    final db = await database;
    await db.delete(
      table,
      where: 'key = ?',
      whereArgs: [key],
    );
  }

  static Future<void> clearTable(String table) async {
    final db = await database;
    await db.delete(table);
  }

  // User data methods
  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    required String userRole,
    required String accessToken,
    String? refreshToken,
  }) async {
    await saveString(tableUserData, 'userId', userId);
    await saveString(tableUserData, 'userName', userName);
    await saveString(tableUserData, 'userEmail', userEmail);
    await saveString(tableUserData, 'userRole', userRole);
    await saveString(tableUserData, 'accessToken', accessToken);
    if (refreshToken != null) {
      await saveString(tableUserData, 'refreshToken', refreshToken);
    }
    await saveString(tableUserData, 'isLoggedIn', 'true');
  }

  static Future<void> clearUserData() async {
    await clearTable(tableUserData);
    await saveString(tableUserData, 'isLoggedIn', 'false');
  }

  static Future<bool> isUserLoggedIn() async {
    final value =
        await getString(tableUserData, 'isLoggedIn', defaultValue: 'false');
    return value == 'true';
  }

  static Future<Map<String, String>> getUserData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableUserData);

    final userData = <String, String>{};
    for (final row in maps) {
      userData[row['key'] as String] = row['value'] as String;
    }
    return userData;
  }

  // App settings methods
  static Future<void> setThemeMode(String mode) async {
    await saveString(tableAppSettings, 'themeMode', mode);
  }

  static Future<String> getThemeMode() async {
    return getString(tableAppSettings, 'themeMode', defaultValue: 'system');
  }

  static Future<void> setLanguage(String language) async {
    await saveString(tableAppSettings, 'language', language);
  }

  static Future<String> getLanguage() async {
    return getString(tableAppSettings, 'language', defaultValue: 'en');
  }
}

// import 'package:hive_flutter/hive_flutter.dart';

// class HiveConfig {
//   static const String _boxName = 'appBox';
//   static late Box _box;

//   // Initialize Hive
//   static Future<void> init() async {
//     await Hive.initFlutter();
//     _box = await Hive.openBox(_boxName);
//   }

//   // Keys for the app data
//   static const String keyIsLoggedIn = 'isLoggedIn';
//   static const String keyUserId = 'userId';
//   static const String keyUserName = 'userName';
//   static const String keyUserEmail = 'userEmail';
//   static const String keyUserRole = 'userRole';
//   static const String keyAccessToken = 'accessToken';
//   static const String keyRefreshToken = 'refreshToken';
//   static const String keyThemeMode = 'themeMode';
//   static const String keyLanguage = 'language';

//   // Save methods
//   static Future<void> saveString(String key, String value) async {
//     await _box.put(key, value);
//   }

//   static Future<void> saveInt(String key, int value) async {
//     await _box.put(key, value);
//   }

//   static Future<void> saveBool(String key, bool value) async {
//     await _box.put(key, value);
//   }

//   static Future<void> saveDouble(String key, double value) async {
//     await _box.put(key, value);
//   }

//   static Future<void> saveStringList(String key, List<String> value) async {
//     await _box.put(key, value);
//   }

//   // Get methods
//   static String getString(String key, {String defaultValue = ''}) {
//     return _box.get(key, defaultValue: defaultValue);
//   }

//   static int getInt(String key, {int defaultValue = 0}) {
//     return _box.get(key, defaultValue: defaultValue);
//   }

//   static bool getBool(String key, {bool defaultValue = false}) {
//     return _box.get(key, defaultValue: defaultValue);
//   }

//   static double getDouble(String key, {double defaultValue = 0.0}) {
//     return _box.get(key, defaultValue: defaultValue);
//   }

//   static List<String> getStringList(String key,
//       {List<String> defaultValue = const []}) {
//     return _box.get(key, defaultValue: defaultValue).cast<String>();
//   }

//   // Remove methods
//   static Future<void> removeKey(String key) async {
//     await _box.delete(key);
//   }

//   static Future<void> clearAll() async {
//     await _box.clear();
//   }

//   // Convenience methods for user data
//   static Future<void> saveUserData({
//     required String userId,
//     required String userName,
//     required String userEmail,
//     required String userRole,
//     required String accessToken,
//     String? refreshToken,
//   }) async {
//     await saveString(keyUserId, userId);
//     await saveString(keyUserName, userName);
//     await saveString(keyUserEmail, userEmail);
//     await saveString(keyUserRole, userRole);
//     await saveString(keyAccessToken, accessToken);
//     if (refreshToken != null) {
//       await saveString(keyRefreshToken, refreshToken);
//     }
//     await saveBool(keyIsLoggedIn, true);
//   }

//   static Future<void> clearUserData() async {
//     await removeKey(keyUserId);
//     await removeKey(keyUserName);
//     await removeKey(keyUserEmail);
//     await removeKey(keyUserRole);
//     await removeKey(keyAccessToken);
//     await removeKey(keyRefreshToken);
//     await saveBool(keyIsLoggedIn, false);
//   }

//   // Check if user is logged in
//   static bool isUserLoggedIn() {
//     return getBool(keyIsLoggedIn);
//   }

//   // Get user data as map
//   static Map<String, dynamic> getUserData() {
//     return {
//       'userId': getString(keyUserId),
//       'userName': getString(keyUserName),
//       'userEmail': getString(keyUserEmail),
//       'userRole': getString(keyUserRole),
//       'accessToken': getString(keyAccessToken),
//       'refreshToken': getString(keyRefreshToken),
//     };
//   }

//   // App settings methods
//   static Future<void> setThemeMode(String mode) async {
//     await saveString(keyThemeMode, mode);
//   }

//   static String getThemeMode() {
//     return getString(keyThemeMode, defaultValue: 'system');
//   }

//   static Future<void> setLanguage(String language) async {
//     await saveString(keyLanguage, language);
//   }

//   static String getLanguage() {
//     return getString(keyLanguage, defaultValue: 'en');
//   }
// }
