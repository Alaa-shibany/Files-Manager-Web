import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveUserInfo(
      String name, String email, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', name);
    prefs.setString('user_email', email);
    prefs.setString('token', token);
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('user_name');
    String? userEmail = prefs.getString('user_email');
    String? token = prefs.getString('token');

    return {
      'user_name': userName,
      'user_email': userEmail,
      'token': token,
    };
  }
}
