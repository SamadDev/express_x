import 'package:x_express/pages/Auth/data/model/auth_model.dart';
import 'package:x_express/core/config/network/network.dart';

class AuthRepository {
  Future<LoginResponse> login({username, password}) async {
    final loginData = {
      "phone_number": username,
      "password": password,
    };
    final response = await Request.postJson('login', loginData);
    return LoginResponse.fromJson(response['data']);
  }
}
