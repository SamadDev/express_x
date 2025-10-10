import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/core/config/network/network.dart';

class ChangePasswordRepository {
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final changePasswordData = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    final response = await Request.postJson(AppUrl.changePassword, changePasswordData);

    print("🔐 Change password response: $response");

    return response["state"] == 1;
  }
}
