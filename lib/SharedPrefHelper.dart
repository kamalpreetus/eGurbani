import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _modeKey = "modeKey";
  static final String _scriptureKey = "scriptureKey";

  /// ------------------------------------------------------------
  /// Method that returns the user language code, 'en' if not set
  /// ------------------------------------------------------------
  static Future<String> getMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_modeKey) ?? 'en';
  }

  static Future<String> getScripture() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_scriptureKey) ?? 'en';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setMode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_modeKey, value);
  }

  static Future<bool> setScripture(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_scriptureKey, value);
  }
}