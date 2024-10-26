import 'package:shared_preferences/shared_preferences.dart';

class CashNetwork {
  static late SharedPreferences sharedPreferences;

  static Future<void> cashInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCash(
      {required String key, required String value}) async {
    await _ensureInitialized();
    return await sharedPreferences.setString(key, value);
  }

  static String getCashData({required String key}) {
    _ensureInitialized();
    return sharedPreferences.getString(key) ?? '';
  }

  static Future<bool> deleteCashItem({required String key}) async {
    await _ensureInitialized();
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearCash() async {
    await _ensureInitialized();
    return await sharedPreferences.clear();
  }

  static Future<void> _ensureInitialized() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
  }
}
