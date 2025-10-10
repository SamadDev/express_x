import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {

  static const String _userDataKey = 'userData';
  static const String _credentialsKey = 'credentialData';
  static const String _rememberMeKey = 'rememberMe';
  static const String _tokenKey = 'accessToken';
  static const String _accountDeletedKey = 'accountDeleted';
  static const String _onboardingCompletedKey = 'onboardingCompleted';


  static Future<void> saveUserData({
    required String jsonData,
    required bool rememberMe,
    String? credentialData,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonData);
    await prefs.setBool(_rememberMeKey, rememberMe);

    if (rememberMe && credentialData != null) {
      await prefs.setString(_credentialsKey, credentialData);
    } else {
      await prefs.remove(_credentialsKey);
    }

    try {
      final userData = json.decode(jsonData);
      print("check user data is: $userData");
      if (userData['accessToken'] != null) {
        await prefs.setString(_tokenKey, userData['accessToken']);
      }
    } catch (e) {
      print('Error extracting token from user data: $e');
    }
  }



  static Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    print("check for userData: $prefs");
    return prefs.getString(_userDataKey);
  }


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


  // Get token for API requests
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final test = prefs.getString(_tokenKey);
    // print("check for token is: $test");
    return prefs.getString(_tokenKey);
  }


  // Check if remember me is enabled
  static Future<bool> isRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }



  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all data (complete logout)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // await prefs.remove(_userDataKey);
    // await prefs.remove(_credentialsKey);
    // await prefs.remove(_rememberMeKey);
    // await prefs.remove(_tokenKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_credentialsKey);
    await prefs.remove(_rememberMeKey);
  }

  // Clear only session data (keep credentials if remembered)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = await isRemembered();

    await prefs.remove(_userDataKey);
    await prefs.remove(_tokenKey);

    if (!rememberMe) {
      await prefs.remove(_credentialsKey);
      await prefs.remove(_rememberMeKey);
    }
  }

  // Get user info from stored data
  static Future<Map<String, dynamic>?> getUserInfo() async {
    final userData = await getUserData();
    if (userData != null) {
      try {
        final Map<String, dynamic> userDataMap = json.decode(userData);
        return userDataMap['user']; // Assuming user info is under 'user' key
      } catch (e) {
        print('Error parsing user info: $e');
        return null;
      }
    }
    return null;
  }

  // Debug method to check what's stored
  static Future<void> debugPrintStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    print('=== LocalStorage Debug ===');
    print('User Data: ${prefs.getString(_userDataKey)}');
    print('Credentials: ${prefs.getString(_credentialsKey)}');
    print('Remember Me: ${prefs.getBool(_rememberMeKey)}');
    print('Token: ${prefs.getString(_tokenKey)}');
    print('Account Deleted: ${prefs.getBool(_accountDeletedKey)}');
    print('========================');
  }

  // Mark account as deleted
  static Future<void> markAccountAsDeleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_accountDeletedKey, true);
    print('=== Account Marked as Deleted ===');
    print('Account deletion flag saved');
    print('========================');
  }

  // Check if account is deleted
  static Future<bool> isAccountDeleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_accountDeletedKey) ?? false;
  }

  // Delete account - mark as deleted and clear sensitive data
  static Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_accountDeletedKey, true);
    // Clear sensitive data but keep the deletion flag
    await prefs.remove(_userDataKey);
    await prefs.remove(_tokenKey);
    await prefs.remove(_credentialsKey);
    await prefs.remove(_rememberMeKey);
    print('=== Account Deleted ===');
    print('Account marked as deleted and sensitive data cleared');
    print('========================');
  }

  // Onboarding completion methods
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    print('=== Onboarding Completed ===');
    print('Onboarding marked as completed');
    print('========================');
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }
}
