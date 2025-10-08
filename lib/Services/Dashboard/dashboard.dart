import 'package:x_express/Modules/Dashboard/dashboard.dart';
import 'package:x_express/Utils/exports.dart';

import '../../Modules/agreement/agreement.dart';

class DashboardService with ChangeNotifier {
  DashboardModule? dashboard;

  Future<void> getDashboard() async {
    // if (dashboard != null) return;
    var data = await Request.reqGet('tms/dashboard');
    dashboard = DashboardModule.fromJson(data);
    print("dashbaord invetory is: ${dashboard!.inventory}");

    setCustomerCode();
    await Request.reqPost("security/users/set-token", {
      "userId": Auth.customer_id,
      "value": OneSignal.User.pushSubscription.id,
      "loginProvider": "Mobile",
      "name": "Token"
    });

    notifyListeners();
  }

  Future<void> setAccountInfo(AccountCustomerInfo customerInfo) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('customerAccountInfo', json.encode(customerInfo.toJson()));
  }

  Future<AccountCustomerInfo?> getAccountInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final customerDataString = sharedPreferences.getString('customerAccountInfo');
    if (customerDataString != null) {
      final Map<String, dynamic> customerDataMap = json.decode(customerDataString);
      return AccountCustomerInfo.fromJson(customerDataMap);
    }

    return null;
  }

  Future<void> setCustomerCode() async {
    try {
      final existingCustomerData = await getAccountInfo();
      if (existingCustomerData != null) return;
      var accountData = await Request.reqGet('cim/customers/account');
      final accountCustomerData = AccountCustomerInfo.fromJson(accountData);
      await setAccountInfo(accountCustomerData);
    } catch (e) {
      print("Error saving customer data: $e");
    }
  }
}
