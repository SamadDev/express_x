import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/core/config/network/network.dart';
import 'package:x_express/features/Auth/data/model/auth_model.dart';

class AuthRepository {
  Future<LoginResponse> login({username, password}) async {
    final loginData = {
      "phone_number": username,
      "password": password,
    };
    final response = await Request.postJson(AppUrl.login, loginData);

    // Handle different response structures
    Map<String, dynamic> responseData;
    if (response is Map<String, dynamic>) {
      // Check if response has a 'data' field
      if (response.containsKey('data') && response['data'] != null) {
        responseData = response['data'] as Map<String, dynamic>;
      } else {
        // If no 'data' field, use the response directly
        responseData = response;
      }
    } else {
      throw Exception('Invalid response format from server');
    }

    return LoginResponse.fromJson(responseData);
  }

  Future<LoginResponse> register(
      {required String username,
      required String phoneNumber,
      required String password}) async {
    final registerData = {
      "username": username,
      "phone_number": phoneNumber,
      "password": password,
    };
    final response = await Request.postJson(AppUrl.register, registerData);

    // Handle different response structures
    Map<String, dynamic> responseData;
    if (response is Map<String, dynamic>) {
      // Check if response has a 'data' field
      if (response.containsKey('data') && response['data'] != null) {
        responseData = response['data'] as Map<String, dynamic>;
      } else {
        // If no 'data' field, use the response directly
        responseData = response;
      }
    } else {
      throw Exception('Invalid response format from server');
    }

    return LoginResponse.fromJson(responseData);
  }
}
