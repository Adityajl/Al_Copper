// utils/session_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Save session data
  static Future<void> saveSessionData(String userId, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('role', role);
  }

  // Check session data
  static Future<Map<String, String>?> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? role = prefs.getString('role');

    if (userId != null && role != null) {
      return {'userId': userId, 'role': role};
    }
    return null;
  }

  // Clear session data
  static Future<void> clearSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('role');
  }
}