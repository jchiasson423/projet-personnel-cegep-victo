import 'package:shared_preferences/shared_preferences.dart';

/// Service de stockage local
/// Source: https://pub.dev/packages/shared_preferences
class LocalStorage {
  /// Stockage local
  static late final SharedPreferences storage;

  /// Initialise le stockage local
  static Future<void> init() async {
    storage = await SharedPreferences.getInstance();
  }

  /// Retourne la valeur associée à la clé spécifiée
  static String? get(String key) {
    return storage.getString(key);
  }

  /// Définit la valeur associée à la clé spécifiée
  static void set(String key, String value) {
    storage.setString(key, value);
  }
}
