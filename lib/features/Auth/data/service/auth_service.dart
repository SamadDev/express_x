import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:x_express/features/auth/data/model/auth_model.dart';
import 'package:x_express/features/auth/data/repository/auth_repository.dart';
import 'package:x_express/features/auth/data/repository/change_password_repository.dart';
import 'package:x_express/features/auth/data/repository/check_user_type_repository.dart';
import 'package:x_express/features/auth/data/repository/local_storage.dart';

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

  // Get current user's username
  String? get currentUsername => _loginResponse?.user?.userName;

  Future<bool> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {

      // final isDeleted = await LocalStorage.isAccountDeleted();
      // if (isDeleted) {
      //   _error = "Username or password does not exist";
      //   _isLoading = false;
      //   notifyListeners();
      //   return false;
      // }

      _loginResponse = await AuthRepository().login(
        username: username,
        password: password,
      );

      print("check for response is: ${_loginResponse!.toJson()}");
      if (_loginResponse != null) {
        final jsonStr = json.encode(_loginResponse!.toJson());
        final credentialData = rememberMe
            ? json.encode({
                'username': username,
                'password': password,
              })
            : null;


        await LocalStorage.saveUserData(
          jsonData: jsonStr,
          rememberMe: rememberMe,
          credentialData: credentialData,
        );
      }
      await FetchUserType();
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

  Future<void> loadUserFromLocal() async {
    try {
      final jsonStr = await LocalStorage.getUserData();
      await LocalStorage.getUserData();
      if (jsonStr != null) {
        _loginResponse = LoginResponse.fromJson(json.decode(jsonStr));
        notifyListeners();
      }
    } catch (e) {
      print("error is: $e");
    }
  }

  Future<void> FetchUserType() async {
    try {
      final userTypeData = await CheckUserTypeRepository().fetchCheckUserType();

      _userType = userTypeData;
      print("check for userTypedata is: $userTypeData");
      print("check for userType is: $_userType");
    } catch (e) {
      print("error is: $e");
    }
  }

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

  Future<bool> sendPasswordRecoverySMS(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement API call to send password recovery SMS
      // For now, simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement API call to verify OTP
      // For now, simulate API call (accept any 6-digit code)
      await Future.delayed(const Duration(seconds: 1));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Implement API call to reset password
      // For now, simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }


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

  // Delete account - mark as deleted and reset service
  Future<void> deleteAccount() async {
    await LocalStorage.deleteAccount();
    _loginResponse = null;
    _userType = null;
    _isEligible = false;
    resetData();
    notifyListeners();
  }
}
