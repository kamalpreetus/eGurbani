import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _modeKey = "modeKey";
  static final String _scriptureKey = "scriptureKey";

  /// ------------------------------------------------------------
  /// Returns the filter preferences.
  /// ------------------------------------------------------------
  static Future<String> getValue(String dropItemType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (dropItemType == "Mode") {
      return prefs.getString(_modeKey) ?? 'en';
    } else if (dropItemType == "Scripture") {
      return prefs.getString(_scriptureKey) ?? 'en';
    } else {
      return "Invalid title...";
    }
  }


  /// ----------------------------------------------------------
  /// Saves filter preferences.
  /// ----------------------------------------------------------
  static Future<bool> setValue(String dropItemType, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (dropItemType == "Mode") {
      return prefs.setString(_modeKey, value) ?? 'en';
    } else if (dropItemType == "Scripture") {
      return prefs.setString(_scriptureKey, value) ?? 'en';
    }
  }
}