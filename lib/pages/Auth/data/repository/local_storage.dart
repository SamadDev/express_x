import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  // Keys for storage
  static const String _tokenKey = 'accessToken';
  static const String _rememberMeKey = 'rememberMe';
  static const String _credentialsKey = 'credentials';

  /// Save login token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get login token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Save credentials for remember me
  static Future<void> saveCredentials({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, rememberMe);

    if (rememberMe) {
      final credentials = json.encode({
        'username': username,
        'password': password,
      });
      await prefs.setString(_credentialsKey, credentials);
    } else {
      await prefs.remove(_credentialsKey);
    }
  }

  /// Get saved credentials
  static Future<Map<String, String>?> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final credentialData = prefs.getString(_credentialsKey);

    if (credentialData != null) {
      try {
        final Map<String, dynamic> credentials = json.decode(credentialData);
        return {
          'username': credentials['username'] ?? '',
          'password': credentials['password'] ?? '',
        };
      } catch (e) {
        print('Error parsing credentials: $e');
        return null;
      }
    }
    return null;
  }

  /// Check if remember me is enabled
  static Future<bool> isRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  /// Check if user is logged in (has valid token)
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear only credentials (keep token)
  static Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_credentialsKey);
    await prefs.remove(_rememberMeKey);
  }

  /// Clear session (logout but keep credentials if remembered)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = await isRemembered();

    await prefs.remove(_tokenKey);

    if (!rememberMe) {
      await prefs.remove(_credentialsKey);
      await prefs.remove(_rememberMeKey);
    }
  }

  /// Complete logout - clear everything
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_credentialsKey);
    await prefs.remove(_rememberMeKey);
  }
}
