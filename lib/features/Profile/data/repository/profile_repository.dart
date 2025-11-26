import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/features/Auth/data/repository/local_storage.dart';
import 'package:x_express/features/Profile/data/model/profile_model.dart';
import 'package:http_parser/http_parser.dart';

class ProfileRepository {
  // Get profile data
  Future<ProfileModel> getProfile() async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('${AppUrl.baseURL}profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Profile Response Status: ${response.statusCode}');
      print('Profile Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return ProfileModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load profile: ${response.body}');
      }
    } catch (e) {
      print('Profile Repository Error: $e');
      throw Exception('Failed to load profile: $e');
    }
  }

  // Upload profile image
  Future<ProfileModel> uploadProfileImage(File imageFile) async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token == null) {
        throw Exception('No authentication token found');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppUrl.baseURL}profile'),
      );

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Add image file
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'image', // field name
        stream,
        length,
        filename: imageFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);

      print('Uploading image to: ${AppUrl.baseURL}profile');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Upload Image Response Status: ${response.statusCode}');
      print('Upload Image Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        return ProfileModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to upload image: ${response.body}');
      }
    } catch (e) {
      print('Upload Image Error: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final token = await LocalStorage.getToken();
      
      if (token != null) {
        final response = await http.post(
          Uri.parse('${AppUrl.baseURL}logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        print('Logout Response Status: ${response.statusCode}');
        print('Logout Response Body: ${response.body}');

        // Clear local storage regardless of API response
        await LocalStorage.clearSession();

        if (response.statusCode == 200 || response.statusCode == 201) {
          return;
        } else {
          // Still cleared local storage, so logout is successful
          print('Logout API returned ${response.statusCode}, but local data cleared');
        }
      } else {
        // No token, just clear local storage
        await LocalStorage.clearSession();
      }
    } catch (e) {
      print('Logout Error: $e');
      // Clear local storage even if API call fails
      await LocalStorage.clearSession();
      throw Exception('Logout completed with errors: $e');
    }
  }
}


