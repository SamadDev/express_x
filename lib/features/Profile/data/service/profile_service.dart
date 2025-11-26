import 'dart:io';
import 'package:flutter/material.dart';
import 'package:x_express/features/Profile/data/model/profile_model.dart';
import 'package:x_express/features/Profile/data/repository/profile_repository.dart';

class ProfileService extends ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  ProfileModel? _profile;
  bool _isLoading = false;
  bool _isUploadingImage = false;
  String? _error;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isUploadingImage => _isUploadingImage;
  String? get error => _error;

  // Load profile data
  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _repository.getProfile();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      print('Load Profile Error: $e');
    }
  }

  // Upload profile image
  Future<bool> uploadProfileImage(File imageFile) async {
    _isUploadingImage = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _repository.uploadProfileImage(imageFile);
      _isUploadingImage = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isUploadingImage = false;
      notifyListeners();
      print('Upload Image Error: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _repository.logout();
      _profile = null;
      notifyListeners();
    } catch (e) {
      print('Logout Service Error: $e');
      // Still clear profile even if API fails
      _profile = null;
      notifyListeners();
      rethrow;
    }
  }

  // Clear profile data
  void clearProfile() {
    _profile = null;
    _error = null;
    notifyListeners();
  }
}


