import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String locale = "locale";
  static const String rememberMe = "rememberMe";

  final SharedPreferences sharedPreference;

  SharedPreference(this.sharedPreference);

  setStringPreferenceValue(String key, String value) async {
    await sharedPreference.setString(key, value);
  }

  setIntPreferenceValue(String key, int value) async {
    await sharedPreference.setInt(key, value);
  }

  setBoolPreferenceValue(String key, bool value) async {
    await sharedPreference.setBool(key, value);
  }

  Future<String> getStringPreferenceValue(String key) async {
    return sharedPreference.getString(key) ?? "";
  }

  Future<int> getIntPreferenceValue(String key) async {
    return sharedPreference.getInt(key) ?? 0;
  }

  Future<bool> getBoolPreferenceValue(String key) async {
    return sharedPreference.getBool(key) ?? false;
  }

  Future removePreferenceValue(String key) async {
    await sharedPreference.remove(key);
  }
}
