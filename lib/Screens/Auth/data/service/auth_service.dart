import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:x_express/pages/Auth/data/model/auth_model.dart';
import 'package:x_express/pages/Auth/data/repository/auth_repository.dart';
import 'package:x_express/pages/Auth/data/repository/change_password_repository.dart';
import 'package:x_express/pages/Auth/data/repository/local_storage.dart';

class AuthService extends ChangeNotifier {
  LoginResponse? _loginResponse;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isObscure = true;
  bool _isEligible = false;

  bool _isObscureConfirm = true;
  String? _error;
  String? _userType;

  LoginResponse? get loginResponse => _loginResponse;
  bool get isEligible => _isEligible;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  TextEditingController get currentPasswordController => _currentPasswordController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;

  bool get isLoading => _isLoading;
  bool get rememberMe => _rememberMe;
  bool get isObscure => _isObscure;
  bool get isObscureConfirm => _isObscureConfirm;
  String? get error => _error;
  String? get userType => _userType;

  bool get isAuthenticated => _loginResponse != null;

  // Note: LoginResponse only contains accessToken, no user data
  // To get username, you need to fetch user data from API using the token
  String? get currentUsername => null; // User data not stored in LoginResponse

  Future<bool> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _loginResponse = await AuthRepository().login(
        username: username,
        password: password,
      );

      print("check for response is: ${_loginResponse!.toJson()}");
      if (_loginResponse != null) {
        // Save token
        if (_loginResponse!.accessToken != null) {
          await LocalStorage.saveToken(_loginResponse!.accessToken!);
        }

        // Save credentials if remember me is enabled
        await LocalStorage.saveCredentials(
          username: username,
          password: password,
          rememberMe: rememberMe,
        );
      }
      // await FetchUserType(); // Repository doesn't exist
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loginResponse = null;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool success = await ChangePasswordRepository().changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Note: User data is no longer stored locally, only token and credentials
  // To get user data, you need to fetch it from the API using the token
  Future<void> loadUserFromLocal() async {
    try {
      // Check if user has a valid token
      final hasToken = await LocalStorage.isLoggedIn();
      if (hasToken) {
        // User has token but we don't store full user data anymore
        // You should fetch user data from API if needed
        print("User has valid token, fetch user data from API if needed");
      }
    } catch (e) {
      print("error is: $e");
    }
  }

  // Note: CheckUserTypeRepository doesn't exist, commented out
  // Future<void> FetchUserType() async {
  //   try {
  //     final userTypeData = await CheckUserTypeRepository().fetchCheckUserType();
  //     _userType = userTypeData;
  //     print("check for userTypedata is: $userTypeData");
  //     print("check for userType is: $_userType");
  //   } catch (e) {
  //     print("error is: $e");
  //   }
  // }

  Future<Map<String, String>?> getSavedCredentials() async {
    return await LocalStorage.getCredentials();
  }

  Future<bool> shouldRememberCredentials() async {
    return await LocalStorage.isRemembered();
  }

  Future<void> loadSavedCredentials() async {
    final shouldRemember = await shouldRememberCredentials();
    if (shouldRemember) {
      final credentials = await getSavedCredentials();

      if (credentials != null) {
        _usernameController.text = credentials['username'] ?? '';
        _passwordController.text = credentials['password'] ?? '';
        _rememberMe = true;
      }
    }
    notifyListeners();
  }

  // Note: IsEligibleRepository doesn't exist, commented out
  // Future<bool> fetchIsEligible() async {
  //   try {
  //     final repo = IsEligibleRepository();
  //     _isEligible = await repo.fetchIsEligible();
  //     print("check for isEligible$_isEligible");
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print("error is: $e");
  //     return false;
  //   }
  // }

  @override
  void dispose() {
    _passwordController.clear();
    _usernameController.clear();
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    super.dispose();
  }

  void setRememberMe(value) {
    _rememberMe = value;
    notifyListeners();
  }

  void setObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setObscureConfirm() {
    _isObscureConfirm = !_isObscureConfirm;
    notifyListeners();
  }

  resetData() {
    _passwordController.clear();
    _usernameController.clear();
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    _rememberMe = false;
    notifyListeners();
  }

  // Delete account - clear all local data and reset service
  Future<void> deleteAccount() async {
    await LocalStorage.clearAll();
    _loginResponse = null;
    _userType = null;
    _isEligible = false;
    resetData();
    notifyListeners();
  }
}
