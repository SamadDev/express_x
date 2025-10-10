import 'package:x_express/core/config/network/network.dart';
import 'package:x_express/features/auth/data/model/auth_model.dart';

class AuthRepository {
  Future<LoginResponse> login({username, password}) async {
    final loginData = {
      "userName": username,
      "password": password,
    };
    final response = await Request.postJson('Authentication', loginData);
    return LoginResponse.fromJson(response['data']);
  }
}
