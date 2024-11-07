import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  factory SharedPreferencesService() {
    return _singleton;
  }

  SharedPreferencesService._internal();

  static final SharedPreferencesService _singleton =
      SharedPreferencesService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData<T>(String key, T value) async {
    try {
      String jsonString = jsonEncode(value);
      await _prefs.setString(key, jsonString);
    } catch (e) {
      throw Exception('Unsupported data type');
    }
  }

  T? getData<T>(String key) {
    try {
      var data = _prefs.getString(key);
      return data == null ? null : jsonDecode(data);
    } catch (e) {
      throw Exception('Unsupported data type');
    }
  }

  Future<void> clearData() async {
    await _prefs.clear();
  }

  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }
}
