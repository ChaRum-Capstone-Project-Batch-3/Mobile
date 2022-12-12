import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? mPreferences;

  void setString(String key, String value) async {
    mPreferences = await SharedPreferences.getInstance();
    mPreferences!.setString(key, value);
  }

  void setListString(String key, List<String> value) async {
    mPreferences = await SharedPreferences.getInstance();
    mPreferences!.setStringList(key, value);
  }

  void setBool(String key, bool value) async {
    mPreferences = await SharedPreferences.getInstance();
    mPreferences!.setBool(key, value);
  }

  Future<String> getString(String key) async {
    mPreferences = await SharedPreferences.getInstance();
    String data = mPreferences!.getString(key) ?? '';
    return data;
  }

  Future<List<String>> getListString(String key) async {
    mPreferences = await SharedPreferences.getInstance();
    List<String> data = mPreferences!.getStringList(key) ?? [];
    return data;
  }

  Future<bool> getBool(String key) async {
    mPreferences = await SharedPreferences.getInstance();
    bool data = mPreferences!.getBool(key) ?? false;
    return data;
  }
}