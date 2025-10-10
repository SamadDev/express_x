import 'package:x_express/core/config/constant/api.dart';
import 'package:x_express/core/config/network/network.dart';
import 'package:x_express/features/auth/data/model/auth_model.dart';

class CheckUserTypeRepository {
  Future<String> fetchCheckUserType() async {
    final response = await Request.get(AppUrl.checkUserType);
    print("check for response is: $response");
    String userType= response.isNotEmpty?"manager":"employee";
     return userType;
  }
}
